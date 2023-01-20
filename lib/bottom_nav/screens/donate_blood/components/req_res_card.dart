import 'dart:developer';

import 'package:donation_blood/src/features/shared/domain/models/interested_donar_model.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/notification/provider/responses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../../../src/features/shared/domain/models/blood_donation_model.dart';
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
    //log(donarStat!.donarStat!);
    log(index!.toString());
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
                        ? const ReqResDonarAccepted()
                        : const ResReqDonarRejected()
                : bloodDonationModel.intrestedDonars![index!]['donarStat'] ==
                        'accepted'
                    ? const ResReqBloodReqAccepted()
                    : bloodDonationModel.intrestedDonars![index!]
                                ['donarStat'] ==
                            'declined'
                        ? const ResReqRequesterDeclined()
                        : ResReqRequesterResOn(
                            bloodDonationModel: bloodDonationModel,
                            index: index)
          ],
        ),
      ),
    );
  }
}

class ResReqRequesterResOn extends StatelessWidget {
  const ResReqRequesterResOn({
    Key? key,
    required this.bloodDonationModel,
    required this.index,
  }) : super(key: key);

  final BloodDonationModel bloodDonationModel;
  final int? index;

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
              List a = bloodDonationModel.intrestedDonars!;
              List b = [];
              for (var i = 0; i < a.length; i++) {
                InterestedDonarsModel donarsModel =
                    InterestedDonarsModel.fromMap(
                        bloodDonationModel.intrestedDonars![i]);
                b.add(donarsModel.toMap());
              }

              InterestedDonarsModel donarsModel = InterestedDonarsModel.fromMap(
                  bloodDonationModel.intrestedDonars![index!]);

              InterestedDonarsModel interestedDonarsModel =
                  InterestedDonarsModel(
                      userFrom: donarsModel.userFrom,
                      userTo: donarsModel.userTo,
                      donationId: donarsModel.donationId,
                      donarStat: "declined");
              b[index!] = interestedDonarsModel.toMap();

              Provider.of<ResponseProvider>(context, listen: false)
                  .changeStatofDonationReq(
                      interestedDonarsModel, b, a, "declined");
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
              List a = bloodDonationModel.intrestedDonars!;
              List b = [];
              for (var i = 0; i < a.length; i++) {
                InterestedDonarsModel donarsModel =
                    InterestedDonarsModel.fromMap(
                        bloodDonationModel.intrestedDonars![i]);
                b.add(donarsModel.toMap());
              }

              InterestedDonarsModel donarsModel = InterestedDonarsModel.fromMap(
                  bloodDonationModel.intrestedDonars![index!]);

              InterestedDonarsModel interestedDonarsModel =
                  InterestedDonarsModel(
                      donarsNumber: donarsModel.donarsNumber,
                      donarImage: donarsModel.donarImage,
                      donarName: donarsModel.donarName,
                      bloodGroup: donarsModel.bloodGroup,
                      lat: donarsModel.lat,
                      lng: donarsModel.lng,
                      location: donarsModel.location,
                      userFrom: donarsModel.userFrom,
                      userTo: donarsModel.userTo,
                      donationId: donarsModel.donationId,
                      donarStat: "accepted");
              b[index!] = interestedDonarsModel.toMap();

              Provider.of<ResponseProvider>(context, listen: false)
                  .changeStatofDonationReq(
                      interestedDonarsModel, b, a, "accepted");
              // Provider.of<RequestProvider>(context,
              //         listen: false)
              //     .getIntrestedDonars(bloodDonationModel
              //         .intrestedDonars!);
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
  const ResReqBloodReqAccepted({
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
      child: Column(
        children: [
          InkWell(
            onTap: () {
              
            },
            child: const Center(
                child: Text(
              "Contact Donar ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
          ),
          const Divider(
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {},
                child: const Text(
                  "Not Donated",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Text(
                  "Donated",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              )
            ],
          )
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

class ReqResDonarAccepted extends StatelessWidget {
  const ReqResDonarAccepted({
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
      child: const Text("Accepted will contact you soon"),
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
