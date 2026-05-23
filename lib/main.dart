import 'dart:async';
import 'package:muvio/presentation/widgets/reward_animation_overlay.dart';
import 'package:muvio/presentation/widgets/tutorial_overlay.dart';
import 'dart:isolate';
import 'dart:ui' show IsolateNameServer;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muvio/locator.dart';
import 'package:muvio/presentation/navigation/main_page_view.dart';
import 'package:muvio/logic/cubit/tasks/task_cubit.dart';
import 'package:muvio/logic/cubit/evolution/evolution_cubit.dart';
import 'package:muvio/data/repositories/body_repository.dart';
import 'package:muvio/core/services/notification_service.dart';
import 'package:muvio/core/services/workout_foreground_service.dart';
import 'package:muvio/core/services/step_tracker_service.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'logic/cubit/workout/workout_cubit.dart';
import 'logic/cubit/ai/ai_cubit.dart';
import 'logic/cubit/diet/diet_cubit.dart';
import 'logic/cubit/auth/auth_cubit.dart';
import 'logic/cubit/social/social_cubit.dart';
import 'logic/cubit/sleep/sleep_cubit.dart';
import 'logic/cubit/coach/coach_cubit.dart';
import 'logic/cubit/auth/google_auth_stub.dart' as auth_stub;
import 'logic/cubit/auth/google_auth_mobile.dart' deferred as auth_mobile;
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/gestures.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:alarm/alarm.dart';
import 'package:window_manager/window_manager.dart';

// Enables swiping with a mouse on Windows/Desktop
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}

// ============================================================
// DIRECT ISOLATE PORT — bypasses addTaskDataCallback entirely.
// The task isolate writes to THIS port via IsolateNameServer.
// ============================================================
const String _kMuvioActionPort = 'muvio_notification_action';

// Keep these alive at top-level so they're never GC'd.
ReceivePort? _muvioActionPort;
StreamSubscription? _muvioActionSub;

void _setupDirectIsolatePort() {
  // Always remove old mapping first (handles app restart while service runs)
  IsolateNameServer.removePortNameMapping(_kMuvioActionPort);

  _muvioActionPort = ReceivePort();
  _muvioActionSub?.cancel();

  final registered = IsolateNameServer.registerPortWithName(
    _muvioActionPort!.sendPort,
    _kMuvioActionPort,
  );
  debugPrint(
    '[MAIN] Direct action port registered=$registered name=$_kMuvioActionPort',
  );

  _muvioActionSub = _muvioActionPort!.listen((data) {
    debugPrint('@@@ [ACTION PORT] received: $data (type=${data.runtimeType})');
    _routeAction(data?.toString());
  });
}

Future<void> _popAppToFront() async {
  if (kIsWeb) return;
  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    try {
      await windowManager.show();
      await windowManager.focus();
      await windowManager.setSkipTaskbar(false);
    } catch (e) {
      debugPrint('[POP] window focus err: $e');
    }
  }
}

void _routeAction(String? actionId) {
  if (actionId == null || actionId.isEmpty) return;
  final String action = actionId.split(':').first.trim();
  debugPrint('[ROUTE] action=$action full=$actionId');

  try {
    if (action == 'stop_sleep') {
      locator<SleepCubit>().handleBackgroundAction(actionId);
    } else {
      locator<WorkoutCubit>().handleBackgroundAction(actionId);
    }
  } catch (e) {
    debugPrint('[ROUTE] ERROR: $e');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // -- Initialize Firebase (Required for Social/Auth) --
  try {
    if (!kIsWeb && Platform.isWindows) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: String.fromEnvironment('FIREBASE_API_KEY'),
          appId: String.fromEnvironment('FIREBASE_APP_ID'),
          messagingSenderId: String.fromEnvironment(
            'FIREBASE_MESSAGING_SENDER_ID',
          ),
          projectId: String.fromEnvironment('FIREBASE_PROJECT_ID'),
          storageBucket: String.fromEnvironment('FIREBASE_STORAGE_BUCKET'),
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
    debugPrint("Firebase initialized successfully.");
  } catch (e) {
    debugPrint("Firebase init skipped or failed: $e");
  }

  // Platform-specific setup
  if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
    await auth_mobile.loadLibrary();
    AuthCubit.googleService = auth_mobile.getGoogleService();
    await AuthCubit.googleService.init();
  } else {
    AuthCubit.googleService = auth_stub.getGoogleService();
    await AuthCubit.googleService.init();
  }

  setupLocator();
  await NotificationService.init();
  await NotificationService.requestPermissions();

  if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
    MuvioForegroundService.init();
    // Set up our own ReceivePort BEFORE runApp so the task isolate can
    // always find it via IsolateNameServer immediately on button press.
    _setupDirectIsolatePort();
  }

  final stepTracker = locator<StepTrackerService>();
  await stepTracker.init();
  if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
    // Required for step tracking and distance (GPS)
    await stepTracker.requestPermissions();
    await stepTracker.checkLocationService();

    // Only start automatically on mobile if permissions are granted
    stepTracker.startTracking();
  }

  if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
    await Alarm.init();
  }

  if (!kIsWeb && Platform.isWindows) {
    await windowManager.ensureInitialized();
    windowManager.waitUntilReadyToShow(null, () async {
      await windowManager.setPreventClose(false); // Just being safe
    });
  }

  // Hook up alarm pop-to-front
  locator<SleepCubit>().onAlarmFired = () {
    _popAppToFront();
  };

  runApp(const MuvioProApp());
}

class MuvioProApp extends StatefulWidget {
  const MuvioProApp({super.key});

  @override
  State<MuvioProApp> createState() => _MuvioProAppState();
}

class _MuvioProAppState extends State<MuvioProApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Re-register the port when coming back from background, in case the
    // IsolateNameServer mapping was lost (Android can clear it on some OEMs).
    if (state == AppLifecycleState.resumed) {
      if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
        _setupDirectIsolatePort();
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TaskCubit()..loadTasks()),
        BlocProvider.value(value: locator<EvolutionCubit>()),
        BlocProvider.value(value: locator<WorkoutCubit>()),
        BlocProvider(create: (context) => AiCubit()),
        BlocProvider(create: (context) => DietCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider.value(value: locator<SocialCubit>()),
        BlocProvider.value(value: locator<SleepCubit>()),
        BlocProvider(create: (context) => CoachCubit()),
      ],
      child: MaterialApp(
        title: 'Muvio Fitness App',
        debugShowCheckedModeBanner: false,
        builder: (context, child) => RewardAnimationOverlay(child: child!),
        scrollBehavior: MyCustomScrollBehavior(),
        theme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.cyanAccent,
            brightness: Brightness.dark,
            primary: Colors.cyanAccent,
          ),
          useMaterial3: true,
          fontFamily: 'Orbitron',
          scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        ),
        home: (!kIsWeb && (Platform.isAndroid || Platform.isIOS))
            ? const WithForegroundTask(child: MainPageView())
            : const MainPageView(),
      ),
    );
  }
}
