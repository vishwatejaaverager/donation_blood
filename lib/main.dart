import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:device_preview/device_preview.dart';
import 'package:donation_blood/src/utils/user_pref/user_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'src/app.dart';
import 'src/utils/general_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Preferences.init();

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
