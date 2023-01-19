import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_blood/bottom_nav/screens/donate_blood/components/req_res_card.dart';
import 'package:donation_blood/bottom_nav/screens/donate_blood/providers/requests_provider.dart';
import 'package:donation_blood/src/features/shared/domain/models/blood_donation_model.dart';
import 'package:donation_blood/src/features/shared/domain/models/user_profile_model.dart';
import 'package:donation_blood/src/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../src/features/shared/domain/models/interested_donar_model.dart';

class RequestDonarsResScreen extends StatelessWidget {
  static const id = AppRoutes.requestDonarsResScreen;
  final BloodDonationModel bloodDonationModel;
  final Stream<QuerySnapshot<Map<String, dynamic>>> donarsResToBlood;
  const RequestDonarsResScreen(
      {super.key,
      required this.bloodDonationModel,
      required this.donarsResToBlood});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: donarsResToBlood,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            //log("hhase");
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    InterestedDonarsModel requestData =
                        InterestedDonarsModel.fromMap(
                            snapshot.data!.docs[index].data());
                    Provider.of<RequestProvider>(context, listen: false)
                        .getIntrestedDonars(requestData);
                    return Consumer<RequestProvider>(builder: ((_, __, ___) {
                      if (!__.isDonarLoading) {
                        UserProfile userProfile =
                            UserProfile.fromMap(__.intrestedDonars[index]);
                        return ReqResCard(
                            userProfile: userProfile,
                            index: index,
                            donarStat: requestData,
                            bloodDonationModel: bloodDonationModel);
                      } else {
                        log(__.isDonarLoading.toString());
                        return const Text("jhb");
                      }
                    }));
                  }));
            } else {
              return const Text("kjbfjb");
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return const Text("data");
          }
        }));
  }
}
