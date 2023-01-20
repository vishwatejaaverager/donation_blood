import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_blood/src/features/shared/domain/models/blood_donation_model.dart';
import 'package:donation_blood/src/features/shared/domain/models/blood_req_model.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/notification/provider/responses_provider.dart';
import 'package:donation_blood/src/utils/utils.dart';
import 'package:donation_blood/src/utils/widget_utils/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class SeekersResponseScreen extends StatelessWidget {
  final Stream<QuerySnapshot<Map<String, dynamic>>> seekerRequests;
  const SeekersResponseScreen({super.key, required this.seekerRequests});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: seekerRequests,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            //log("hhase");
            log(snapshot.data!.docs.length.toString());
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    BloodDonationModel requestData = BloodDonationModel.fromMap(
                        snapshot.data!.docs[index].data());
                    log(requestData.toMap().toString());
                    return SeekerReqCard(bloodReq: requestData);
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

// ListView.builder(
//           itemCount: __.isLoading
//               ? 5
//               : __.seekerRequest.isEmpty
//                   ? 1
//                   : __.seekerRequest.length,
//           itemBuilder: ((context, index) {
//             if (!__.isLoading && __.seekerRequest.isNotEmpty) {
//               log("okok");
//               BloodRequestModel requestData =
//                   BloodRequestModel.fromMap(__.seekerRequest[index].data());
//               return SeekerReqCard(bloodReq: requestData);
//             } else if (__.isLoading) {
//               // log("message");
//               return const CircularProgressIndicator();
//             } else {
//               log("came");
//               return const Center(child: Text("No Requests"));
//             }
//           }));

class SeekerReqCard extends StatelessWidget {
  final BloodDonationModel bloodReq;
  const SeekerReqCard({
    Key? key,
    required this.bloodReq,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 20,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Column(
          children: [
            Visibility(
              visible: bloodReq.isEmergency ?? true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 2),
                      // width: 100,
                      alignment: Alignment.centerLeft,
                      decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(24))),
                      child: const Text(
                        "Emergency",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: CacheImage(image: bloodReq.image!),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${bloodReq.name!.toUpperCase()} IS REQUESTING BLOOD FOR",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            Text(
                              bloodReq.patientName!.toUpperCase(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 16),
                            ),
                            // Text(bloodReq.distance!)
                          ],
                        ),
                      )
                    ],
                  ),
                  sbh(2),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: CircleAvatar(
                          radius: 25,
                          child: Text(bloodReq.bloodGroup!),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Card(
                                    elevation: 8,
                                    child: Image.asset(
                                      "assets/home/hospital.png",
                                      scale: 22,
                                    )),
                                sbw(12),
                                SizedBox(
                                  width: size.width / 2,
                                  child: ReadMoreText(
                                    bloodReq.location!,
                                    trimLines: 2,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    //  preDataTextStyle: TextStyle(fontWeight: FontWeight.bold),
                                    trimLength: 20,
                                    colorClickableText: Colors.pink,
                                    trimMode: TrimMode.Line,
                                    lessStyle: const TextStyle(
                                        fontWeight: FontWeight.w400),
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: 'Show less',
                                    moreStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            sbh(8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Card(
                                  elevation: 8,
                                  child: Image.asset(
                                    "assets/home/deadline.png",
                                    scale: 25,
                                  ),
                                ),
                                sbw(16),
                                Text(bloodReq.deadLine!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              //sbw(24),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 8),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.all(8),
                    child: const Center(child: Text("Reject With thanks ")),
                  )),
                  sbw(24),
                  Expanded(
                      child: InkWell(
                        onTap: () {
                          
                        },
                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(8)),
                                          child: const Center(child: Text("Accept Offer")),
                                        ),
                      )),
                ],
              ),
            )
          ],
        ));
  }
}
