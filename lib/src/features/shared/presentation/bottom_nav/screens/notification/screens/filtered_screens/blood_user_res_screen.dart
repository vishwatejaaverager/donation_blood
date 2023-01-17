import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../../domain/models/blood_req_model.dart';
import 'blood_response_screen.dart';

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
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) {
                  
                  BloodRequestModel requestData = BloodRequestModel.fromMap(
                      snapshot.data!.docs[index].data());

                  return SeekerReqCard(bloodReq: requestData);
                }));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return const Text("some thing");
          }
        }));
  }
}
