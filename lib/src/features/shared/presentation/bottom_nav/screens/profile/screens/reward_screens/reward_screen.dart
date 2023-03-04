import 'package:donation_blood/src/features/profile_det/provider/profile_provider.dart';
import 'package:donation_blood/src/features/shared/domain/models/user_profile_model.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/profile/provider/user_profile_provider.dart';
import 'package:donation_blood/src/features/shared/presentation/widgets/warning_text.dart';
import 'package:donation_blood/src/utils/routes.dart';
import 'package:donation_blood/src/utils/utils.dart';
import 'package:donation_blood/src/utils/widget_utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RewardScreen extends StatefulWidget {
  static const id = AppRoutes.rewardScreen;
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  late UserProfile _profile;

  @override
  void initState() {
    _profile =
        Provider.of<ProfileProvider>(context, listen: false).userProfile!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Rewards",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<UserProfileProvider>(builder: ((context, value, child) {
            return Container(
              margin: const EdgeInsets.all(16),
              // height: size.height / 3,
              width:getProportionateScreenWidth(size.width),
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Coins",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Blood Donation",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    sbh(12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          value.coins,
                          style: const TextStyle(
                              fontSize: 48, color: Colors.white),
                        ),
                        const Text(
                          " Coins",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )
                      ],
                    ),
                    sbh(12),
                    Text(
                      _profile.name!,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Text(
                      _profile.phone!.substring(3),
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    )
                  ],
                ),
              ),
            );
          })),
          const Padding(
            padding: EdgeInsets.only(left: 24.0),
            child: Text(
              "Rewards for Saving Lifes",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        //  sbh(12),
          const Center(
            child: WarningWidget(
                scale: 7, text: " Rewards Will be available soooonnnnnnn :)"),
          ),
        //  sbh(12)
        ],
      ),
    ));
  }
}
