import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_blood/bottom_nav/screens/donate_blood/screens/donate_blood_screen.dart';
import 'package:donation_blood/src/features/shared/domain/models/blood_donation_model.dart';
import 'package:flutter/material.dart';

import '../../components/request_blood_card.dart';

class UserBloodRequestsScreen extends StatelessWidget {
  final Stream<QuerySnapshot<Map<String, dynamic>>> bloodReqByUsers;
  const UserBloodRequestsScreen({super.key, required this.bloodReqByUsers});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloodReqByUsers,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) {
                  BloodDonationModel requestData = BloodDonationModel.fromMap(
                      snapshot.data!.docs[index].data());

                  return RequestBloodCard(
                    bloodDonationModel: requestData,
                    showHosp: false,
                    isDetail: true,
                  );
                }));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return const Text("some thing");
          }
        }));
  }
}
