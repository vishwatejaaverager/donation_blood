import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_blood/src/features/shared/domain/models/blood_donation_model.dart';
import 'package:donation_blood/src/features/shared/presentation/widgets/warning_text.dart';
import 'package:donation_blood/src/utils/routes.dart';
import 'package:flutter/material.dart';

import '../../../../../src/features/shared/domain/models/interested_donar_model.dart';
import '../../../../../src/utils/utils.dart';
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
              return Column(
                children: [
                  Container(
                      alignment: Alignment.bottomCenter,
                      width: size.width,
                      padding: const EdgeInsets.only(bottom: 16, top: 4),
                      decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12))),
                      child: const Text(
                        "The donors who have shown interest to donate will be displayed here.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) {
                        InterestedDonarsModel donar =
                            InterestedDonarsModel.fromMap(
                                snapshot.data!.docs[index].data());

                        return ReqResCard(
                            isWaitRes: false,
                            index: index,
                            donarStat: donar,
                            bloodDonationModel: bloodDonationModel);
                      }))
                ],
              );
            } else {
              return const WarningWidget(
                  text1:
                      "The donors who have shown interest to donate will be displayed here.",
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
