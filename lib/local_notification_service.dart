import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_demo/main.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await _configureLocalTimeZone();

    // Define Android initialization settings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Define initialization settings
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    // Initialize the plugin with callback
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        debugPrint(
            "onDidReceiveNotificationResponse actionId ${notificationResponse.actionId}\n id ${notificationResponse.id} \n input ${notificationResponse.input}");
        Snack.showSnackBar(
            "actionId ${notificationResponse.actionId}\n id ${notificationResponse.id} \n input ${notificationResponse.input} ");
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  static void notificationTapBackground(
      NotificationResponse notificationResponse) {
    debugPrint(
        "notificationTapBackground \n actionId ${notificationResponse.actionId}\n id ${notificationResponse.id} \n input ${notificationResponse.input}");

    Snack.showSnackBar(
        "actionId ${notificationResponse.actionId}\n id ${notificationResponse.id} \n input ${notificationResponse.input} ");
  }

  static Future<void> _configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  static Future<void> showCustomNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'custom_channel', // id
      'Custom Notification', // title
      actions: [
        AndroidNotificationAction(
          'reply_action',
          "Reply",
          titleColor: Colors.blue,
          // allowGeneratedReplies: true,
          showsUserInterface: true,
          inputs: [
            AndroidNotificationActionInput(
              choices: ["hi", 'hello', 'hey'],
              allowFreeFormInput: true,
            ),
          ],
        ),
        AndroidNotificationAction(
          'dismiss_action',
          "Dismiss",
          titleColor: Colors.red,
          // allowGeneratedReplies: true,
          // showsUserInterface: false,
          cancelNotification: true,
        ),
      ],
      ongoing: false,
      autoCancel: true,
      enableVibration: true,
      fullScreenIntent: false,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0,
      'New Message',
      'You have a new message!',
      platformChannelSpecifics,
      payload: 'Custom_Sound',
    );
  }

  static Future<void> scheduleNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'custom_channel', // id
      'Custom Notification', // title
      importance: Importance.high,
      priority: Priority.high,
      ongoing: false,
      autoCancel: true,
      enableVibration: true,
      fullScreenIntent: false,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Schedule notification with a delay of 5 seconds
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      5,
      "New Message",
      "You received a new Scheduled message",
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
