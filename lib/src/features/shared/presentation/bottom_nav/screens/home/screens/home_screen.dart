import 'package:donation_blood/src/features/shared/presentation/bottom_nav/provider/bottom_nav_provider.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/bottom_nav_screen.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/home/components/home_tile.dart';
import 'package:donation_blood/src/features/shared/presentation/create_req/screens/create_request_screen.dart';
import 'package:donation_blood/src/features/splash_screen/splash_screen.dart';
import 'package:donation_blood/src/utils/navigation.dart';
import 'package:donation_blood/src/utils/widget_utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../bottom_nav/screens/donate_blood/providers/requests_provider.dart';
import '../../../../../../../../bottom_nav/screens/home/componets/home_header.dart';
import '../../../../../../../../bottom_nav/screens/home/componets/home_view_count.dart';
import '../../../../../../../../bottom_nav/screens/home/componets/wave_clipper.dart';
import '../../../../../../../utils/routes.dart';
import '../../../../../../../utils/utils.dart';
import '../../../../../domain/models/user_profile_model.dart';

class HomeScreen extends StatefulWidget {
  static const id = AppRoutes.homeScreen;
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserProfile? userProfile;
  late RequestProvider requestProvider;
  @override
  void initState() {
    // Provider.of<RequestProvider>(context, listen: false)
    //     .getTokenAndSave(value.userId!)
    //     .then((value) {

    // });
    // Future.delayed(const Duration(seconds: 5), () {
    // Provider.of<ProfileProvider>(context, listen: false).getUserInfo();
    // userProfile =
    //     Provider.of<ProfileProvider>(context, listen: false).userProfile!;
    // requestProvider = Provider.of<RequestProvider>(context, listen: false);

    // requestProvider.getAllReuests(globalUserProfile!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: size.width,
              height: size.height / 3,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Opacity(
                    opacity: 0.8,
                    child: ClipPath(
                      clipper: WaveClipper(),
                      child: Container(
                        color: Colors.red,
                        height: getProportionateScreenHeight(300),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      sbh(16),
                      const HomeHeader(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4),
                              child: HomeCountView(
                                count: Provider.of<RequestProvider>(context,
                                        listen: false)
                                    .sameType
                                    .length
                                    .toString(),
                                image: "assets/home/blood.png",
                                text1: "Your Type Blood ",
                                text2: "Requests in Hyderabad",
                              )),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4),
                              child: HomeCountView(
                                count: Provider.of<RequestProvider>(context,
                                        listen: false)
                                    .completedReq
                                    .length
                                    .toString(),
                                crossAxisAlignment: CrossAxisAlignment.end,
                                image: "assets/home/group.png",
                                text1: "Lifes saved in ",
                                text2: " Blood Aid",
                              )),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      HomeTile(
                        ontap: () {
                          Provider.of<BottomNavProvider>(context, listen: false)
                              .setPageId(3);
                          Navigation.instance
                              .pushAndRemoveUntil(BottomNavScreen.id.path);
                        },
                        image: "assets/home/find1.png",
                        text: "Profile",
                        scale: 8,
                      ),
                      HomeTile(
                        ontap: () {
                          appToast("Will be integrated soon :)");
                        },
                        image: "assets/home/bloodbag.png",
                        text: "Blood Banks",
                        scale: 8,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      HomeTile(
                        ontap: () {
                          Navigation.instance
                              .navigateTo(CreateReqScreen.id.path);
                        },
                        image: "assets/home/req.png",
                        text: "Create Request",
                        scale: 8,
                      ),
                      HomeTile(
                        ontap: () {
                          Provider.of<BottomNavProvider>(context, listen: false)
                              .setPageId(1);
                          Navigation.instance
                              .pushAndRemoveUntil(BottomNavScreen.id.path);
                        },
                        image: "assets/home/helping_hand.png",
                        text: "Blood Requests",
                        scale: 8,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
