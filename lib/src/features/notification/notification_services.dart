import 'dart:convert';
import 'dart:developer';
import 'package:donation_blood/src/app.dart';
import 'package:donation_blood/src/utils/streams.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  final Streams _streams = Streams();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initInfo() {
    const androidIntialize =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosIntialize = DarwinInitializationSettings();
    const intializeSettings =
        InitializationSettings(iOS: iosIntialize, android: androidIntialize);
    FlutterLocalNotificationsPlugin().initialize(
      intializeSettings,
    );

    FirebaseMessaging.onMessage.listen((event) async {
      log(".............. message..................");
      log(event.notification!.title! + event.notification!.body!);

      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
          event.notification!.body.toString(),
          htmlFormatBigText: true,
          contentTitle: event.notification!.title.toString(),
          htmlFormatContentTitle: true);

      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails("blood", "blood",
              importance: Importance.high,
              styleInformation: bigTextStyleInformation,
              playSound: false);

      NotificationDetails platformSpecific =
          NotificationDetails(android: androidNotificationDetails);

      await flutterLocalNotificationsPlugin.show(0, event.notification!.title,
          event.notification!.body, platformSpecific,
          payload: event.data['body']);
    });
  }

  requestNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log("Permission granted");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log("provissionaly granted");
    } else {
      log("else part");
    }
  }

  String _token = '';
  String get token => _token;

  void getToken(String userId) async {
    // if (preferences.getUserId() != "") {
    await FirebaseMessaging.instance.getToken().then((value) {
      _token = value!;
      log(_token);
      saveUsertoken(userId, _token);
    });
    //}
  }

  saveUsertoken(String userID, String token) {
    _streams.userQuery.doc(userID).update({"token": token});
  }

  // sendNotifications(String token,
  //     {String? title, String? desc, String? imageUrl}) async {
  //   String serverKey =
  //       'AAAA7Q7-Ucg:APA91bEMd0Tvc_H0FL8JPUVClOMiewGTkcRr-GW63wcvutjVWV66ho315RHvMfmRQMRMUBy2wlXzn_VsJnUEz7mQlp2qS_tOlha4HfbEdGXcjvGj5qcO3K__yS46S_yTLuH2-svw92_-';
  //   String fcmUrl = 'https://fcm.googleapis.com/fcm/send';

  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'key=$serverKey',
  //   };

  //   Map<String, dynamic> data = {
  //     'notification': {
  //       'title': 'New Message',
  //       'body': 'You have a new message',
  //       'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //     },
  //     'to': token,
  //   };
  //   http.Response response = await http.post(
  //     Uri.parse(fcmUrl),
  //     headers: headers,
  //     body: jsonEncode(data),
  //   );
  //   log(response.statusCode.toString());
  // }

  sendPushNotification(String token,
      {String? title, String? desc, String? imageUrl}) async {
    try {
      var a = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAA7Q7-Ucg:APA91bEMd0Tvc_H0FL8JPUVClOMiewGTkcRr-GW63wcvutjVWV66ho315RHvMfmRQMRMUBy2wlXzn_VsJnUEz7mQlp2qS_tOlha4HfbEdGXcjvGj5qcO3K__yS46S_yTLuH2-svw92_-'
          },
          body: jsonEncode(<String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': desc,
              'title': title
            },
            "notification": <String, dynamic>{
              "title": title,
              "body": desc,
              "android_channel_id": "blood",
            },
            "to": token
          }));

      log("${a.statusCode}status code");
    } catch (e) {
      log(e.toString());
    }
  }
}
