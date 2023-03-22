import 'package:donation_blood/src/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/utils.dart';
import '../../data/providers/login_provider.dart';
import 'login_button.dart';

class LoginScreen extends StatefulWidget {
  static const id = AppRoutes.loginScreen;
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height / 2.5,
              width: size.width,
              child: Image.asset(
                "assets/login/login.jpg",
                fit: BoxFit.cover,
              ),
            ),
            sbh(32),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Get Ready To Save Lifes :)",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
              ),
            ),
            sbh(24),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: phoneController,
                decoration: const InputDecoration(
                    icon: Text("+91"),
                    hintText: "Enter Your Mobile Number    "),
              ),
            ),
            sbh(24),
            const Center(
              child: Text("OR"),
            ),
            sbh(12),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Center(
            //       child: LoginMethodButton(
            //         widget: Image.asset(
            //           "assets/login/fb_icon.png",
            //           scale: 2,
            //         ),
            //         text: " Continue with Facebook",
            //         onpressed: () {
            //           //fbLogin();
            //         },
            //       ),
            //     ),
            //     sbh(8),
            //     Center(
            //       child: LoginMethodButton(
            //         widget: Image.asset(
            //           "assets/login/google.png",
            //           scale: 25,
            //         ),
            //         text: " Continue with Google",
            //         onpressed: () {
            //           //googlelogin();
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            sbh(16),
            Consumer<LoginProvider>(builder: ((_, __, ___) {
              return LoginButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  __.regAndLogUser(phoneController.text, context);
                  // if (!__.isOTPSent) {

                  //   }
                },
                text: "Get OTP",
              );
            }))
          ],
        ),
      ),
    );
  }
}
