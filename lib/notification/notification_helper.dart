import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/notification/model/notification_body.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/chat/inbox_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/notification/notification_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/order_details_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class NotificationHelper {

  static Future<void> initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()!.requestPermission();
    flutterLocalNotificationsPlugin.initialize(initializationsSettings, onDidReceiveNotificationResponse: (NotificationResponse load) async {
      try{
        NotificationBody payload;
        if(load.payload!.isNotEmpty) {
          payload = NotificationBody.fromJson(jsonDecode(load.payload!));
          if(payload.type == 'order') {
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  OrderDetailsScreen(orderId: payload.orderId)));

          } else if(payload.type == 'notification') {
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  const NotificationScreen()));

          } else{
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  const InboxScreen(isBackButtonExist: true,)));

          }
        }
      }catch (_) {}
      return;
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print("onMessage: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
        print("onMessage type: ${message.data['type']}/${message.data}");
      }
      NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, false);

      // try{
      //   if(message.data.isNotEmpty) {
      //     NotificationBody notificationBody = convertNotification(message.data);
      //     if(notificationBody.type == 'order') {
      //       Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  OrderDetailsScreen(orderId: notificationBody.orderId)));
      //
      //
      //     } else if(notificationBody.type == 'notification') {
      //       Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  const NotificationScreen()));
      //     } else{
      //       Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  const InboxScreen(isBackButtonExist: true,)));
      //
      //     }
      //   }
      // }catch (_) {}

    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print("onOpenApp: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
      }
      try{
        if(message.data.isNotEmpty) {
          NotificationBody notificationBody = convertNotification(message.data);
          if(notificationBody.type == 'order') {
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  OrderDetailsScreen(orderId: notificationBody.orderId)));


          } else if(notificationBody.type == 'notification') {
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  const NotificationScreen()));
          } else{
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  const InboxScreen(isBackButtonExist: true,)));

          }
        }
      }catch (_) {}
    });
  }

  static Future<void> showNotification(RemoteMessage message, FlutterLocalNotificationsPlugin fln, bool data) async {
    if(!Platform.isIOS) {
      String? title;
      String? body;
      String? orderID;
      String? image;
      NotificationBody notificationBody = convertNotification(message.data);
      if(data) {
        title = message.data['title'];
        body = message.data['body'];
        orderID = message.data['order_id'];
        image = (message.data['image'] != null && message.data['image'].isNotEmpty)
            ? message.data['image'].startsWith('http') ? message.data['image']
            : '${AppConstants.baseUrl}/storage/app/public/notification/${message.data['image']}' : null;
      }else {
        title = message.notification!.title;
        body = message.notification!.body;
        orderID = message.notification!.titleLocKey;
        if(Platform.isAndroid) {
          image = (message.notification!.android!.imageUrl != null && message.notification!.android!.imageUrl!.isNotEmpty)
              ? message.notification!.android!.imageUrl!.startsWith('http') ? message.notification!.android!.imageUrl
              : '${AppConstants.baseUrl}/storage/app/public/notification/${message.notification!.android!.imageUrl}' : null;
        }else if(Platform.isIOS) {
          image = (message.notification!.apple!.imageUrl != null && message.notification!.apple!.imageUrl!.isNotEmpty)
              ? message.notification!.apple!.imageUrl!.startsWith('http') ? message.notification!.apple!.imageUrl
              : '${AppConstants.baseUrl}/storage/app/public/notification/${message.notification!.apple!.imageUrl}' : null;
        }
      }

      if(image != null && image.isNotEmpty) {
        try{
          await showBigPictureNotificationHiddenLargeIcon(title, body, orderID, notificationBody, image, fln);
        }catch(e) {
          await showBigTextNotification(title, body!, orderID, notificationBody, fln);
        }
      }else {
        await showBigTextNotification(title, body!, orderID, notificationBody, fln);
      }
    }
  }

  static Future<void> showTextNotification(String title, String body, String orderID, NotificationBody? notificationBody, FlutterLocalNotificationsPlugin fln) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '6valley', '6valley', playSound: true,
      importance: Importance.max, priority: Priority.max, sound: RawResourceAndroidNotificationSound('notification'),
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: notificationBody != null ? jsonEncode(notificationBody.toJson()) : null);
  }

  static Future<void> showBigTextNotification(String? title, String body, String? orderID, NotificationBody? notificationBody, FlutterLocalNotificationsPlugin fln) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body, htmlFormatBigText: true,
      contentTitle: title, htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '6valley', '6valley', importance: Importance.max,
      styleInformation: bigTextStyleInformation, priority: Priority.max, playSound: true,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: notificationBody != null ? jsonEncode(notificationBody.toJson()) : null);
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(String? title, String? body, String? orderID, NotificationBody? notificationBody, String image, FlutterLocalNotificationsPlugin fln) async {
    final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
    final String bigPicturePath = await _downloadAndSaveFile(image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath), hideExpandedLargeIcon: true,
      contentTitle: title, htmlFormatContentTitle: true,
      summaryText: body, htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '6valley', '6valley',
      largeIcon: FilePathAndroidBitmap(largeIconPath), priority: Priority.max, playSound: true,
      styleInformation: bigPictureStyleInformation, importance: Importance.max,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    final NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: notificationBody != null ? jsonEncode(notificationBody.toJson()) : null);
  }

  static Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static NotificationBody convertNotification(Map<String, dynamic> data){
    if(data['type'] == 'notification') {
      return NotificationBody(type: 'notification');
    }else if(data['type'] == 'order') {
      return NotificationBody(type: 'order', orderId: int.parse(data['order_id']));
    }else {
      return NotificationBody(type: 'chatting');
    }
  }

}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("onBackground: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
  }
  // var androidInitialize = new AndroidInitializationSettings('notification_icon');
  // var iOSInitialize = new IOSInitializationSettings();
  // var initializationsSettings = new InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  // NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, true);
}