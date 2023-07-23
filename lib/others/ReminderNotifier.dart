import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ReminderNotifier {
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

  static Future<void> checkReminders() async {
    final user = FirebaseAuth.instance.currentUser;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
    final lowerBound = today - 86400000;
    final upperBound = today + 86400000;

    final db = FirebaseDatabase.instance.ref();

    final event = await db
        .child('users/${user!.uid}/reminders')
        .orderByChild('date')
        .startAt(lowerBound)
        .endAt(upperBound)
        .once();

    if (event.snapshot.exists) {
      final reminders = event.snapshot.value;
      if (reminders != null) {
        final reminderList = reminders as Map<dynamic, dynamic>;
        reminderList.forEach((key, value) async {
          final reminder = value;
          final storedDate = reminder['date'];

          if (reminder['date'] >= lowerBound &&
              reminder['date'] <= upperBound) {
            final note = reminder['note'];
            await _showReminderNotification(note);
          }
        });
      }
    }
  }

  static Future<void> _showReminderNotification(String note) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'reminder_channel',
      'Reminder Channel',
      // 'Channel for reminders',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0,
      'Reminder',
      note,
      platformChannelSpecifics,
      payload: 'reminder',
    );
  }
}
