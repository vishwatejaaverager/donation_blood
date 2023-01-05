import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../utils/routes.dart';
import '../../../utils/utils.dart';
import '../../../utils/widget_utils/loading.dart';
import '../data/providers/login_provider.dart';
import 'login_screen/login_button.dart';

class OtpScreen extends StatefulWidget {
  static const id = AppRoutes.otpScreen;
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();

  // @override
  // void dispose() {
  //   _otpController.dispose();
  //   super.dispose();
  // }

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
            sbh(16),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Verify To Save Lifes :)",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PinCodeTextField(
                      autoDisposeControllers: false,
                      keyboardType: TextInputType.number,
                      controller: _otpController,
                      onCompleted: (v) {
                        Provider.of<LoginProvider>(context, listen: false)
                            .verifyOTP(
                          v,
                        );
                      },
                      appContext: context,
                      length: 6,
                      onChanged: ((value) {})),
                ),
                TweenAnimationBuilder(
                  tween: Tween(begin: 60.0, end: 0.0),
                  duration: const Duration(seconds: 60),
                  builder: (_, double? value, child) => InkWell(
                    onTap: value!.toInt() == 00
                        ? () {
                            Navigator.pop(context);
                          }
                        : () {
                            appToast("error");
                          },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text("Resend OTP"),
                            value.toInt() == 00
                                ? const SizedBox()
                                : Text(
                                    "in 00:${value.toInt()}",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                LoginButton(
                    onPressed: () {
                      log("pressed");
                       
                      Provider.of<LoginProvider>(context, listen: false)
                          .verifyOTP(
                        _otpController.text,
                      );
                    },
                    text: "Verify")
              ],
            ),
            //const Spacer(),
          ],
        ),
      ),
    );
  }
}
