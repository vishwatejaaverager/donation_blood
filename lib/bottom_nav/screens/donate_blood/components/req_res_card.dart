import 'dart:developer';

import 'package:donation_blood/src/features/shared/domain/models/interested_donar_model.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/notification/provider/responses_provider.dart';
import 'package:donation_blood/src/features/shared/presentation/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../../../src/features/profile_det/provider/profile_provider.dart';
import '../../../../src/features/shared/domain/models/blood_donation_model.dart';
import '../../../../src/features/shared/domain/models/user_profile_model.dart';
import '../../../../src/services/dist_util.dart';
import '../../../../src/utils/utils.dart';
import '../../../../src/utils/widget_utils/cache_image.dart';

class ReqResCard extends StatelessWidget {
  const ReqResCard(
      {Key? key,
      this.donarStat,
      this.index,
      required this.bloodDonationModel,
      this.isWaitRes = false})
      : super(key: key);

  final BloodDonationModel bloodDonationModel;
  final bool isWaitRes;
  final InterestedDonarsModel? donarStat;
  final int? index;

  @override
  Widget build(BuildContext context) {
    log(donarStat!.donarStat!);
    log(bloodDonationModel.units!);

    // log(index!.toString());
    return Card(
      elevation: 8,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24))),
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ResReqCardHeader(
                isWaitRes: isWaitRes,
                bloodDonationModel: bloodDonationModel,
                donarStat: donarStat),
            sbh(12),
            isWaitRes
                ? donarStat!.donarStat == 'nothing'
                    ? const ResReqDonarResNothing()
                    : donarStat!.donarStat == 'accepted'
                        ? const ReqResDonarStatTile(
                            text: "Accepted will contact you soon",
                          )
                        : const ReqResDonarStatTile(
                            text: "Rejected with thanks",
                          )
                : donarStat!.donarStat == 'accepted'
                    ? ResReqBloodReqAccepted(
                        tileText: "Contact Donar",
                        contactDonar: () {
                          log(donarStat!.phoneNumber.toString());
                          Provider.of<ResponseProvider>(context, listen: false)
                              .launchPhoneApp(donarStat!.phoneNumber!);
                        },
                        notDonated: () {
                          showDialog(
                              context: context,
                              builder: ((context) {
                                return BlurryDialog("Donation",
                                    "Are you sure you want to keep it has not donated ?",
                                    (() {
                                  Provider.of<ResponseProvider>(context,
                                          listen: false)
                                      .actualAcceptAndRejectDonation(
                                          donarStat!, "not_donated");
                                }));
                              }));
                        },
                        donated: () {
                          showDialog(
                              context: context,
                              builder: ((context) {
                                return BlurryDialog(
                                  "Donation",
                                  "Are you sure you want to keep it has  donated ?",
                                  (() {
                                    log(bloodDonationModel.units!);
                                    log(bloodDonationModel.donatedUnits!);
                                    // log(donarStat!.toMap().toString());
                                    Provider.of<ResponseProvider>(context,
                                            listen: false)
                                        .actualAcceptAndRejectDonation(

                                            donarStat!, "donated",
                                            bloodDonationModel:
                                                bloodDonationModel,
                                              realunits: Provider.of<ProfileProvider>(context,listen: false).unitDrop
                                                );
                                  }),
                                  isUnits: true,
                                );
                              }));
                        },
                      )
                    : donarStat!.donarStat == 'declined'
                        ? const ResReqRequesterDeclined()
                        : donarStat!.donarStat == 'donated'
                            ? const ReqResDonarStatTile(text: "Donated")
                            : donarStat!.donarStat == 'not_donated'
                                ? const ReqResDonarStatTile(
                                    text: "Marked as not Donated")
                                : ResReqRequesterResOn(
                                    bloodReq: donarStat!,
                                  )
          ],
        ),
      ),
    );
  }
}

class ResReqRequesterResOn extends StatelessWidget {
  const ResReqRequesterResOn({
    Key? key,
    required this.bloodReq,
  }) : super(key: key);

