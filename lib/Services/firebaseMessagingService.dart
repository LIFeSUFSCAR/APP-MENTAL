import 'package:app_mental/Services/notificationService.dart';
import 'package:app_mental/classes/CustomNotification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class FirebaseMessagingService {
  final NotificationService _notificationService;

  FirebaseMessagingService(this._notificationService);

  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();

    print("Handling a background message: ${message.messageId}");
  }

  Future<void> initialize() async {
    print("aqui");
    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            badge: true, sound: true, alert: true);

    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // (message) =>
    //   print("Handling a background message:");
    // });
    getDeviceFirebaseToken();
    _onMessage();
  }

  void getDeviceFirebaseToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print('TOKEN: $token');
  }

  void _onMessage() {
    print("onmessage");
    FirebaseMessaging.onMessage.listen((message) {
      print("chegou");
      RemoteNotification? remoteNotification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;

      if (remoteNotification != null && androidNotification != null) {
        _notificationService.showNotification(CustomNotification(
            id: androidNotification.hashCode,
            title: remoteNotification.title!,
            body: remoteNotification.body,
            payload: "/home"));
      }
    });
  }
}
