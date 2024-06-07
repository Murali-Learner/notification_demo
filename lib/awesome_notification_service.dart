import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:notification_demo/main.dart';

class AwesomeNotificationService {
  static void initializeNotifications() {
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
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
        ),
      ],
    );

    AwesomeNotifications().setListeners(
      onActionReceivedMethod: AwesomeNotificationService.onActionReceivedMethod,
      onNotificationCreatedMethod:
          AwesomeNotificationService.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          AwesomeNotificationService.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          AwesomeNotificationService.onDismissActionReceivedMethod,
    );
  }

  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // TODO: Your code for handling when a new notification or a schedule is created
  }

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("statement ---1");
    // TODO: Your code for handling when a new notification is displayed
  }

  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint("statement ---2");

    // TODO: receivedAction.dismissedDate --- dismissed time and date of notification
    // TODO: receivedAction.dismissedLifeCycle -- returns dismissed state of notification

    debugPrint("receivedAction.dismissedDate  ${receivedAction.dismissedDate}");
    Snack.showSnackBar(
        "notification dismissed ${receivedAction.dismissedDate!.toLocal()} ");
    debugPrint(
        "receivedAction.dismissedLifeCycle  ${receivedAction.dismissedLifeCycle}");

    // Your code goes here
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // TODO: receivedAction.actionDate!.toLocal() -- returns the action triggered time
    // TODO: receivedAction.buttonKeyInput ---- returns the input you entered in text field
    // TODO: receivedAction.buttonKeyPressed --- returns  the key of action button that you pressed

    Snack.showSnackBar(
        " your action name ${receivedAction.buttonKeyPressed} message is ${receivedAction.buttonKeyInput} ");

    debugPrint("statement ---3  ${receivedAction.buttonKeyPressed}");
    // Your code goes here

    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    // navigatorKey.currentState?.pushNamedAndRemoveUntil(
    //     '/notification-page',
    //     (route) =>
    //         (route.settings.name != '/notification-page') || route.isFirst,
    //     arguments: receivedAction);
  }

  static Future<void> showNotificationWithActions() async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Hello Awesome Notifications!',
        body: 'This is a simple notification with action buttons',
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'action_1',
          label: 'Reply',
          requireInputText: true,
          showInCompactView: true,
        ),
        NotificationActionButton(
          key: 'action_2',
          label: 'Mark As Read',
          actionType: ActionType.DismissAction,
        ),
        NotificationActionButton(
          key: 'action_3',
          label: 'Keep',
          actionType: ActionType.KeepOnTop,
          enabled: false,
          isAuthenticationRequired: true,
        ),
      ],
    );
  }

  static Future<void> scheduleNotificationWithActions() async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 11,
        channelKey: 'basic_channel',
        title: 'Scheduled Notification',
        body: 'This is a scheduled notification with action buttons',
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'action_1',
          label: 'Reply',
          requireInputText: true,
          showInCompactView: true,
        ),
        NotificationActionButton(
          key: 'action_2',
          label: 'Mark As Read',
          actionType: ActionType.DismissAction,
        ),
        NotificationActionButton(
          key: 'action_3',
          label: 'Keep',
          actionType: ActionType.KeepOnTop,
          enabled: true,
          isAuthenticationRequired: true,
        ),
      ],
      schedule: NotificationCalendar(
        // minute: DateTime.now().add(Duration(seconds: 2)).minute,
        second: DateTime.now().add(const Duration(seconds: 5)).second,
        allowWhileIdle: true,
      ),
    );
  }
}
