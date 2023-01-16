import 'package:donation_blood/bottom_nav/screens/donate_blood/providers/requests_provider.dart';
import 'package:donation_blood/src/utils/routes.dart';
import 'package:donation_blood/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:provider/provider.dart';

class DonateOnBoardingScreen extends StatelessWidget {
  static const id = AppRoutes.donateOnBoardingScreen;
  const DonateOnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
          onFinish: () {},
          finishButtonText: "Continue",
          totalPage: 4,
          headerBackgroundColor: Colors.white,
          background: const [SizedBox(), SizedBox(), SizedBox(), SizedBox()],
          speed: 2,
          pageBodies: [
            Consumer<RequestProvider>(builder: ((_, __, ___) {
              return OnboardingWidget(
                image: Image.asset(
                  "assets/home/blood.png",
                  scale: 2,
                ),
                onpress1: () => __.setSelectedOpt('Yes'),
                onpress2: () => __.setSelectedOpt('No'),
                opt: __.selectedOpt,
                quest: "Have you been feeling well and healthy recently !?",
              );
            })),
            Consumer<RequestProvider>(builder: ((_, __, ___) {
              return OnboardingWidget(
                image: Image.asset(
                  "assets/home/blood.png",
                  scale: 2,
                ),
                onpress1: () => __.setSelectedOpt1('Yes'),
                onpress2: () => __.setSelectedOpt1('No'),
                opt: __.selectedOpt1,
                quest: "Do You Weight atleast 50kg !?",
              );
            })),
            Consumer<RequestProvider>(builder: ((_, __, ___) {
              return OnboardingWidget(
                image: Image.asset(
                  "assets/home/blood.png",
                  scale: 2,
                ),
                onpress1: () => __.setSelectedOpt2('Yes'),
                onpress2: () => __.setSelectedOpt2('No'),
                opt: __.selectedOpt2,
                quest: "Received a transfusion in the past 3 months !?",
              );
            })),
            Consumer<RequestProvider>(builder: ((_, __, ___) {
              return OnboardingWidget(
                image: Image.asset(
                  "assets/home/blood.png",
                  scale: 2,
                ),
                onpress1: () {},
                onpress2: () {},
                toShowOpt: false,
                opt: '',
                quest: __.selectedOpt == 'Yes' &&
                        __.selectedOpt1 == 'Yes' &&
                        __.selectedOpt2 == 'Yes'
                    ? "Received a transfusion in the past 3 months !?"
                    : "Sorry You Are Not Elgible :( dont be dissapointed you can share this to your friends  :)",
              );
            })),
          ]),
    );
  }
}

class OnboardingWidget extends StatelessWidget {
  final Widget image;
  final String quest;
  final bool toShowOpt;

  final Function() onpress1, onpress2;
  final String opt;
  const OnboardingWidget(
      {Key? key,
      required this.image,
      required this.quest,
      required this.onpress1,
      required this.onpress2,
      required this.opt,
      this.toShowOpt = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          image,
          sbh(12),
          SizedBox(
            width: size.width / 2,
            child: Center(
              child: Text(
                quest,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          sbh(24),
          Visibility(
              visible: toShowOpt,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: onpress1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                          color: opt == 'Yes'
                              ? Colors.redAccent
                              : Colors.redAccent.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(24)),
                      child: const Text(
                        "Yes",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  sbw(24),
                  InkWell(
                    onTap: onpress2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                          color: opt == 'No'
                              ? Colors.redAccent
                              : Colors.redAccent.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(24)),
                      child: const Text("No", style: TextStyle(fontSize: 20)),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
