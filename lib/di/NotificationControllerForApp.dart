import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:vaaxy_driver/utlis/notification_helper.dart';
import 'package:vaaxy_driver/utlis/pref/pref.dart';

class NotificationControllerForApp extends GetxController with StateMixin<List<MapEntry<String, dynamic>>> {
  RxMap<String, dynamic> notificationsMap = <String, dynamic>{}.obs;

  @override
  void onInit() {
    _askNotificationPermission();

    _initFcmChannel();

    //_initFcmLocalChannel();

    _setForegroundNotification();

    _getInitialMessage();

    _receivedMessage();

    _onMessageOpenedApp();

    _getSharedPrefValue();

    super.onInit();
  }

  void deleteNotification(String key) {
    notificationsMap.remove(key);
    notificationsMap.refresh();
    update();
    Pref.setObject(Pref.notifications, notificationsMap);
    _getSharedPrefValue();
  }

  void _getSharedPrefValue() {
    notificationsMap.addAll(Pref.getObject(Pref.notifications) ?? {});
    change(notificationsMap.entries.toList(), status: RxStatus.success());
  }

  void _onMessageOpenedApp() => FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
        if (message != null) {
          if (message.notification != null) {
            _saveSharedPrefValue(message);
            _getSharedPrefValue();

            // Get.toNamed(AppRoute.notification);
          }
        }
      });

  void _receivedMessage() => FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
        log("onMessage notification title: ${message?.notification?.title}");
        log("onMessage notification body: ${message?.notification?.body}");
        log("onMessage notification map: ${message?.notification?.toMap()}");
        log("onMessage notification data: ${message?.data.toString()}");
        if (message != null) {
          if (message.notification != null) {
            _saveSharedPrefValue(message);
            _getSharedPrefValue();
            if (Platform.isAndroid) {
              showSimpleNotification(
                title: message.notification!.title,
                body: message.notification!.body,
                payload: message.notification!.body!,
              );
            }
          }
        }
      });

  void _saveSharedPrefValue(RemoteMessage message) {
    Map<String, dynamic> notificationMap = {};
    notificationMap.addAll(Pref.getObject(Pref.notifications) ?? {});
    notificationMap[message.notification!.title!] = message.notification!.body!;
    Pref.setObject(Pref.notifications, notificationMap);
  }

  void _getInitialMessage() {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        if (message.notification != null) {
          _saveSharedPrefValue(message);
          _getSharedPrefValue();

          // Get.toNamed(AppRoute.notification);
        }
      }
    });
  }

  Future<void> _setForegroundNotification() async =>
      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

  Future<void> _initFcmChannel() async => NotificationHelper.init();

  Future<void> _askNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log("Notification permission granted");
    } else {
      //ask permission again
      _askNotificationPermission();
    }
  }
}
