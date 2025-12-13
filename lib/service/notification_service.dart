import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Initialize Timezone Database
    tz.initializeTimeZones();

    // Set local timezone
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
    print('📍 Timezone set to: $timeZoneName');

    // Android Initialization
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS Initialization
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
        );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // Handle notification tap
      },
    );

    // Request Permissions (Android 13+)
    if (Platform.isAndroid) {
      final androidImplementation =
          flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();

      await androidImplementation?.requestNotificationsPermission();

      // Request Exact Alarm Permission (Android 12+)
      await androidImplementation?.requestExactAlarmsPermission();
    }
  }

  Future<void> scheduleFridayReminder() async {
    // Cancel any existing scheduled notifications to avoid duplicates
    await flutterLocalNotificationsPlugin.cancel(0);

    final nextFriday = _nextFriday();
    print('🔔 Scheduling Friday reminder for: $nextFriday');
    print('🕐 Current time: ${tz.TZDateTime.now(tz.local)}');

    // Schedule the recurring weekly notification for every Friday at 6 PM
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'It\'s Friday! 🥂',
      'Time to sip and celebrate. Open Sips now!',
      nextFriday,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'weekly_reminder',
          'Weekly Reminder',
          channelDescription: 'Reminds you to use the app on Fridays',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );

    print('✅ Friday reminder scheduled successfully!');

    await checkPendingNotificationRequests();
  }

  Future<void> checkPendingNotificationRequests() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    print('📋 PENDING NOTIFICATIONS: ${pendingNotificationRequests.length}');
    for (var notification in pendingNotificationRequests) {
      print(
        '   🆔 ID: ${notification.id}, Title: ${notification.title}, Body: ${notification.body}, Payload: ${notification.payload}',
      );
    }
    if (pendingNotificationRequests.isEmpty) {
      print('   ❌ No pending notifications found!');
    }
  }

  tz.TZDateTime _nextFriday() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    // Start with today at 6 PM
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      18, // 6 PM
      0,
      0,
    );

    // Advance to the next Friday
    int daysUntilFriday = (DateTime.friday - scheduledDate.weekday) % 7;
    scheduledDate = scheduledDate.add(Duration(days: daysUntilFriday));

    // If the calculated Friday is in the past (today is Friday but after 6 PM),
    // or if daysUntilFriday was 0 and we're past 6 PM, schedule for next Friday
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 7));
    }

    return scheduledDate;
  }

  Future<void> cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  // Test method to send a notification immediately
  Future<void> sendTestNotification() async {
    print('🧪 Sending test notification immediately...');
    await flutterLocalNotificationsPlugin.show(
      999,
      'Test Notification 🧪',
      'If you see this, notifications are working!',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'weekly_reminder_v2', // Changed channel ID
          'Weekly Reminder V2',
          channelDescription: 'Reminds you to use the app on Fridays',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
    print('✅ Test notification sent!');
  }

  // Test method to schedule a notification 1 minute from now
  Future<void> scheduleTestReminder() async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    final tz.TZDateTime scheduledTime = now.add(const Duration(minutes: 1));

    print('🧪 Scheduling test notification for 1 minute from now...');
    print('🕐 Current time: $now');
    print('⏰ Scheduled time: $scheduledTime');

    await flutterLocalNotificationsPlugin.zonedSchedule(
      998,
      'Test Reminder ⏰',
      'This notification was scheduled 1 minute ago!',
      scheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'weekly_reminder_v2', // Changed channel ID
          'Weekly Reminder V2',
          channelDescription: 'Reminds you to use the app on Fridays',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );

    print('✅ Test reminder scheduled successfully!');
    await checkPendingNotificationRequests();
  }
}
