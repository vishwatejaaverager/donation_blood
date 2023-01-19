import 'dart:developer';

import 'package:donation_blood/src/features/shared/domain/models/interested_donar_model.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/notification/provider/responses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../../../src/features/shared/domain/models/blood_donation_model.dart';
import '../../../../src/features/shared/domain/models/user_profile_model.dart';
import '../../../../src/services/dist_util.dart';
import '../../../../src/utils/utils.dart';
import '../../../../src/utils/widget_utils/cache_image.dart';

class ReqResCard extends StatelessWidget {
  const ReqResCard(
      {Key? key,
      this.userProfile,
      this.donarStat,
      this.index,
      required this.bloodDonationModel,
      this.isWaitRes = false})
      : super(key: key);

  final UserProfile? userProfile;
  final BloodDonationModel bloodDonationModel;
  final bool isWaitRes;
  final InterestedDonarsModel? donarStat;
  final int? index;

  @override
  Widget build(BuildContext context) {
    //log(donarStat!.donarStat!);
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
            ListTile(
              leading: CacheImage(
                  image: isWaitRes
                      ? bloodDonationModel.image!
                      : userProfile!.profileImage!),
              title: Text(isWaitRes
                  ? bloodDonationModel.name!
                  : userProfile!.name!.toUpperCase()),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width / 2,
                    child: ReadMoreText(
                      isWaitRes
                          ? bloodDonationModel.location!
                          : userProfile!.location!,
                      trimLines: 2,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      //  preDataTextStyle: TextStyle(fontWeight: FontWeight.bold),
                      trimLength: 20,
                      colorClickableText: Colors.pink,
                      trimMode: TrimMode.Line,
                      lessStyle: const TextStyle(fontWeight: FontWeight.w400),
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                      moreStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ),
                  isWaitRes
                      ? const SizedBox()
                      : Text(
                          "${calcDistInKms(bloodDonationModel.lat!.toDouble(), bloodDonationModel.long!.toDouble(), userProfile!.lat!.toDouble(), userProfile!.long!.toDouble())} Km's")
                ],
              ),
              trailing: CircleAvatar(
                child: Center(
                  child: Text(bloodDonationModel.bloodGroup!),
                ),
              ),
            ),
            sbh(12),
            isWaitRes
                ? donarStat!.donarStat == 'nothing'
                    ? Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(24),
                                bottomRight: Radius.circular(24))),
                        child: const Text("Waiting For Confirmation"),
                      )
                    : donarStat!.donarStat == 'accepted'
                        ? Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(24),
                                    bottomRight: Radius.circular(24))),
                            child: const Text("Accepted will contact you soon"),
                          )
                        : Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(24),
                                    bottomRight: Radius.circular(24))),
                            child: const Text("Rejected with thanks :)"),
                          )
                : Container(
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
                          onTap: () {},
                          child: SizedBox(
                            width: size.width / 2,
                            child: const Text(
                              "DECLINE",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            List a = bloodDonationModel.intrestedDonars!;

                            InterestedDonarsModel donarsModel =
                                InterestedDonarsModel.fromMap(bloodDonationModel
                                    .intrestedDonars![index!]);
                            

                            InterestedDonarsModel interestedDonarsModel =
                                InterestedDonarsModel(
                                    userFrom: donarsModel.userFrom,
                                    userTo: donarsModel.userTo,
                                    donationId: donarsModel.donationId,
                                    donarStat: "accepted");
                            a[index!] = interestedDonarsModel.toMap();
                            log(interestedDonarsModel.userFrom!);

                            Provider.of<ResponseProvider>(context,
                                    listen: false)
                                .changeStatofDonationReq(interestedDonarsModel,a);
                          },
                          child: Container(
                            width: size.width / 3,
                            alignment: Alignment.bottomRight,
                            child: const Text(
                              "CONFIRM",
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
