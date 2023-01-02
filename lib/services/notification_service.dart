import 'dart:convert';

import 'package:flutter/material.dart';

class NotificationService {
  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  Future<void> registerPushNotificationHandler() async {
    // NotificationSettings settings = await messaging.requestPermission(
    //   alert: true,
    //   announcement: false,
    //   badge: true,
    //   carPlay: false,
    //   criticalAlert: false,
    //   provisional: false,
    //   sound: true,
    // );

    // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    //   debugPrint('User granted permission');
    // } else if (settings.authorizationStatus ==
    //     AuthorizationStatus.provisional) {
    //   debugPrint('User granted provisional permission');
    // } else {
    //   debugPrint('User declined or has not accepted permission');
    // }

    // await messaging.setForegroundNotificationPresentationOptions(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    // );
    // const AndroidNotificationChannel channel = AndroidNotificationChannel(
    //   'high_importance_channel',
    //   'High Importance Notifications',
    //   description: 'This channel is used for important notifications.',
    //   importance: Importance.max,
    // );

    // var initializationSettingsAndroid = const AndroidInitializationSettings(
    //   '@drawable/ic_stat_logo',
    // );
    // var initializationSettingsIOS = const IOSInitializationSettings();
    // var initializationSettings = InitializationSettings(
    //   android: initializationSettingsAndroid,
    //   iOS: initializationSettingsIOS,
    // );
    // flutterLocalNotificationsPlugin.initialize(
    //   initializationSettings,
    //   onSelectNotification: onSelectNotification,
    // );

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    //   debugPrint(
    //       "\nForground message notification: ${message.notification?.title} "
    //       "${message.notification?.body}");
    //   debugPrint("Forground message data: ${message.data.toString()}");

    //   RemoteNotification? notification = message.notification;

    //   if (notification != null) {
    //     flutterLocalNotificationsPlugin.show(
    //       notification.hashCode,
    //       notification.title,
    //       notification.body,
    //       NotificationDetails(
    //         android: AndroidNotificationDetails(
    //           channel.id,
    //           channel.name,
    //           channelDescription: channel.description,
    //           color: const Color(0xFFEE7110),
    //         ),
    //       ),
    //       payload: jsonEncode(message.data),
    //     );
    //   }
    // });

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   debugPrint("Message Clicked: ${message.data.toString()}");
    // });
    debugPrint("Notification Service Registered");
  }

  void onSelectNotification(String? data) {
    debugPrint("Local Message Clicked: $data");
    if (data?.isNotEmpty ?? false) {
      Map<String, dynamic> payload = jsonDecode(data!);
      debugPrint("Local Message Clicked: $payload");
    }
  }

  Future<String> getDeviceToken() async {
    // String token = await messaging.getToken() ?? "";
    String token =
        "test-iYY0QzSyzqh1LPasWG:APA91bFOtBMPu0IeHEdMCClfYkx1drZ73aGKr7-RHb0BaFv2N2DcZ0HHhqkoQ5RSyx2JRC6YdFPsnVicSnvcuCrieBTHqO_UuVz9BGqIo7I5DSWiIao--Q5EIG4IeERMZLwkqwxWiD8Y";
    debugPrint('FirebaseToken: $token');
    return token;
  }
}
