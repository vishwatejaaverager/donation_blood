import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../features/authentication/presentation/login_screen/login_screen.dart';
import '../features/authentication/presentation/otp_screen.dart';
import '../features/profile_det/screens/location_search_screen.dart';
import '../features/profile_det/screens/profile_detail_screen.dart';

class AppRouter {
  static Route generateRoute(RouteSettings route) {
    const PageTransitionType style = PageTransitionType.fade;

    PageTransition pageTransition(Widget child) {
      return PageTransition(child: child, type: style);
    }

    if (route.name == LoginScreen.id.path) {
      return pageTransition(const LoginScreen());
    } else if (route.name == OtpScreen.id.path) {
      return pageTransition(const OtpScreen());
    } else if (route.name == EditProfileScreen.id.path) {
      return pageTransition(const EditProfileScreen());
    } else if (route.name == LocationSeachScreen.id.path) {
      return pageTransition(const LocationSeachScreen());
    } else if (route.name == BottomNavScreen.id.path) {
      return pageTransition(const BottomNavScreen());
    } else {
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('No view defined for this route'),
          ),
        ),
      );
    }
  }
}
