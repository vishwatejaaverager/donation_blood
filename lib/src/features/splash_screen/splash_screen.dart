import 'package:donation_blood/src/features/shared/domain/models/user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../bottom_nav/screens/donate_blood/providers/requests_provider.dart';
import '../../app.dart';
import '../../utils/navigation.dart';
import '../authentication/presentation/login_screen/login_screen.dart';
import '../notification/notification_services.dart';
import '../profile_det/provider/profile_provider.dart';
import '../shared/presentation/bottom_nav/screens/bottom_nav_screen.dart';

UserProfile? globalUserProfile;

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
    if (preferences.getUserId() != "") {
      Provider.of<ProfileProvider>(context, listen: false)
          .getUserInfo()
          .then((value) {
        // if (preferences.getUserId() != "") {
        globalUserProfile = value!;
        NotificationService().requestNotificationPermission();
        NotificationService().initInfo();
        Provider.of<RequestProvider>(context, listen: false)
            .getAllReuests(value)
            .then((value) {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            Navigation.instance.pushAndRemoveUntil(BottomNavScreen.id.path);
          });
        });

        //}
      });
    } else {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Navigation.instance.pushAndRemoveUntil(LoginScreen.id.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff06c73),
        body: Column(
          //alignment: Alignment.bottomCenter,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Image.asset(
              'assets/real_logo.png',
            )),
            const SpinKitPulse(
              color: Colors.black,
              size: 100.0,
            )
          ],
        ));
  }
}
