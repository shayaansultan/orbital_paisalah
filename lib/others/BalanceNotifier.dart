import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class BalanceNotifier {
  static final _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initNotifications() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static Future<void> showBalanceNotification(String timeFrame) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'balance_notification_channel', 'Balance Notifications',
            channelDescription: 'Notifications for low balance',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            playSound: true,
            enableVibration: true,
            icon: 'app_icon');

    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(0, 'Budget Exceeded',
        'You have exceeded $timeFrame budget', platformChannelSpecifics,
        payload: 'balance_notification');
  }

  static Future<void> showReminderNotification(String note) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'reminder_notification_channel', 'Reminder Notifications',
            channelDescription: 'Notifications for reminders',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            playSound: true,
            enableVibration: true,
            icon: 'app_icon');

    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(0, 'Reminder',
        'Reminder for $note', platformChannelSpecifics,
        payload: 'balance_notification');
  }
}
