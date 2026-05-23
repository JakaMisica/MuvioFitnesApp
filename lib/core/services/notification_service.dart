import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:muvio/locator.dart';
import 'package:muvio/logic/cubit/social/social_cubit.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static bool get _isSupported =>
      !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  static Future<void> init() async {
    if (!_isSupported) return;

    try {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const DarwinInitializationSettings initializationSettingsIOS =
          DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
          );

      const InitializationSettings initializationSettings =
          InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
          );

      tz.initializeTimeZones();
      await _notificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (details) {
          if (details.id == 1001) {
            // Let the SleepCubit know the user tapped the notification
          }

          // Handle Chat Mute Action
          if (details.actionId == 'mute_action' && details.payload != null) {
            try {
              locator<SocialCubit>().toggleMute(details.payload!);
            } catch (e) {
              debugPrint('Background mute error: $e');
            }
          }
        },
      );

      if (Platform.isAndroid) {
        final androidPlugin = _notificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();

        await androidPlugin?.createNotificationChannel(
          const AndroidNotificationChannel(
            'chat_messages_channel',
            'Social Messages',
            description: 'New messages from friends and groups',
            importance: Importance.max,
            playSound: true,
            enableVibration: true,
            enableLights: true,
          ),
        );

        await androidPlugin?.createNotificationChannel(
          const AndroidNotificationChannel(
            'task_alarm_channel',
            'Task Alarms',
            description: 'Alarm notifications for tasks',
            importance: Importance.max,
            playSound: true,
            enableVibration: true,
            enableLights: true,
          ),
        );

        await androidPlugin?.createNotificationChannel(
          const AndroidNotificationChannel(
            'rest_timer_finish_channel',
            'Rest Timer Completion',
            description: 'Alerts when your rest period is finished',
            importance: Importance.max,
            playSound: true,
            enableVibration: true,
            enableLights: true,
          ),
        );

        await androidPlugin?.createNotificationChannel(
          const AndroidNotificationChannel(
            'sleep_alarm_channel',
            'Sleep Alarms',
            description: 'Loud alarm for smart wake up',
            importance: Importance.max,
            playSound: true,
            enableVibration: true,
            enableLights: true,
          ),
        );
      }
    } catch (e) {
      debugPrint('NotificationService init error: $e');
    }
  }

  static Future<void> scheduleTaskAlarm({
    required int id,
    required String title,
    required String timeStr,
  }) async {
    if (!_isSupported) return;

    try {
      final now = DateTime.now();
      final parts = timeStr.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      var scheduleDate = DateTime(now.year, now.month, now.day, hour, minute);
      if (scheduleDate.isBefore(now)) {
        scheduleDate = scheduleDate.add(const Duration(days: 1));
      }

      await _notificationsPlugin.zonedSchedule(
        id,
        'ALARM: $title',
        'Time to complete your task!',
        tz.TZDateTime.from(scheduleDate, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'task_alarm_channel',
            'Task Alarms',
            channelDescription: 'Alarm notifications for tasks',
            importance: Importance.max,
            priority: Priority.high,
            fullScreenIntent: true,
            category: AndroidNotificationCategory.alarm,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentSound: true,
            presentBadge: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } catch (e) {
      debugPrint('Error scheduling alarm: $e');
    }
  }

  static Future<void> cancelTaskAlarm(int id) async {
    if (!_isSupported) return;
    await _notificationsPlugin.cancel(id);
  }

  static Future<bool> requestPermissions() async {
    if (!_isSupported) return true;

    // Request Notification permission (Android 13+)
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    // Request Exact Alarm permission (Android 12+)
    if (Platform.isAndroid) {
      if (await Permission.scheduleExactAlarm.isDenied) {
        await Permission.scheduleExactAlarm.request();
      }
    }

    return await Permission.notification.isGranted;
  }

  static Future<void> scheduleRestTimer({
    required int durationSeconds,
    required String exerciseName,
  }) async {
    if (!_isSupported) return;

    try {
      final scheduledDate = DateTime.now().add(
        Duration(seconds: durationSeconds),
      );

      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
            'rest_timer_finish_channel',
            'Rest Timer Completion',
            channelDescription: 'Alerts when your rest period is finished',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            enableVibration: true,
            fullScreenIntent: true,
            category: AndroidNotificationCategory.alarm,
            visibility: NotificationVisibility.public,
          );

      const NotificationDetails details = NotificationDetails(
        android: androidDetails,
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      );

      await _notificationsPlugin.zonedSchedule(
        999, // Unique ID for rest timer completion
        'Rest Finished!',
        'Time for $exerciseName',
        tz.TZDateTime.from(scheduledDate, tz.local),
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {
      debugPrint('Error scheduling rest timer: $e');
    }
  }

  static Future<void> cancelRestTimer() async {
    if (!_isSupported) return;
    await _notificationsPlugin.cancel(999);
  }

  static Future<void> showTimerNotification({
    required int remainingSeconds,
    required String exerciseName,
  }) async {
    if (!_isSupported) return;

    try {
      final AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
            'rest_timer_channel',
            'Rest Timer',
            channelDescription: 'Notifications for workout rest timer',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false,
            onlyAlertOnce: true,
            ongoing: remainingSeconds > 0,
            category: AndroidNotificationCategory.alarm,
            visibility: NotificationVisibility.public,
          );

      final NotificationDetails details = NotificationDetails(
        android: androidDetails,
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      );

      final String timeStr = _formatTime(remainingSeconds);
      final String title = remainingSeconds > 0
          ? 'Resting: $timeStr'
          : 'Rest Finished!';
      final String body = remainingSeconds > 0
          ? 'Next: $exerciseName'
          : 'Get ready for $exerciseName!';

      await _notificationsPlugin.show(0, title, body, details);
    } catch (e) {
      debugPrint('Error showing notification: $e');
    }
  }

  static Future<void> cancelNotification() async {
    if (!_isSupported) return;
    try {
      await _notificationsPlugin.cancel(0);
    } catch (e) {
      debugPrint('Error cancelling notification: $e');
    }
  }

  static Future<void> showSleepAlarm() async {
    if (!_isSupported) return;

    try {
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
            'sleep_alarm_channel',
            'Sleep Alarms',
            channelDescription: 'Loud alarm for smart wake up',
            importance: Importance.max,
            priority: Priority.high,
            ongoing: true,
            autoCancel: false,
            fullScreenIntent: true,
            category: AndroidNotificationCategory.alarm,
            visibility: NotificationVisibility.public,
            audioAttributesUsage: AudioAttributesUsage.alarm,
            playSound: true,
            enableVibration: true,
          );

      const NotificationDetails details = NotificationDetails(
        android: androidDetails,
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      );

      await _notificationsPlugin.show(
        1001,
        'Wake Up!',
        'Time to start your day!',
        details,
      );
    } catch (e) {
      debugPrint('Error showing sleep alarm: $e');
    }
  }

  static Future<void> cancelSleepAlarm() async {
    if (!_isSupported) return;
    await _notificationsPlugin.cancel(1001);
  }

  static Future<void> showMessageNotification({
    required String conversationId,
    required String senderName,
    required String text,
    bool isGroup = false,
  }) async {
    if (!_isSupported) return;

    try {
      // Use conversationId as a numeric seed for unique notification ID
      final int notificationId = conversationId.hashCode;

      final AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
            'chat_messages_channel',
            'Social Messages',
            channelDescription: 'New messages from friends and groups',
            importance: Importance.max,
            priority: Priority.high,
            category: AndroidNotificationCategory.message,
            styleInformation: BigTextStyleInformation(
              text,
              contentTitle: isGroup ? '$senderName (GROUP)' : senderName,
              summaryText: isGroup ? 'Group Message' : 'New Message',
            ),
            actions: <AndroidNotificationAction>[
              AndroidNotificationAction(
                'mute_action',
                isGroup ? 'Mute Group' : 'Mute Friend',
                icon: const DrawableResourceAndroidBitmap(
                  '@mipmap/ic_launcher',
                ),
                showsUserInterface: false, // Mute in background!
                cancelNotification: true,
              ),
            ],
          );

      final NotificationDetails details = NotificationDetails(
        android: androidDetails,
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          categoryIdentifier: 'chat_messages',
        ),
      );

      await _notificationsPlugin.show(
        notificationId,
        isGroup ? '$senderName in group' : senderName,
        text,
        details,
        payload: conversationId,
      );
    } catch (e) {
      debugPrint('Error showing chat notification: $e');
    }
  }

  static String _formatTime(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}
