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

  static Future<void> showBalanceNotification(double balanceThreshold) async {
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

    await _flutterLocalNotificationsPlugin.show(0, 'Low Balance',
        'Your balance is less than $balanceThreshold', platformChannelSpecifics,
        payload: 'balance_notification');
  }
}
