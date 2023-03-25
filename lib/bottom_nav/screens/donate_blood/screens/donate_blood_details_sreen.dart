import 'dart:developer';

import 'package:donation_blood/bottom_nav/screens/donate_blood/providers/requests_provider.dart';
import 'package:donation_blood/bottom_nav/screens/donate_blood/screens/on_boarding_screen.dart';
import 'package:donation_blood/src/features/authentication/data/providers/login_provider.dart';
import 'package:donation_blood/src/features/authentication/presentation/login_screen/login_button.dart';
import 'package:donation_blood/src/features/shared/domain/models/blood_donation_model.dart';
import 'package:donation_blood/src/features/terms_conditions/terms_conditions.dart';
import 'package:donation_blood/src/utils/routes.dart';
import 'package:donation_blood/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:provider/provider.dart';

import '../../../../src/utils/navigation.dart';
import '../components/request_blood_card.dart';

class BloodDonateReqScreen extends StatelessWidget {
  static const id = AppRoutes.bloodDonateReqScreen;
  final BloodDonationModel bloodDonationModel;
  const BloodDonateReqScreen({super.key, required this.bloodDonationModel});

  @override
  Widget build(BuildContext context) {
    log(bloodDonationModel.donatedUnits!);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigation.instance.pushBack();
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  const Text(
                    "Request Details",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.share)
                ],
              ),
            ),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/home/bloodbag.png",
                          scale: 8,
                          color: Colors.red,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "0${bloodDonationModel.units!}",
                              style: const TextStyle(fontSize: 24),
                            ),
                            const Text(
                              "units blood needed",
                              style: TextStyle(fontSize: 8),
                            )
                          ],
                        )
                      ],
                    ),
                    sbh(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FAProgressBar(
                          currentValue:
                              double.parse(bloodDonationModel.donatedUnits!),
                          size: 10,
                          maxValue: double.parse(bloodDonationModel.units!),
                          changeColorValue: 100,
                          changeProgressColor: Colors.pink,
                          backgroundColor: Colors.white,
                          progressColor: Colors.red,
                          animatedDuration: const Duration(milliseconds: 300),
                          direction: Axis.horizontal,
                          verticalDirection: VerticalDirection.up,
                          displayText: '',
                          formatValueFixed: 2,
                        ),
                        Text("${bloodDonationModel.donatedUnits!} donated")
                      ],
                    )
                  ],
                ),
              ),
            ),
            RequestBloodCard(
                showHosp: false, bloodDonationModel: bloodDonationModel),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hospital Info",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    sbh(12),
                    Text(bloodDonationModel.location!),
                    sbh(12),
                    Card(
                      child: AnimatedButton(
                        onPress: () async {
                          await Provider.of<RequestProvider>(context,
                                  listen: false)
                              .launchMaps(
                                  bloodDonationModel.lat!.toDouble(),
                                  bloodDonationModel.long!.toDouble(),
                                  bloodDonationModel.location!);
                        },
                        height: 50,
                        //width: 100,
                        text: 'Get Directions',
                        isReverse: true,
                        selectedTextColor: Colors.black,
                        transitionType: TransitionType.RIGHT_TO_LEFT,
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        // textStyle: submitTextStyle,
                        backgroundColor: Colors.redAccent,
                        borderColor: Colors.white,
                        borderRadius: 12,
                        borderWidth: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Consumer<LoginProvider>(
              builder: (context, __, child) {
                return Row(
                  children: [
                    Checkbox(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        value: __.terms,
                        onChanged: ((value) {
                          __.configTerms(value!);
                        })),
                    const Text("I agree to the",
                        style: TextStyle(fontSize: 12)),
                    InkWell(
                      onTap: () {
                        Navigation.instance
                            .navigateTo(TermsAndConditions.id.path);
                      },
                      child: const Text(
                        "Terms and Conditions",
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    )
                  ],
                );
              },
            ),
            const Spacer(),
            LoginButton(
                onPressed: () {
                  bool terms =
                      Provider.of<LoginProvider>(context, listen: false).terms;
                  if (terms) {
                    Navigation.instance.navigateTo(
                        DonateOnBoardingScreen.id.path,
                        args: bloodDonationModel);
                  } else {
                    appToast("Agreee terms and conditions");
                  }
                },
                text: "Donate")
            // Card(
            //   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            //   child: AnimatedButton(
            //     onPress: () async {
            //       Navigation.instance.navigateTo(DonateOnBoardingScreen.id.path,
            //           args: bloodDonationModel);
            //     },
            //     height: 50,
            //     //width: 100,
            //     text: 'Donate',
            //     isReverse: true,
            //     selectedTextColor: Colors.black,
            //     transitionType: TransitionType.RIGHT_TO_LEFT,
            //     textStyle:
            //         const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //     // textStyle: submitTextStyle,
            //     backgroundColor: Colors.white,
            //     selectedBackgroundColor: Colors.redAccent,
            //     borderColor: Colors.white,
            //     borderRadius: 12,
            //     borderWidth: 2,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
