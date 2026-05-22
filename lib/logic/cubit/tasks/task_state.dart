part of 'task_cubit.dart';

class TaskState extends Equatable {
  final bool isLoading;
  final List<TaskItem> tasks;
  final TaskItem? triggeredTask; // The task that just fired its alarm

  const TaskState({
    required this.isLoading,
    required this.tasks,
    this.triggeredTask,
  });

  factory TaskState.initial() {
    return const TaskState(isLoading: false, tasks: [], triggeredTask: null);
  }

  TaskState copyWith({
    bool? isLoading,
    List<TaskItem>? tasks,
    TaskItem? triggeredTask,
    bool clearTriggeredTask = false,
  }) {
    return TaskState(
      isLoading: isLoading ?? this.isLoading,
      tasks: tasks ?? this.tasks,
      triggeredTask: clearTriggeredTask
          ? null
          : (triggeredTask ?? this.triggeredTask),
    );
  }

  @override
  List<Object?> get props => [isLoading, tasks, triggeredTask];
}
