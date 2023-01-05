
import 'package:flutter/material.dart';

import '../../../../../../../../bottom_nav/screens/home/componets/home_header.dart';
import '../../../../../../../../bottom_nav/screens/home/componets/home_view_count.dart';
import '../../../../../../../../bottom_nav/screens/home/componets/wave_clipper.dart';
import '../../../../../../../utils/colors.dart';
import '../../../../../../../utils/routes.dart';
import '../../../../../../../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  static const id = AppRoutes.homeScreen;
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Opacity(
                  opacity: 0.3,
                  child: ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                      color: Colors.red,
                      height: size.height / 2,
                    ),
                  ),
                ),
                Opacity(
                  opacity: 0.5,
                  child: ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                      color: Colors.red,
                      height: size.height / 2.2,
                    ),
                  ),
                ),
                const HomeHeader(),
                Positioned(
                    top: size.height / 6,
                    child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: HomeCountView(
                          count: "157",
                          image: "assets/home/blood.png",
                          text1: "New blood request",
                          text2: "Hyderabad",
                        ))),
                Positioned(
                    right: 0,
                    top: size.height / 6,
                    child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: HomeCountView(
                          count: "50",
                          image: "assets/home/group.png",
                          text1: "People have",
                          text2: "Shown Interest",
                        )))
              ],
            ),
            sbh(24),
            Padding(
              padding: const EdgeInsets.all(36.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    elevation: 10,
                    child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/home/find1.png",
                              scale: 8,
                            ),
                            sbh(8),
                            const Text("FIND A DONAR")
                          ],
                        )),
                  ),
                  Card(
                    elevation: 10,
                    child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/home/bloodbag.png",
                              scale: 8,
                            ),
                            sbh(8),
                            const Text("BLOOD BANKS")
                          ],
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
