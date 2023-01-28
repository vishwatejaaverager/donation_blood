import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_blood/src/features/shared/domain/models/interested_donar_model.dart';
import 'package:donation_blood/src/utils/utils.dart';
import 'package:donation_blood/src/utils/widget_utils/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../../../../../../../../bottom_nav/screens/donate_blood/providers/requests_provider.dart';
import '../../../../../../../profile_det/provider/profile_provider.dart';
import '../../../../../../domain/models/user_profile_model.dart';

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
                    InterestedDonarsModel requestData =
                        InterestedDonarsModel.fromMap(
                            snapshot.data!.docs[index].data());
                    log(requestData.toMap().toString());
                    return SeekerReqCard(bloodReq: requestData, index: index);
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
  final InterestedDonarsModel bloodReq;
  final int index;
  const SeekerReqCard({Key? key, required this.bloodReq, required this.index})
      : super(key: key);

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
                        child: CacheImage(image: bloodReq.donarImage!),
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
                            InkWell(
                              onTap: () {
                                log("message");
                                // List a = bloodReq.intrestedDonars!;
                                // List b = [];
                                // for (var i = 0; i < a.length; i++) {
                                //   InterestedDonarsModel donarsModel =
                                //       InterestedDonarsModel.fromMap(
                                //           bloodReq.intrestedDonars![i]);
                                //   b.add(donarsModel.toMap());
                                // }

                                // UserProfile userId = Provider.of<ProfileProvider>(
                                //         context,
                                //         listen: false)
                                //     .userProfile!;
                                // InterestedDonarsModel donarsModels =
                                //     InterestedDonarsModel(
                                //         donarName: userId.name,
                                //         donarsNumber: userId.phone,
                                //         userFrom: userId.userId,
                                //         bloodGroup: userId.bloodGroup,
                                //         donarImage: userId.profileImage,
                                //         donationId: bloodReq.donationId,
                                //         userTo: bloodReq.userId,
                                //         lat: userId.lat,
                                //         lng: userId.long,
                                //         location: userId.location,
                                //         donarStat: "nothing");
                                // Provider.of<RequestProvider>(context, listen: false)
                                //     .rejectTheDonation(donarsModels, a, b);
                              },
                              child: Row(
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
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            bloodReq.donarStat == 'nothing'
                ? Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16, bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            // log("message");
                            // List a = bloodReq.intrestedDonars!;
                            // List b = [];
                            // for (var i = 0; i < a.length; i++) {
                            //   InterestedDonarsModel donarsModel =
                            //       InterestedDonarsModel.fromMap(
                            //           bloodReq.intrestedDonars![i]);
                            //   b.add(donarsModel.toMap());
                            // }

                            // InterestedDonarsModel donarsModel =
                            //     InterestedDonarsModel.fromMap(
                            //         bloodReq.intrestedDonars![index]);

                            // InterestedDonarsModel interestedDonarsModel =
                            //     InterestedDonarsModel(
                            //         userFrom: donarsModel.userFrom,
                            //         userTo: donarsModel.userTo,
                            //         donationId: donarsModel.donationId,
                            //         donarStat: "declined");

                            // UserProfile userId = Provider.of<ProfileProvider>(
                            //         context,
                            //         listen: false)
                            //     .userProfile!;
                            // InterestedDonarsModel donarsModels =
                            //     InterestedDonarsModel(
                            //         donarName: userId.name,
                            //         donarsNumber: userId.phone,
                            //         userFrom: userId.userId,
                            //         bloodGroup: userId.bloodGroup,
                            //         donarImage: userId.profileImage,
                            //         donationId: bloodReq.donationId,
                            //         userTo: bloodReq.userId,
                            //         lat: userId.lat,
                            //         lng: userId.long,
                            //         location: userId.location,
                            //         donarStat: "declined");
                            //       b[index] = donarsModels.toMap();
                            // Provider.of<RequestProvider>(context, listen: false)
                            //     .rejectTheDonation(donarsModels, a, b);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.all(8),
                            child: const Center(
                                child: Text("Reject With thanks ")),
                          ),
                        )),
                        sbw(24),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            UserProfile userId = Provider.of<ProfileProvider>(
                                    context,
                                    listen: false)
                                .userProfile!;

                            InterestedDonarsModel donarsModel =
                                InterestedDonarsModel(
                                    patientName: bloodReq.patientName,
                                    isEmergency: bloodReq.isEmergency,
                                    donarName: userId.name,
                                    donarsNumber: userId.phone,
                                    userFrom: userId.userId,
                                    deadLine: bloodReq.deadLine,
                                    phoneNumber: userId.phone,
                                    bloodGroup: userId.bloodGroup,
                                    donarImage: userId.profileImage,
                                    donationId: bloodReq.donationId,
                                    userTo: bloodReq.userFrom,
                                    lat: userId.lat,
                                    lng: userId.long,
                                    location: userId.location,
                                    donarStat: "nothing");
                            Provider.of<RequestProvider>(context, listen: false)
                                .accepDonation(donarsModel, "sent_accepted");
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
                : bloodReq.donarStat == 'sent_accepted'
                    ? const Text("Waiting for response")
                    : bloodReq.donarStat == 'accepted'
                        ? const Text("Accepted")
                        : const Text("Declined")
          ],
        ));
  }
}
