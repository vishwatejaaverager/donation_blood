import 'package:donation_blood/src/features/profile_det/provider/profile_provider.dart';
import 'package:donation_blood/src/features/shared/domain/models/user_profile_model.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/profile/provider/user_profile_provider.dart';
import 'package:donation_blood/src/features/shared/presentation/widgets/warning_text.dart';
import 'package:donation_blood/src/features/splash_screen/splash_screen.dart';
import 'package:donation_blood/src/utils/routes.dart';
import 'package:donation_blood/src/utils/utils.dart';
import 'package:donation_blood/src/utils/widget_utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/donar_card.dart';

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
    _profile = globalUserProfile!;
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
          DonarCard(profile: _profile),
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

