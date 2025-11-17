import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FCMServices {
  static Future<void> printDeviceToken() async {
    var token = await FirebaseMessaging.instance.getToken();
    log("device token ----------------------: $token");
  }

  // static late AndroidNotificationChannel channel;
  // static bool isFlutterLocalNotificationsInitialized = false;
  // static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  // static Future<void> setupFlutterNotification() async {
  //   if (isFlutterLocalNotificationsInitialized) {
  //     return;
  //   }
  //   channel = const AndroidNotificationChannel(
  //     'your_channel_id',
  //     'Your Channel Name',
  //     description: 'Description of your channel',
  //     importance: Importance.high,
  //     playSound: true,
  //     sound: RawResourceAndroidNotificationSound('notification'),
  //     showBadge: true,
  //   );
  //   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin
  //       >()
  //       ?.createNotificationChannel(channel);
  //   await FirebaseMessaging.instance
  //       .setForegroundNotificationPresentationOptions(
  //         alert: true,
  //         badge: true,
  //         sound: true,
  //       );
  //   isFlutterLocalNotificationsInitialized = true;
  // }

  // static void showFlutterNotification(RemoteMessage message) {
  //   RemoteNotification? notification = message.notification;
  //   AndroidNotification? android = message.notification?.android;
  //   if (notification != null && android != null) {
  //     flutterLocalNotificationsPlugin.show(
  //       notification.hashCode,
  //       notification.title,
  //       notification.body,
  //       NotificationDetails(
  //         android: AndroidNotificationDetails(
  //           channel.id,
  //           channel.name,
  //           channelDescription: channel.description,
  //           icon: "launch_background",
  //         ),
  //       ),
  //     );
  //   }
  // }
}
