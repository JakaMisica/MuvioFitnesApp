import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/main_window/main_window_screen.dart';
import '../screens/workout_window/workout_window_screen.dart';
import '../screens/analytics/analytics_screen.dart';
import '../screens/tasks/tasks_screen.dart';
import '../screens/diet/diet_screen.dart';
import '../screens/sleep/sleep_screen.dart';
import '../screens/ai/ai_recommendations_screen.dart';
import '../screens/social/social_hub_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/tasks/task_cubit.dart';
import '../screens/tasks/widgets/alarm_trigger_dialog.dart';
import '../../logic/cubit/auth/auth_cubit.dart';
import '../../logic/cubit/auth/auth_state.dart';
import 'package:muvio/data/repositories/body_repository.dart';
import 'package:muvio/locator.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/onboarding/auth_screen.dart';
import '../../logic/cubit/sleep/sleep_cubit.dart';
import '../screens/sleep/alarm_trigger_screen.dart';
import '../widgets/ai_call_overlay.dart';
import '../widgets/tutorial_overlay.dart';
import '../../core/services/coach_call_service.dart';

class MainPageView extends StatefulWidget {
  const MainPageView({super.key});

  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  final PageController _pageController = PageController(initialPage: 4);
  int _activePage = 4;
  bool _isLoading = true;
  bool _needsOnboarding = false;
  bool _isHotBarVisible = false;
  Timer? _hideHotBarTimer;
  bool _isGuestModeActive = false;
  final GlobalKey _navKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _checkAppStatus();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  // GLOBAL ACTION HANDLER MOVED TO main.dart

  Future<void> _checkAppStatus() async {
    debugPrint("MainPageView: Checking app status...");
    try {
      final settings = await locator<BodyRepository>()
          .getUserSettings()
          .timeout(const Duration(seconds: 10));

      debugPrint("MainPageView: Settings loaded.");
      if (mounted) {
        setState(() {
          _needsOnboarding = !settings.isProfileComplete;
          _isGuestModeActive = settings.devPersistLogin;
          _isLoading = false;
        });

        // Coach inactivity check is handled by SocialCubit on init (once per day)
      }
    } catch (e) {
      debugPrint("MainPageView: Error or Timeout checking status: $e");
      if (mounted) {
        setState(() {
          _isLoading = false; // Move past loading anyway
        });
      }
    }

    if (_isGuestModeActive) {
      context.read<AuthCubit>().signInAnonymously(persistLocally: true);
    }
  }

  void _resetHotBarTimer() {
    _hideHotBarTimer?.cancel();
    _hideHotBarTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isHotBarVisible = false);
      }
    });
  }

  @override
  void dispose() {
    _hideHotBarTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _handleLogout() {
    setState(() {
      _isGuestModeActive = false;
      _needsOnboarding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          _handleLogout();
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          if (_isLoading) {
            return const Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: CircularProgressIndicator(color: Colors.cyanAccent),
              ),
            );
          }

          if ((authState is AuthInitial || authState is AuthFailure) &&
              !_isGuestModeActive) {
            return AuthScreen(
              onAuthComplete: () {
                _checkAppStatus();
              },
            );
          }

          if (authState is AuthLoading) {
            return const Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: CircularProgressIndicator(color: Colors.cyanAccent),
              ),
            );
          }

          if (_needsOnboarding) {
            return OnboardingScreen(
              onComplete: () {
                setState(() => _needsOnboarding = false);
              },
            );
          }

          return Scaffold(
            extendBody: true,
            body: Stack(
              children: [
                BlocListener<TaskCubit, TaskState>(
                  listenWhen: (prev, curr) =>
                      curr.triggeredTask != null &&
                      prev.triggeredTask != curr.triggeredTask,
                  listener: (context, state) {
                    if (state.triggeredTask != null) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) =>
                            AlarmTriggerDialog(task: state.triggeredTask!),
                      );
                    }
                  },
                  child: BlocListener<SleepCubit, SleepState>(
                    listenWhen: (prev, curr) =>
                        curr.alarmTriggered && !prev.alarmTriggered,
                    listener: (context, state) {
                      if (state.alarmTriggered) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          barrierColor: Colors.black.withOpacity(0.85),
                          builder: (context) => BlocProvider.value(
                            value: locator<SleepCubit>(),
                            child: const Dialog.fullscreen(
                              child: AlarmTriggerScreen(),
                            ),
                          ),
                        );
                      }
                    },
                    child: ListenableProvider<PageController>.value(
                      value: _pageController,
                      child: TutorialOverlay(
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            if (notification is ScrollUpdateNotification) {
                              if (!_isHotBarVisible) {
                                setState(() => _isHotBarVisible = true);
                              }
                              _resetHotBarTimer();
                            }
                            return false;
                          },
                          child: Stack(
                            children: [
                              PageView(
                                controller: _pageController,
                                physics: const BouncingScrollPhysics(),
                                onPageChanged: (idx) {
                                  setState(() {
                                    _activePage = idx;
                                    _isHotBarVisible = true;
                                  });
                                  _resetHotBarTimer();
                                },
                                children: [
                                  AnalyticsScreen(),
                                  SleepScreen(),
                                  DietScreen(),
                                  TasksScreen(),
                                  MainWindowScreen(),
                                  WorkoutWindowScreen(),
                                  AiRecommendationsScreen(),
                                  const SocialHubScreen(),
                                ],
                              ),
                              // --- GLOBAL AI CALL OVERLAY ---
                              StreamBuilder<CallEvent>(
                                stream: CoachCallService().callStream,
                                builder: (context, snapshot) {
                                  if (snapshot.data?.visible == true) {
                                    return Positioned.fill(
                                      child: AiCallOverlay(
                                        isOutbound:
                                            snapshot.data?.isOutbound ?? false,
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 16,
                  child: AnimatedSlide(
                    offset: _isHotBarVisible
                        ? Offset.zero
                        : const Offset(0, 1.5),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOutCubic,
                    child: _buildHotBar(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHotBar() {
    final items = [
      {'icon': Icons.analytics, 'label': 'Stats'}, // 0
      {'icon': Icons.nights_stay, 'label': 'Sleep'}, // 1
      {'icon': Icons.restaurant, 'label': 'Diet'}, // 2
      {'icon': Icons.assignment_turned_in, 'label': 'Tasks'}, // 3
      {'icon': Icons.home, 'label': 'Home'}, // 4
      {'icon': Icons.fitness_center, 'label': 'Workout'}, // 5
      {'icon': Icons.auto_awesome, 'label': 'AI'}, // 6
      {'icon': Icons.people, 'label': 'Social'}, // 7
    ];

    return Container(
      key: _navKey,
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F0F), // Solid color for 100% hide effect
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(items.length, (index) {
            final active = _activePage == index;
            final item = items[index];

            return InkWell(
              onTap: () {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
                setState(() => _isHotBarVisible = true);
                _resetHotBarTimer();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item['icon'] as IconData,
                      size: active ? 22 : 18,
                      color: active ? Colors.cyanAccent : Colors.white38,
                    ),
                    const SizedBox(height: 4),
                    if (active)
                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: Colors.cyanAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
