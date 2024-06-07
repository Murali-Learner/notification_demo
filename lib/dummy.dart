import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  AwesomeNotifications().initialize(
    '',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        playSound: true,
        onlyAlertOnce: true,
        groupAlertBehavior: GroupAlertBehavior.Children,
        importance: NotificationImportance.High,
        defaultPrivacy: NotificationPrivacy.Private,
        defaultColor: Colors.deepPurple,
      ),
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Awesome Notifications'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // if (WidgetsBinding.instance.lifecycleState ==
                //     AppLifecycleState.detached)
                {
                  AwesomeNotifications().createNotification(
                    actionButtons: [
                      NotificationActionButton(
                          key: "Cancel", label: "Click", requireInputText: true)
                    ],
                    content: NotificationContent(
                      criticalAlert: true,
                      id: 10,
                      channelKey: 'basic_channel',
                      title: 'Scheduled Message',
                      body: 'This is a scheduled message!',
                    ),
                    schedule: NotificationCalendar(
                      // minute: DateTime.now().add(Duration(seconds: 2)).minute,
                      second:
                          DateTime.now().add(const Duration(seconds: 8)).second,
                      allowWhileIdle: true,
                    ),
                  );
                }
              },
              child: const Text('Schedule Notification'),
            ),
            ElevatedButton(
              onPressed: () {
                AwesomeNotifications().createNotification(
                  actionButtons: [
                    NotificationActionButton(
                        key: "done", label: "click", requireInputText: true)
                  ],
                  content: NotificationContent(
                    id: 10,
                    channelKey: 'basic_channel',
                    displayOnBackground: true,
                    displayOnForeground: true,
                    title: 'Message form Sai',
                    body: 'You recieved a message form sai',
                    bigPicture: "This is the misson",
                  ),
                );
              },
              child: const Text('Send Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
