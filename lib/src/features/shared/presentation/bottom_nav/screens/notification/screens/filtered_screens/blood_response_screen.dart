import 'dart:math' as math;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:donation_blood/src/features/shared/domain/models/interested_donar_model.dart';
import 'package:donation_blood/src/features/shared/presentation/widgets/warning_text.dart';
import 'package:donation_blood/src/utils/utils.dart';
import 'package:donation_blood/src/utils/widget_utils/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../../../../../../../../bottom_nav/screens/donate_blood/components/req_res_card.dart';
import '../../../../../../../../../bottom_nav/screens/donate_blood/providers/requests_provider.dart';
import '../../../../../../../profile_det/provider/profile_provider.dart';
import '../../../../../../domain/models/user_profile_model.dart';
import '../../../../../widgets/alert_dialog.dart';
import '../../../profile/provider/user_profile_provider.dart';
import '../../provider/responses_provider.dart';

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
            // log(snapshot.data!.docs.length.toString());
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    InterestedDonarsModel requestData =
                        InterestedDonarsModel.fromMap(
                            snapshot.data!.docs[index].data());
                    //  log(requestData.toMap().toString());
                    return SeekerReqCard(bloodReq: requestData, index: index);
                  }));
            } else {
              return const WarningWidget(
                  text: "No One is Looking For Blood :)");
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

class SeekerReqCard extends StatefulWidget {
  final InterestedDonarsModel bloodReq;
  final int index;
  const SeekerReqCard({Key? key, required this.bloodReq, required this.index})
      : super(key: key);

  @override
  State<SeekerReqCard> createState() => _SeekerReqCardState();
}

class _SeekerReqCardState extends State<SeekerReqCard> {
  late ConfettiController _controller;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 1));
    _controller.addListener(() {
      setState(() {
        isPlaying = _controller.state == ConfettiControllerState.playing;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Card(
            elevation: 20,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 2),
                        // width: 100,
                        alignment: Alignment.centerLeft,
                        decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24))),
                        child: const Text(
                          "500 Points",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Visibility(
                      visible: widget.bloodReq.isEmergency ?? true,
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 2),
                          // width: 100,
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(24))),
                          child: const Text(
                            "Emergency",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            child:
                                CacheImage(image: widget.bloodReq.donarImage!),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.bloodReq.name!.toUpperCase()} IS REQUESTING BLOOD FOR",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                Text(
                                  widget.bloodReq.patientName!.toUpperCase(),
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
                              child: Text(widget.bloodReq.bloodGroup!),
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
                                        widget.bloodReq.location!,
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
                                  onTap: () {},
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Card(
                                        elevation: 8,
                                        child: Image.asset(
                                          "assets/home/deadline.png",
                                          scale: 25,
                                        ),
                                      ),
                                      sbw(16),
                                      Text(widget.bloodReq.deadLine!,
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
                widget.bloodReq.donarStat == 'nothing'
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16, bottom: 8),
                        child: Row(
                          children: [
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return BlurryDialog("Reject",
                                        "Are You Sure Really want to Reject Request ?",
                                        () {
                                      UserProfile userId =
                                          Provider.of<ProfileProvider>(context,
                                                  listen: false)
                                              .userProfile!;
                                      Provider.of<RequestProvider>(context,
                                              listen: false)
                                          .rejectRequest(userId.userId!,
                                              widget.bloodReq.donationId!);
                                    });
                                  },
                                );
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
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return BlurryDialog("Accept",
                                        "Are You Sure Really want to Accept Request ?",
                                        () {
                                      UserProfile userId =
                                          Provider.of<ProfileProvider>(context,
                                                  listen: false)
                                              .userProfile!;

                                      InterestedDonarsModel donarsModel =
                                          InterestedDonarsModel(
                                              patientName:
                                                  widget.bloodReq.patientName,
                                              isEmergency:
                                                  widget.bloodReq.isEmergency,
                                              donarName: userId.name,
                                              donarsNumber: userId.phone,
                                              userFrom: userId.userId,
                                              userFromToken: widget.bloodReq.userFromToken,
                                              userToToken: widget.bloodReq.userToToken,
                                              isAutomated: false,
                                              name: widget.bloodReq.name,
                                              deadLine:
                                                  widget.bloodReq.deadLine,
                                              phoneNumber: userId.phone,
                                              bloodGroup: userId.bloodGroup,
                                              donarImage: userId.profileImage,
                                              donationId:
                                                  widget.bloodReq.donationId,
                                              userTo: widget.bloodReq.userFrom,
                                              lat: userId.lat,
                                              lng: userId.long,
                                              location: userId.location,
                                              donarStat: "nothing");
                                      Provider.of<RequestProvider>(context,
                                              listen: false)
                                          .accepDonation(
                                              donarsModel, "sent_accepted");
                                    });
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(8)),
                                child:
                                    const Center(child: Text("Accept Offer")),
                              ),
                            )),
                          ],
                        ),
                      )
                    : widget.bloodReq.donarStat == 'sent_accepted'
                        ? const ResReqDonarResNothing()
                        : widget.bloodReq.donarStat == 'accepted'
                            ? ResReqBloodReqAccepted(
                                tileText: "Contact Donar",
                                contactDonar: () {
                                  //   log(widget.bloodReq.phoneNumber.toString());
                                  var a = widget.bloodReq.phoneNumber;
                                  Provider.of<ResponseProvider>(context,
                                          listen: false)
                                      .launchPhoneApp("+91$a");
                                },
                                showDonated: false,
                              )
                            : widget.bloodReq.donarStat == 'donated'
                                ? ResReqBloodReqAccepted(
                                    tileText: "Donated : ) Claim 500 points",
                                    contactDonar: () {
                                      String userID =
                                          Provider.of<ProfileProvider>(context,
                                                  listen: false)
                                              .userProfile!
                                              .userId!;
                                      //  log(bloodReq.donationId!);
                                      Provider.of<UserProfileProvider>(context,
                                              listen: false)
                                          .addWalletPointsToUser(userID,
                                              widget.bloodReq.donationId!);

                                      _controller.play();
                                      appToast("You have earned 500 coins");
                                    },
                                    showDonated: false,
                                  )
                                : widget.bloodReq.donarStat == 'claimed'
                                    ? ResReqBloodReqAccepted(
                                        tileText: "Claimed :)",
                                        contactDonar: () {
                                          // String userID =
                                          //     Provider.of<ProfileProvider>(context,
                                          //             listen: false)
                                          //         .userProfile!
                                          //         .userId!;
                                          // log(bloodReq.donationId!);
                                          // Provider.of<UserProfileProvider>(context,
                                          //         listen: false)
                                          //     .addWalletPointsToUser(
                                          //         userID, bloodReq.donationId!);
                                        },
                                        showDonated: false,
                                      )
                                    : const Text("Declined")
              ],
            )),
        ConfettiWidget(
          confettiController: _controller,
          shouldLoop: false,
          blastDirectionality: BlastDirectionality.explosive,
          numberOfParticles: 10,
          emissionFrequency: 0.50,
          gravity: 0.2,
          //  createParticlePath: ,
          colors: [
            Colors.red.shade900,
            Colors.red.shade800,
            Colors.red.shade700,
            Colors.red.shade600,
            Colors.red.shade500,
            Colors.red.shade400,
            Colors.red.shade300,
            Colors.red.shade200,
            Colors.red.shade100,
          ],
        )
      ],
    );
  }
}

class _BloodDropPainter extends CustomPainter {
  final Animation<double> animation;
  final _random = Random();

  _BloodDropPainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < 100; i++) {
      final angle = _random.nextDouble() * math.pi * 2;
      final distance = _random.nextDouble() * size.width / 2;
      final radius = _random.nextDouble() * 8 + 2;
      final offset =
          Offset(math.cos(angle) * distance, math.sin(angle) * distance);

      canvas.drawCircle(center + offset, radius, paint);
    }
  }

  @override
  bool shouldRepaint(_BloodDropPainter oldDelegate) {
    return animation != oldDelegate.animation;
  }
}
