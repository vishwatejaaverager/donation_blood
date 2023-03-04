import 'package:donation_blood/src/features/shared/presentation/bottom_nav/provider/bottom_nav_provider.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/bottom_nav_screen.dart';
import 'package:donation_blood/src/features/shared/presentation/create_req/screens/create_request_screen.dart';
import 'package:donation_blood/src/utils/navigation.dart';
import 'package:donation_blood/src/utils/widget_utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../bottom_nav/screens/donate_blood/providers/requests_provider.dart';
import '../../../../../../../../bottom_nav/screens/home/componets/home_header.dart';
import '../../../../../../../../bottom_nav/screens/home/componets/home_view_count.dart';
import '../../../../../../../../bottom_nav/screens/home/componets/wave_clipper.dart';
import '../../../../../../../utils/colors.dart';
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
    //     requestProvider = Provider.of<RequestProvider>(context, listen: false);

    // requestProvider.getAllReuests(userProfile!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
                                  .allRequests
                                  .length
                                  .toString(),
                                  crossAxisAlignment: CrossAxisAlignment.end,
                               
                              image: "assets/home/group.png",
                              text1: "Blood requests ",
                              text2: " in Hyd",
                            )),
                      ],
                    )
                  ],
                ),

                // Positioned(
                //     bottom: getProportionateScreenHeight(100),
                //     child: Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 16.0),
                //         child: HomeCountView(
                //           count:
                //               Provider.of<RequestProvider>(context, listen: false)
                //                   .sameType
                //                   .length
                //                   .toString(),
                //           image: "assets/home/blood.png",
                //           text1: "Your Type Blood Requests in",
                //           text2: "Hyderabad",
                //         ))),
                // Positioned(
                //     right: 0,
                //     bottom: getProportionateScreenHeight(100),
                //     child: const Padding(
                //         padding: EdgeInsets.symmetric(horizontal: 16.0),
                //         child: HomeCountView(
                //           count: "50",
                //           image: "assets/home/group.png",
                //           text1: "Registered",
                //           text2: "",
                //         )))
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
                    InkWell(
                      onTap: () {
                        // NotificationService().sendPushNotification(
                        //     "d15lB6xCTf6sfyjFiDCJ55:APA91bFGCNUgv-9aCnCwGqJjcABrUOrX-KMLngjkOT1NfI8JztF3BKJtW9bcHA6I7pAQZA1DiTelssrLrR40PP6Z63KHxjjYsHxkezuoLD1LcawXvPLPZw_ZxoY_M8J7jUzLL4jH5aE2",
                        //     title: "Donation Blood",
                        //     desc: "Bestie jathini denga"

                        //     );
                        Provider.of<BottomNavProvider>(context, listen: false)
                            .setPageId(3);
                        Navigation.instance
                            .pushAndRemoveUntil(BottomNavScreen.id.path);
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                            height: getProportionateScreenWidth(size.width / 3.5),
                            width: getProportionateScreenWidth(size.width / 3),
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
                                const Text("Profile")
                              ],
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        appToast("Will be integrated soon :)");
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                            height:
                                getProportionateScreenWidth(size.width / 3.5),
                            width: getProportionateScreenWidth(size.width / 3),
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
                    InkWell(
                      onTap: () {
                        Navigation.instance.navigateTo(
                          CreateReqScreen.id.path,
                        );
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                            height:
                                getProportionateScreenWidth(size.width / 3.5),
                            width: getProportionateScreenWidth(size.width / 3),
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
                    InkWell(
                      onTap: () {
                        Provider.of<BottomNavProvider>(context, listen: false)
                            .setPageId(1);
                        Navigation.instance
                            .pushAndRemoveUntil(BottomNavScreen.id.path);
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                            height:
                                getProportionateScreenWidth(size.width / 3.5),
                            width: getProportionateScreenWidth(size.width / 3),
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/home/helping_hand.png",
                                  scale: 8,
                                ),
                                sbh(8),
                                const Text("Blood Requests")
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              )

            ],
          )
          
          
                  ],
      ),
    );
  }
}
