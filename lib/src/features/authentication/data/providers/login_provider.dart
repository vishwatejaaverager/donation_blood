import 'dart:developer';

import 'package:donation_blood/src/features/shared/domain/models/user_profile_model.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/bottom_nav_screen.dart';
import 'package:donation_blood/src/features/splash_screen/splash_screen.dart';
import 'package:donation_blood/src/utils/streams.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../../../utils/navigation.dart';
import '../../../../utils/user_pref/user_preferences.dart';
import '../../../../utils/utils.dart';
import '../../../../utils/widget_utils/loading.dart';
import '../../../profile_det/screens/profile_detail_screen.dart';
import '../../presentation/otp_screen.dart';

class LoginProvider with ChangeNotifier {
  final Streams _streams = Streams();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String _userId = '';
  String get userId => _userId;

  String _phone = '';
  String get phone => _phone;

  bool _isOTPsent = false;
  bool get isOTPSent => _isOTPsent;
  // Future RegorLogUser(
  //   String phone,
  // ) async {
  //   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //   firebaseAuth.verifyPhoneNumber(
  //       verificationCompleted: ((phoneAuthCredential) {}),
  //       verificationFailed: (e) {},
  //       codeSent: ((verificationId, forceResendingToken) {}),
  //       codeAutoRetrievalTimeout: ((verificationId) {}));
  // }

  String _verId = '';
  String get verId => _verId;

  setOtpsent() {
    _isOTPsent = true;
  }

  setUserId(String s) {
    _userId = s;
  }

  setPhone(String s) {
    _phone = s;
  }

  regAndLogUser(String phone, BuildContext context) {
    try {
      Loading().witIndicator(context: context, title: "Sending OTP");
      _firebaseAuth.verifyPhoneNumber(
          // ignore: prefer_interpolation_to_compose_strings
          phoneNumber: "+91" + phone,
          verificationCompleted: ((phoneAuthCredential) {
            appToast("Verified Sucessfully :)");
          }),
          verificationFailed: (e) {
            //appToast(context, e.message.toString());
            appToast("wrong otp try again");
            log(e.toString());
          },
          codeSent: ((verificationId, forceResendingToken) {
            setOtpsent();
            _verId = verificationId;
            Navigator.pushNamed(context, OtpScreen.id.path);
          }),
          codeAutoRetrievalTimeout: ((verificationId) {}));
    } catch (e) {
      log(e.toString());
    }
  }

  verifyOTP(
    String otp,
  ) async {
    log("came");
    try {
      Loading().witIndicator(
          context: Navigation.instance.navigationKey.currentState!.context,
          title: "Verifying OTP");
      UserCredential a = await _firebaseAuth.signInWithCredential(
          PhoneAuthProvider.credential(verificationId: verId, smsCode: otp));
      if (a.user != null) {
        appToast("succesfully verified :)");
        log(a.user.toString());
        Preferences.setUserID(a.user!.uid);
        setUserId(a.user!.uid);
        setPhone(a.user!.phoneNumber!);

        await _streams.userQuery
            .where("userId", isEqualTo: a.user!.uid.toString())
            .get()
            .then((value) {
          if (value.docs.isNotEmpty) {
            globalUserProfile = UserProfile.fromMap(value.docs[0].data());
            // log("message");
            Navigation.instance.navigateTo(BottomNavScreen.id.path);
          } else {
            Navigation.instance.navigateTo(EditProfileScreen.id.path);
          }
        });
      }
    } catch (e) {
      appToast(e.toString());
      Navigation.instance.pushBack();
      appToast("Wrong OTP please do check");
    }
  }
}