  final InterestedDonarsModel bloodReq;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: ((context) {
                    return BlurryDialog(
                        "Decline", "Are you sure want to decline ?", (() {
                      UserProfile userId =
                          Provider.of<ProfileProvider>(context, listen: false)
                              .userProfile!;

                      InterestedDonarsModel donarsModel = InterestedDonarsModel(
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

                      Provider.of<ResponseProvider>(context, listen: false)
                          .acceptDonationFromDonarAndReject(
                              donarsModel, "declined",
                              isReject: false);
                    }));
                  }));
            },
            child: SizedBox(
              width: size.width / 2,
              child: const Text(
                "DECLINE",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: ((context) {
                    return BlurryDialog(
                        "Confirm", "Are you sure want to confirm ?", (() {
                      UserProfile userId =
                          Provider.of<ProfileProvider>(context, listen: false)
                              .userProfile!;

                      InterestedDonarsModel donarsModel = InterestedDonarsModel(
                          patientName: bloodReq.patientName,
                          isEmergency: bloodReq.isEmergency,
                          donarName: userId.name,
                          donarsNumber: userId.phone,
                          userFrom: userId.userId,
                          deadLine: bloodReq.deadLine,
                          phoneNumber: userId.phone,
                          userFromToken: bloodReq.userFromToken,
                          userToToken: bloodReq.userToToken,
                          isAutomated: false,
                          name: bloodReq.name,
                          bloodGroup: userId.bloodGroup,
                          donarImage: userId.profileImage,
                          donationId: bloodReq.donationId,
                          userTo: bloodReq.userFrom,
                          lat: userId.lat,
                          lng: userId.long,
                          location: userId.location,
                          donarStat: "nothing");

                      Provider.of<ResponseProvider>(context, listen: false)
                          .acceptDonationFromDonarAndReject(
                              donarsModel, "accepted");
                      // Provider.of<RequestProvider>(context,
                      //         listen: false)
                      //     .getIntrestedDonars(bloodDonationModel
                      //         .intrestedDonars!);
                    }));
                  }));
            },
            child: Container(
              width: size.width / 3,
              alignment: Alignment.bottomRight,
              child: const Text(
                "CONFIRM",
                style: TextStyle(
                    color: Colors.redAccent, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ResReqRequesterDeclined extends StatelessWidget {
  const ResReqRequesterDeclined({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                )),
            child: const Center(
                child: Text(
              "Declined By You",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
          ),
        ],
      ),
    );
  }
}

class ResReqBloodReqAccepted extends StatelessWidget {
  final bool decideDonated, showDonated;
  final String donationStat, tileText;

  final Function()? contactDonar, notDonated, donated;

  const ResReqBloodReqAccepted({
    this.decideDonated = false,
    this.donationStat = '',
    this.contactDonar,
    this.notDonated,
    this.donated,
    this.tileText = '',
    this.showDonated = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          )),
      child: decideDonated
          ? Center(
              child: Text(
                donationStat,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            )
          : Column(
              children: [
                InkWell(
                  onTap: contactDonar,
                  child: Center(
                      child: Text(
                    tileText,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  )),
                ),
                showDonated
                    ? const Divider(
                        thickness: 2,
                      )
                    : const SizedBox(),
                showDonated
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: notDonated,
                            child: const Text(
                              "Not Donated",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          InkWell(
                            onTap: donated,
                            child: const Text(
                              "Donated",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          )
                        ],
                      )
                    : const SizedBox()
              ],
            ),
    );
  }
}

class ResReqDonarRejected extends StatelessWidget {
  const ResReqDonarRejected({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24))),
      child: const Text("Rejected with thanks :)"),
    );
  }
}

class ReqResDonarStatTile extends StatelessWidget {
  final String text;
  const ReqResDonarStatTile({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24))),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}

class ResReqDonarResNothing extends StatelessWidget {
  const ResReqDonarResNothing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24))),
      child: const Text("Waiting For Confirmation"),
    );
  }
}

class ResReqCardHeader extends StatelessWidget {
  const ResReqCardHeader({
    Key? key,
    required this.isWaitRes,
    required this.bloodDonationModel,
    required this.donarStat,
  }) : super(key: key);

  final bool isWaitRes;
  final BloodDonationModel bloodDonationModel;
  final InterestedDonarsModel? donarStat;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CacheImage(
          image:
              isWaitRes ? bloodDonationModel.image! : donarStat!.donarImage!),
      title: Text(isWaitRes
          ? bloodDonationModel.name!
          : donarStat!.donarName!.toUpperCase()),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: size.width / 2,
            child: ReadMoreText(
              isWaitRes ? bloodDonationModel.location! : donarStat!.location!,
              trimLines: 2,
              style: const TextStyle(fontWeight: FontWeight.bold),
              //  preDataTextStyle: TextStyle(fontWeight: FontWeight.bold),
              trimLength: 20,
              colorClickableText: Colors.pink,
              trimMode: TrimMode.Line,
              lessStyle: const TextStyle(fontWeight: FontWeight.w400),
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
              moreStyle:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
          isWaitRes
              ? const SizedBox()
              : Text(
                  "${calcDistInKms(bloodDonationModel.lat!.toDouble(), bloodDonationModel.long!.toDouble(), donarStat!.lat!.toDouble(), donarStat!.lng!.toDouble())} Km's")
        ],
      ),
      trailing: CircleAvatar(
        child: Center(
          child: Text(bloodDonationModel.bloodGroup!),
        ),
      ),
    );
  }
}
