import 'package:flutter/material.dart';
import 'package:notification_demo/local_notification_service.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';

// import 'awesome_notification_service.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();

//   AwesomeNotificationService.initializeNotifications();

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       scaffoldMessengerKey: snackbarKey,
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Awesome Notifications')),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () async {
//                   AwesomeNotificationService.showNotificationWithActions();
//                 },
//                 child: const Text('Show Notification with Actions'),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   AwesomeNotificationService.scheduleNotificationWithActions();
//                 },
//                 child: const Text('Schedule Notification with Actions'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

class Snack {
  static void showSnackBar(String message) {
    final SnackBar snackBar = SnackBar(content: Text(message));
    snackbarKey.currentState?.showSnackBar(snackBar);
  }
}

// TODO: local

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: snackbarKey,
      home: Scaffold(
        appBar: AppBar(title: const Text('Local Notifications')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  LocalNotificationService.showCustomNotification();
                },
                child: const Text('Show Notification'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  LocalNotificationService.scheduleNotification();
                },
                child: const Text('Schedule Notification'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
