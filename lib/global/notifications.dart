import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // idz
  'High Importance Notifications', // title
   // description
  importance: Importance.high,
);

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('>>>>>>>>>>>>>>>>Handling a background message ${message.messageId}');
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification!.android;
  if (notification != null && android != null) {
    /*NotificationApi.showNotification(
      id: 0,
      title: notification.title,
      body: notification.body,
      payload: "",
    );*/
  }
}

class NotificationApi {
  static final iosFlutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id', // id
        'channel name', // title

        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final settings = InitializationSettings(android: android, iOS: iOS);
    await _notification.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!.createNotificationChannel(channel);

    await _notification.initialize(settings);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    final FlutterLocalNotificationsPlugin iosFlutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // await iosFlutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settingsForNotification = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('>>>>>>>>>>>>>>>>User granted permission: ${settingsForNotification.authorizationStatus}');

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      if (message.notification!.body != null) {}
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("event==>${event.notification}");
      print("event==>${event.data}");
      print("event==>${event.messageId}");
      showNotification(title: event.notification!.title!, body: event.notification!.body!, payload: event.data.toString());
    });

    messaging.getToken().then((token) {
      print("token :  $token"); // Print the Token in Console
    });
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notification.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payload,
      );

  static Future showMultipleNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    DateTime? scheduledDate,
  }) async =>
      _notification.periodicallyShow(
        id,
        title,
        body,
        RepeatInterval.hourly,
        //tz.TZDateTime.from(scheduledDate, tz.local),
        // _scheduledWeekly(Time(8), days: [DateTime.monday, DateTime.tuesday]),
        await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        // uiLocalNotificationDateInterpretation:
        //     UILocalNotificationDateInterpretation.absoluteTime,
        // matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );

  static Future cancelNotification(int id) async {
    await _notification.cancel(id);
  }

  static Future cancelAllNotification() async {
    await _notification.cancelAll();
  }
}
