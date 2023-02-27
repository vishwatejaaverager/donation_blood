import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_blood/src/features/shared/domain/models/blood_donation_model.dart';
import 'package:donation_blood/src/features/shared/presentation/widgets/warning_text.dart';
import 'package:donation_blood/src/utils/routes.dart';
import 'package:flutter/material.dart';

import '../../../../../src/features/shared/domain/models/interested_donar_model.dart';
import '../../components/req_res_card.dart';

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
    //log(widget.bloodDonationModel.intrestedDonars![0].toString());
    return StreamBuilder(
        stream: donarsResToBlood,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            //log("hhase");
            log(snapshot.data!.docs.length.toString());
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    InterestedDonarsModel donar = InterestedDonarsModel.fromMap(
                        snapshot.data!.docs[index].data());

                    return ReqResCard(
                        isWaitRes: false,
                        index: index,
                        donarStat: donar,
                        bloodDonationModel: bloodDonationModel);
                  }));
            } else {
              return const WarningWidget(
                  text: "No Response From Donars :( \n Hold tight :) ");
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return const Text("data");
          }
        }));
  }
}
