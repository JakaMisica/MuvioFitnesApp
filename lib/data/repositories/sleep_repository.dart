import 'package:isar/isar.dart';
import '../datasources/isar_service.dart';
import '../models/sleep_models.dart';

class SleepRepository {
  final IsarService _isarService;

  SleepRepository(this._isarService);

  Future<SleepSession?> getLatestSession() async {
    final isar = await _isarService.db;
    return await isar.sleepSessions.where().sortByStartTimeDesc().findFirst();
  }

  Future<List<SleepSession>> getAllSessions() async {
    final isar = await _isarService.db;
    return await isar.sleepSessions.where().sortByStartTimeDesc().findAll();
  }

  Future<void> saveSession(SleepSession session) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.sleepSessions.put(session);
    });
  }

  Future<SleepSession?> getSessionByDate(DateTime date) async {
    final isar = await _isarService.db;
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    return await isar.sleepSessions
        .filter()
        .startTimeGreaterThan(startOfDay)
        .startTimeLessThan(endOfDay)
        .findFirst();
  }

  Future<List<DateTime>> getDaysWithSleep() async {
    final isar = await _isarService.db;
    final sessions = await isar.sleepSessions.where().findAll();
    return sessions.map((s) => s.startTime).toList();
  }

  Future<SleepSettings> getSettings() async {
    final isar = await _isarService.db;
    final settings = await isar.sleepSettings.where().findFirst();
    if (settings != null) return settings;

    // Create and save default if none
    final newSettings = SleepSettings()..id = 0;
    await saveSettings(newSettings);
    return newSettings;
  }

  Future<void> saveSettings(SleepSettings settings) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.sleepSettings.put(settings);
    });
  }
}
