import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:device_preview/device_preview.dart';
import 'package:donation_blood/src/utils/user_pref/user_preferences.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'src/app.dart';
import 'src/features/notification/notification_services.dart';
import 'src/utils/general_providers.dart';

Future<void> _firebaseMessagingHandler(RemoteMessage message) async {
  log("background notification");
  NotificationService().initInfo();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Preferences.init(); 
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. debug provider
    // 2. safety net provider
    // 3. play integrity provider
    androidProvider: AndroidProvider.playIntegrity,
  );
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingHandler);

  //* for catching any unhandled dart exceptions.
  runZonedGuarded(
      () => runApp(
            DevicePreview(
              enabled: false,
              tools: const [...DevicePreview.defaultTools],
              builder: ((context) {
                return MultiProvider(
                  providers: generalProviders,
                  child: const MyApp(),
                );
              }),
            ),
          ), (error, stackTrace) {
    log(error.toString());

    log(stackTrace.toString());

    // exit (crash) app
    exit(0);
  });
}
