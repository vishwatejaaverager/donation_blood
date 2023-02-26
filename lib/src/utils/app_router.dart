import 'package:donation_blood/bottom_nav/screens/donate_blood/screens/request_response_screens/donation_detail_res_screen.dart';
import 'package:donation_blood/bottom_nav/screens/donate_blood/screens/on_boarding_screen.dart';
import 'package:donation_blood/src/features/shared/domain/models/blood_donation_model.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/bottom_nav_screen.dart';
import 'package:donation_blood/src/features/shared/presentation/create_req/screens/create_request_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../bottom_nav/screens/donate_blood/screens/donate_blood_details_sreen.dart';
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
    } else if (route.name == CreateReqScreen.id.path) {
      return pageTransition(const CreateReqScreen());
    } else if (route.name == BloodDonateReqScreen.id.path) {
      BloodDonationModel bloodDonationModel =
          route.arguments as BloodDonationModel;
      return pageTransition(BloodDonateReqScreen(
        bloodDonationModel: bloodDonationModel,
      ));
    } else if (route.name == BloodDetailResScreen.id.path) {
      Map<String, dynamic> bloodDonationModel =
          route.arguments as Map<String, dynamic>;
      return pageTransition(BloodDetailResScreen(
        bloodDonationModel: bloodDonationModel['bloodDonationInfo'],
        bloodId: bloodDonationModel['id'],
      ));
    }
    // else if (route.name == RequestDonarsResScreen.id.path) {
    //   BloodDonationModel bloodDonationModel =
    //       route.arguments as BloodDonationModel;
    //   return pageTransition(RequestDonarsResScreen(
    //     bloodDonationModel: bloodDonationModel,
    //   ));
    // }

    else if (route.name == DonateOnBoardingScreen.id.path) {
      BloodDonationModel bloodDonationModel =
          route.arguments as BloodDonationModel;
      return pageTransition(DonateOnBoardingScreen(
        bloodDonationModel: bloodDonationModel,
      ));
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
