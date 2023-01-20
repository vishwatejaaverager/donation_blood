import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_blood/bottom_nav/screens/donate_blood/screens/donate_blood_screen.dart';
import 'package:donation_blood/bottom_nav/screens/donate_blood/screens/request_response_screens/request_donar_res_screen.dart';
import 'package:donation_blood/src/features/shared/domain/models/blood_donation_model.dart';
import 'package:donation_blood/src/utils/streams.dart';
import 'package:donation_blood/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../src/features/profile_det/provider/profile_provider.dart';
import '../../../../../src/utils/routes.dart';

class BloodDetailResScreen extends StatefulWidget {
  static const id = AppRoutes.bloodDetailResScreen;
  final BloodDonationModel bloodDonationModel;
  final String? bloodId;
  const BloodDetailResScreen(
      {super.key, required this.bloodDonationModel, this.bloodId});

  @override
  State<BloodDetailResScreen> createState() => _BloodDetailResScreenState();
}

class _BloodDetailResScreenState extends State<BloodDetailResScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Streams _streams = Streams();
  //late Stream<QuerySnapshot<Map<String, dynamic>>> _donarsResToBlood;
  late Stream<QuerySnapshot<Map<String, dynamic>>> bloodReqByUsers;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    // _donarsResToBlood = _streams.userQuery
    //     .doc(widget.bloodDonationModel.userId!)
    //     .collection(Streams.requestByUser)
    //     .doc(widget.bloodDonationModel.donationId)
    //     .collection(Streams.otherDonarsIntrest)
    //     .snapshots();
   var   userProfile =
        Provider.of<ProfileProvider>(context, listen: false).userProfile!;
    bloodReqByUsers = _streams.userQuery
        .doc(userProfile.userId!)
        .collection(Streams.requestByUser)
        .snapshots();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            FrequencyTabs(
                controller: _tabController,
                tags: const [],
                tabs: const [
                  SizedBox(
                    child: Text(
                      "Donars",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    child: Text("Blood Banks"),
                  )
                ]),
            sbh(12),
            Expanded(
                child: TabBarView(
              controller: _tabController,
              children: [
                RequestDonarsResScreen(
                  donarsResToBlood: bloodReqByUsers,
                    bloodDonationModel: widget.bloodDonationModel),
                const Text("data")
              ],
            ))
          ],
        ),
      ),
    );
  }
}
