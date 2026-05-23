import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/coach_model.dart';
import '../../../data/repositories/coach_repository.dart';
import '../../../data/repositories/body_repository.dart';
import '../../../locator.dart';

class CoachState extends Equatable {
  final List<CoachModel> coaches;
  final int? activeCoachId;
  final bool isLoading;
  final String? error;

  const CoachState({
    this.coaches = const [],
    this.activeCoachId,
    this.isLoading = false,
    this.error,
  });

  @override
  List<Object?> get props => [coaches, activeCoachId, isLoading, error];

  CoachState copyWith({
    List<CoachModel>? coaches,
    int? activeCoachId,
    bool? isLoading,
    String? error,
  }) {
    return CoachState(
      coaches: coaches ?? this.coaches,
      activeCoachId: activeCoachId ?? this.activeCoachId,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class CoachCubit extends Cubit<CoachState> {
  final _coachRepo = locator<CoachRepository>();
  final _bodyRepo = locator<BodyRepository>();

  CoachCubit() : super(const CoachState()) {
    init();
  }

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));
    await _coachRepo.seedCoaches();
    final coaches = await _coachRepo.getAllCoaches();
    final settings = await _bodyRepo.getUserSettings();
    emit(
      state.copyWith(
        coaches: coaches,
        activeCoachId: settings.activeCoachId,
        isLoading: false,
      ),
    );
  }

  Future<void> selectCoach(int coachId) async {
    final settings = await _bodyRepo.getUserSettings();
    settings.activeCoachId = coachId;
    await _bodyRepo.saveUserSettings(settings);

    // Mark as hired locally for mock purposes
    final coach = await _coachRepo.getCoach(coachId);
    if (coach != null) {
      coach.isHired = true;
      await _coachRepo.saveCoach(coach);
    }

    final coaches = await _coachRepo.getAllCoaches();
    emit(state.copyWith(activeCoachId: coachId, coaches: coaches));
  }

  Future<void> hireCoach(int coachId) async {
    // In a real app, this would involve payment.
    // Here we just mark as hired and then select it.
    await selectCoach(coachId);
  }
}
