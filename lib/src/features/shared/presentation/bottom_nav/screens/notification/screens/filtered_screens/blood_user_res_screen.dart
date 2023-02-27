import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_blood/bottom_nav/screens/donate_blood/components/req_res_card.dart';
import 'package:donation_blood/src/features/shared/domain/models/blood_donation_model.dart';
import 'package:donation_blood/src/features/shared/domain/models/interested_donar_model.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/notification/provider/responses_provider.dart';
import 'package:donation_blood/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BloodUserResScreen extends StatelessWidget {
  final Stream<QuerySnapshot<Map<String, dynamic>>> bloodReqByUsers;

  const BloodUserResScreen({super.key, required this.bloodReqByUsers});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloodReqByUsers,
        builder: ((context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            log("snap has data");
            //log(snapshot.data!.docs[0]['name']);
            log(snapshot.data!.docs.length.toString());
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    InterestedDonarsModel requestData =
                        InterestedDonarsModel.fromMap(
                            snapshot.data!.docs[index].data());
                    Provider.of<ResponseProvider>(context, listen: false)
                        .getUserResFromFirebase(requestData.userTo!);

                    return Consumer<ResponseProvider>(builder: ((_, __, ___) {
                      if (!__.isLoading) {
                        BloodDonationModel reqData = BloodDonationModel.fromMap(
                            __.userToDonate[index].data());
                        log(reqData.toMap().toString());

                        return ReqResCard(
                          bloodDonationModel: reqData,
                          isWaitRes: true,
                          donarStat: requestData,
                          index: index,
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }));
                  }));
            } else {
              return const Text("data");
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return const Text("some thing");
          }
        }));
  }
}

