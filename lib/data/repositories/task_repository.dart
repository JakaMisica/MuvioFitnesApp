import 'package:isar/isar.dart';
import '../datasources/isar_service.dart';
import '../models/task_item.dart';
import '../models/task_history.dart';

class TaskRepository {
  final IsarService _isarService;

  TaskRepository(this._isarService);

  // Get all tasks, sorted by sentiment (addictions first, then neutral, then good)
  Future<List<TaskItem>> getAllTasks() async {
    final isar = await _isarService.db;
    return await isar.taskItems.where().sortByOrderIndex().findAll();
  }

  // Get a stream of tasks for reactive UI
  Stream<List<TaskItem>> watchTasks() async* {
    final isar = await _isarService.db;

    await for (final _ in isar.taskItems.watchLazy(fireImmediately: true)) {
      final tasks = await isar.taskItems.where().sortBySentiment().findAll();
      yield tasks;
    }
  }

  // Create a new task
  Future<void> createTask(TaskItem task) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() => isar.taskItems.put(task));
  }

  // Update an existing task
  Future<void> updateTask(TaskItem task) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() => isar.taskItems.put(task));
  }

  // Delete a task
  Future<void> deleteTask(int id) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() => isar.taskItems.delete(id));
  }

  // Toggle task completion for today
  Future<void> completeTask(int id) async {
    final isar = await _isarService.db;
    final task = await isar.taskItems.get(id);

    if (task != null) {
      final now = DateTime.now();
      final isCompletedToday =
          task.lastCompleted != null &&
          task.lastCompleted!.year == now.year &&
          task.lastCompleted!.month == now.month &&
          task.lastCompleted!.day == now.day;

      if (isCompletedToday) {
        task.lastCompleted = null;
      } else {
        task.lastCompleted = now;
      }
      await isar.writeTxn(() => isar.taskItems.put(task));
    }
  }

  // Record task history for analytics
  Future<void> recordHistory({
    required int taskId,
    required String metricType,
    required double numericValue,
    String textValue = '',
    String notes = '',
  }) async {
    final isar = await _isarService.db;
    final history = TaskHistory(
      taskId: taskId,
      metricType: metricType,
      numericValue: numericValue,
      textValue: textValue,
      notes: notes,
    );
    await isar.writeTxn(() => isar.taskHistorys.put(history));
  }

  // Get task history for a date range
  Future<List<TaskHistory>> getTaskHistory(
    int taskId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final isar = await _isarService.db;
    var query = isar.taskHistorys.filter().taskIdEqualTo(taskId);

    if (startDate != null) {
      query = query.recordedDateGreaterThan(startDate);
    }
    if (endDate != null) {
      query = query.recordedDateLessThan(endDate);
    }

    return await query.sortByRecordedDate().findAll();
  }

  // Get all history for a task
  Future<List<TaskHistory>> getAllTaskHistory(int taskId) async {
    final isar = await _isarService.db;
    return await isar.taskHistorys
        .filter()
        .taskIdEqualTo(taskId)
        .sortByRecordedDateDesc()
        .findAll();
  }

  // Delete all history for a task (when task is deleted)
  Future<void> deleteTaskHistory(int taskId) async {
    final isar = await _isarService.db;
    final historyIds = await isar.taskHistorys
        .filter()
        .taskIdEqualTo(taskId)
        .idProperty()
        .findAll();
    await isar.writeTxn(() => isar.taskHistorys.deleteAll(historyIds));
  }

  Future<List<DateTime>> getDaysWithTasks() async {
    final isar = await _isarService.db;
    final history = await isar.taskHistorys.where().findAll();
    return history.map((h) => h.recordedDate).toList();
  }
}
