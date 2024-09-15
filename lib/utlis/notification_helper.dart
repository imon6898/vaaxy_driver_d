import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

const String channelId = "mmhf_notification_id", channelName = "mmhf_notification_channel", channelDescription = "mmhf push notification";

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // showSimpleNotification(title: message.notification?.title ?? "mmhf", body: message.notification?.body ?? "", payload: message.data.toString());
  print("Handling a background message: ${message.messageId}");
}

class NotificationHelper {
  static Future init() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings("@mipmap/ic_launcher");
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(defaultPresentAlert: true, defaultPresentSound: true, defaultPresentBadge: true);
    // const LinuxInitializationSettings initializationSettingsLinux = LinuxInitializationSettings(defaultActionName: 'Open notification');
    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsDarwin);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: (details) {
      log("click onDidReceiveNotificationResponse: $details");
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}

Future showSimpleNotification({required title, required body, required payload}) async {
  const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
    channelId,
    channelName,
    channelDescription: channelDescription,
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
    playSound: true,
  );
  DarwinNotificationDetails iOSNotificationDetails = DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
    subtitle: body,
    sound: 'default',
  );

  NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails, iOS: iOSNotificationDetails);
  await _flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails, payload: payload);
}
