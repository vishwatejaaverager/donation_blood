import 'package:donation_blood/src/app.dart';
import 'package:donation_blood/src/features/authentication/presentation/login_screen/login_screen.dart';
import 'package:donation_blood/src/features/notification/notification_services.dart';
import 'package:donation_blood/src/features/profile_det/provider/profile_provider.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/bottom_nav_screen.dart';
import 'package:donation_blood/src/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../bottom_nav/screens/donate_blood/providers/requests_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Timer _timer;

  @override
  void initState() {
    super.initState();
    Provider.of<ProfileProvider>(context, listen: false)
        .getUserInfo()
        .then((value) {
      if (preferences.getUserId() != "") {
        Provider.of<RequestProvider>(context, listen: false)
            .getAllReuests(value!);
        NotificationService().requestNotificationPermission();
        NotificationService().initInfo();
        Navigation.instance.navigateTo(BottomNavScreen.id.path);
      } else {
        Navigation.instance.navigateTo(LoginScreen.id.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
