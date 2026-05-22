import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:biofit_pro/locator.dart';
import 'package:biofit_pro/data/repositories/workout_repository.dart';
import 'package:flutter/foundation.dart';

class StepTrackerService {
  final WorkoutRepository _repository = locator<WorkoutRepository>();
  
  StreamSubscription<StepCount>? _stepCountSubscription;
  StreamSubscription<Position>? _positionSubscription;
  
  int _todayBaseSteps = 0;
  int _lastTotalSteps = 0;
  double _todayDistance = 0.0;
  Position? _lastPosition;

  bool _isTracking = false;

  Future<void> init() async {
    // Initial load from Isar
    final workout = await _repository.getWorkoutForDate(DateTime.now());
    if (workout != null) {
      _todayDistance = workout.distanceMeters;
      // Note: we don't know the base steps yet until pedometer emits first value
    }
  }

  Future<bool> requestPermissions() async {
    final activityStatus = await Permission.activityRecognition.request();
    final locationStatus = await Permission.location.request();
    
    return activityStatus.isGranted && locationStatus.isGranted;
  }

  Future<bool> checkLocationService() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Prompt user to enable location services
      serviceEnabled = await Geolocator.openLocationSettings();
      // After returning from settings, check again
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
    }
    return serviceEnabled;
  }

  void startTracking() {
    if (_isTracking) return;
    _isTracking = true;

    // Pedometer tracking
    _stepCountSubscription = Pedometer.stepCountStream.listen(
      _onStepCount,
      onError: (error) => debugPrint('StepTracker: Pedometer Error: $error'),
    );

    // Location/Distance tracking
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5, // Update every 5 meters
    );
    
    _positionSubscription = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      _onPositionUpdate,
      onError: (error) => debugPrint('StepTracker: Geolocator Error: $error'),
    );
  }

  void stopTracking() {
    _stepCountSubscription?.cancel();
    _positionSubscription?.cancel();
    _isTracking = false;
  }

  void _onStepCount(StepCount event) async {
    // Pedometer gives total steps since last boot
    if (_todayBaseSteps == 0) {
      // First event of the day/session
      // We need to know how many steps were already recorded in our database for today
      final workout = await _repository.getWorkoutForDate(DateTime.now());
      int dbSteps = workout?.steps ?? 0;
      
      _todayBaseSteps = event.steps - dbSteps;
    }

    int currentSteps = event.steps - _todayBaseSteps;
    if (currentSteps < 0) {
      // Boot happened during the day
      _todayBaseSteps = event.steps;
      currentSteps = 0;
    }

    if (currentSteps != _lastTotalSteps) {
      _lastTotalSteps = currentSteps;
      await _updateDatabase();
    }
  }

  void _onPositionUpdate(Position position) async {
    if (_lastPosition != null) {
      double distance = Geolocator.distanceBetween(
        _lastPosition!.latitude,
        _lastPosition!.longitude,
        position.latitude,
        position.longitude,
      );
      
      // Filter out GPS jitter
      if (distance > 1.0 && distance < 100.0) {
        _todayDistance += distance;
        await _updateDatabase();
      }
    }
    _lastPosition = position;
  }

  final _updateController = StreamController<void>.broadcast();
  Stream<void> get updateStream => _updateController.stream;

  Future<void> _updateDatabase() async {
    // Notify UI immediately (optimistic update)
    _updateController.add(null);

    try {
      final now = DateTime.now();
      // We don't await here to avoid blocking next updates or stream emission
      _repository.updateStepsAndDistance(
        now,
        _lastTotalSteps,
        _todayDistance,
      ).catchError((e) => debugPrint('StepTracker: DB Update Error: $e'));
    } catch (e) {
      debugPrint('StepTracker: Error: $e');
    }
  }

  int get currentSteps => _lastTotalSteps;
  double get currentDistance => _todayDistance;

  void dispose() {
    stopTracking();
    _updateController.close();
  }
}
