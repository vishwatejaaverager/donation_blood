import 'package:donation_blood/src/features/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

import 'utils/app_router.dart';
import 'utils/navigation.dart';
import 'utils/user_pref/user_preferences.dart';
import 'utils/utils.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Preferences preferences = Preferences();
    return MaterialApp(
        title: 'Blood Flow',
        debugShowCheckedModeBanner: false,
        navigatorKey: Navigation.instance.navigationKey,
        scaffoldMessengerKey: snackbarKey,
        onGenerateRoute: AppRouter.generateRoute,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen()

        //  preferences.getUserId() != ""
        //     ? const BottomNavScreen()
        //     : const LoginScreen()

        );
    // ignore: unrelated_type_equality_checks
    //home: const EditProfileScreen());

    // preferences.getUserId() != ""
    //     ? const BottomNavScreen
    //     : const LoginScreen());
  }
}

final Preferences preferences = Preferences();
