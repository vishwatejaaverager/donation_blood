import 'package:donation_blood/src/features/shared/domain/models/user_profile_model.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/profile/provider/user_profile_provider.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/profile/screens/lifes_saved/lifes_saved_screens.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/profile/screens/reward_screens/reward_screen.dart';
import 'package:donation_blood/src/features/splash_screen/splash_screen.dart';
import 'package:donation_blood/src/utils/navigation.dart';
import 'package:donation_blood/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:provider/provider.dart';

import '../../../../../../../utils/routes.dart';

class ProfileScreen extends StatefulWidget {
  static const id = AppRoutes.profileScreen;
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserProfile _userProfile;
  late UserProfileProvider _userProfileProvider;
  @override
  void initState() {
    _userProfile = globalUserProfile!;
    _userProfileProvider =
        Provider.of<UserProfileProvider>(context, listen: false);
    _userProfileProvider.daysFromPresent(
        _userProfile.donatedTime!, _userProfile.userId!);
    _userProfileProvider.getSavedLivesAndPoints(_userProfile.userId!);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _userProfileProvider =
        Provider.of<UserProfileProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            //color: Colors.red.withOpacity(0.7),
            height: size.height / 2.1,
            child: Stack(alignment: Alignment.topCenter, children: [
              Container(
                height: size.height / 2.7,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xfffa6363), // Light red
                      Colors.red, // Dark red
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                        child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.black.withOpacity(0.6),
                      child: const Icon(Icons.person),
                    )),
                    sbh(12),
                    Text(
                      "Hello ${_userProfile.name!}",
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    Text(
                      _userProfileProvider.donationDays == 90
                          ? "Available for donation"
                          : "Unavailable for donation",
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    sbh(12),
                    sbh(4),
                    Consumer<UserProfileProvider>(
                        builder: ((context, value, child) {
                      return Column(
                        children: [
                          Text(
                            "${value.daysLeft} days left to save lifes",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12)),
                            width: size.width / 1.54,
                            child: FAProgressBar(
                              currentValue: value.donationDays.toDouble(),
                              size: 25,
                              maxValue: 90,
                              changeColorValue: 100,
                              changeProgressColor: Colors.pink,
                              backgroundColor: Colors.white30,
                              progressColor: Colors.red,
                              animatedDuration:
                                  const Duration(milliseconds: 300),
                              direction: Axis.horizontal,
                              verticalDirection: VerticalDirection.up,
                              displayText: '',
                              formatValueFixed: 2,
                            ),
                          ),
                        ],
                      );
                    })),
                  ],
                ),
              ),
              Consumer<UserProfileProvider>(builder: ((context, value, child) {
                return Positioned(
                    bottom: 20,
                    child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xfff85460), // Light red
                              Color(0xfff85460), // Dark red
                            ],
                          ),
                        ),
                        child: SizedBox(
                          width: size.width / 1.2,
                          height: 85,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            color: const Color(0xfff85460),
                            elevation: 16,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: size.width / 4,
                                  height: 70,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.red, // Light red
                                        Colors.redAccent, // Dark red
                                      ],
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        value.livesCount,
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Text(
                                        "LIVES SAVED",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: size.width / 4,
                                  height: 70,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.red, // Light red
                                        Colors.redAccent, // Dark red
                                      ],
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        value.liters == "" ? "0" : value.liters,
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Text(
                                        "ml donated",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: size.width / 4,
                                  height: 70,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.red, // Light red
                                        Colors.redAccent, // Dark red
                                      ],
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        value.coins,
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Text(
                                        "blood points",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )));
              }))
            ]),
          ),
          ListTile(
            onTap: () {
              Navigation.instance.navigateTo(RewardScreen.id.path);
            },
            leading: Image.asset(
              'assets/profile/gift.png',
              scale: 15,
            ),
            title: const Text("Reward Points"),
            trailing: const Icon(
              Icons.arrow_right_alt,
              size: 32,
            ),
          ),
          sbh(12),
          ListTile(
            onTap: () {
              Navigation.instance.navigateTo(LifesSavedScreen.id.path);
            },
            leading: Image.asset(
              'assets/profile/gift.png',
              scale: 15,
            ),
            title: const Text("Lifes Saved"),
            trailing: const Icon(
              Icons.arrow_right_alt,
              size: 32,
            ),
          ),
          // ListTile(
          //   onTap: () {},
          //   leading: Image.asset(
          //     'assets/profile/life_saved.png',
          //     scale: 12,
          //   ),
          //   title: const Text("Lifes Saved"),
          //   trailing: const Icon(
          //     Icons.arrow_right_alt,
          //     size: 32,
          //   ),
          // )
        ],
      ),
    );
  }
}
