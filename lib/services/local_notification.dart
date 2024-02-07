// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tzdata;
// import 'package:timezone/timezone.dart' as tz;

// class NotificationManager {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

//   NotificationManager(this.flutterLocalNotificationsPlugin);

//   Future<void> initNotifications() async {
//     final AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('launch_background');
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//     );

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);

//     tzdata.initializeTimeZones();
//     tz.Location timeZoneLocation = tz.getLocation('Asia/Kolkata');
//     tz.setLocalLocation(timeZoneLocation);
//   }

//   Future<void> scheduleNotifications() async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       0,
//       'Ease Expense',
//       'Time to track expense',
//       _nextInstanceOf9AM(),
//       _buildNotificationDetails(),
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.time,
//     );

//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       1,
//       'Ease Expense',
//       'Time to track expense',
//       _nextInstanceOf1PM(),
//       _buildNotificationDetails(),
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.time,
//     );

//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       2,
//       'Ease Expense',
//       'Time to track expense',
//       _nextInstanceOf9PM(),
//       _buildNotificationDetails(),
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.time,
//     );
//   }

//   NotificationDetails _buildNotificationDetails() {
//     return const NotificationDetails(
//       android: AndroidNotificationDetails(
//         'your_channel_id',
//         'your_channel_name',
//         channelDescription: 'Your channel description',
//         importance: Importance.max,
//         priority: Priority.high,
//         ticker: 'ticker',
//       ),
//     );
//   }

//   tz.TZDateTime _nextInstanceOf9AM() {
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduledDate =
//         tz.TZDateTime(tz.local, now.year, now.month, now.day, 9);
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//     return scheduledDate;
//   }

//   tz.TZDateTime _nextInstanceOf1PM() {
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduledDate =
//         tz.TZDateTime(tz.local, now.year, now.month, now.day, 13);
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//     return scheduledDate;
//   }

//   tz.TZDateTime _nextInstanceOf9PM() {
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduledDate =
//         tz.TZDateTime(tz.local, now.year, now.month, now.day, 21);
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//     return scheduledDate;
//   }
// }
