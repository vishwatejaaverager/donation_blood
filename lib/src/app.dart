import 'package:flutter/material.dart';

import 'utils/app_router.dart';
import 'features/authentication/presentation/login_screen/login_screen.dart';
import 'features/shared/presentation/bottom_nav/screens/bottom_nav_screen.dart';
import 'utils/navigation.dart';
import 'utils/user_pref/user_preferences.dart';
import 'utils/utils.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Preferences preferences = Preferences();
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        navigatorKey: Navigation.instance.navigationKey,
        scaffoldMessengerKey: snackbarKey,
        onGenerateRoute: AppRouter.generateRoute,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // ignore: unrelated_type_equality_checks
        //home: const EditProfileScreen());
        home: preferences.getUserId() != ""
            ? const BottomNavScreen()
            : const LoginScreen());

    // preferences.getUserId() != ""
    //     ? const BottomNavScreen
    //     : const LoginScreen());
  }
}
