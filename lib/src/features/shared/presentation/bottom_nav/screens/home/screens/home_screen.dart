import 'package:donation_blood/bottom_nav/screens/donate_blood/providers/requests_provider.dart';
import 'package:donation_blood/src/features/profile_det/provider/profile_provider.dart';
import 'package:donation_blood/src/features/shared/presentation/create_req/screens/create_request_screen.dart';
import 'package:donation_blood/src/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    Provider.of<ProfileProvider>(context, listen: false).getUserInfo();

    super.initState();
  }

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
                      height: size.height / 3,
                    ),
                  ),
                ),
                Opacity(
                  opacity: 0.5,
                  child: ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                      color: Colors.red,
                      height: size.height / 3,
                    ),
                  ),
                ),
                const HomeHeader(),
                const Positioned(
                    top: 100,
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: HomeCountView(
                          count: "157",
                          image: "assets/home/blood.png",
                          text1: "New blood request",
                          text2: "Hyderabad",
                        ))),
                const Positioned(
                    right: 0,
                    top: 100,
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: HomeCountView(
                          count: "50",
                          image: "assets/home/group.png",
                          text1: "Registered",
                          text2: "",
                        )))
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      
                    },
                    child: Card(
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
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigation.instance.navigateTo(
                        CreateReqScreen.id.path,
                      );
                    },
                    child: Card(
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
                                "assets/home/req.png",
                                scale: 8,
                              ),
                              sbh(8),
                              const Text("Create Request")
                            ],
                          )),
                    ),
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
                              "assets/home/req.png",
                              scale: 8,
                            ),
                            sbh(8),
                            const Text("Blood Requests")
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
