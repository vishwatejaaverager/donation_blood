import 'package:donation_blood/bottom_nav/screens/donate_blood/providers/requests_provider.dart';
import 'package:donation_blood/bottom_nav/screens/donate_blood/screens/request_response_screens/donation_detail_res_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../src/features/shared/domain/models/blood_donation_model.dart';
import '../../../../src/features/shared/presentation/widgets/sharable_widgte.dart';
import '../../../../src/utils/navigation.dart';
import '../../../../src/utils/utils.dart';
import '../screens/donate_blood_details_sreen.dart';

class RequestBloodCard extends StatelessWidget {
  final BloodDonationModel bloodDonationModel;
  final bool showHosp;
  final bool isDetail;
  final String? id;
  final ScreenshotController? controller;
  const RequestBloodCard({
    required this.bloodDonationModel,
    this.controller,
    this.showHosp = true,
    this.isDetail = false,
    this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 70,
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(100),
                        )),
                    child: Center(
                      child: Text(
                        bloodDonationModel.bloodGroup!,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  sbw(12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Request Blood",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      Text(bloodDonationModel.donationStat!)
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  if (isDetail) {
                    Navigation.instance.navigateTo(BloodDetailResScreen.id.path,
                        args: {
                          'bloodDonationInfo': bloodDonationModel,
                          'id': id
                        });
                  } else {
                    Navigation.instance.navigateTo(BloodDonateReqScreen.id.path,
                        args: bloodDonationModel);
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 24, top: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(24)),
                  child: Text(
                    isDetail ? "Details" : "Donate",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              )
              // AnimatedButton(
              //   onPress: () {},
              //   height: 10,
              //   //width: 100,
              //   text: 'Donate',
              //   isReverse: true,
              //   selectedTextColor: Colors.black,
              //   transitionType: TransitionType.BOTTOM_TO_TOP,
              //   // textStyle: submitTextStyle,
              //   backgroundColor: Colors.black,
              //   borderColor: Colors.white,
              //   borderRadius: 12,
              //   borderWidth: 2,
              // ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Patient",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    sbw(8),
                    Text(
                      bloodDonationModel.patientName!,
                      style: TextStyle(color: Colors.grey.shade600),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Needs ${bloodDonationModel.units!}",
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        sbw(8),
                        Text(
                          "units",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        sbw(8),
                        Text(
                          "(Donated ${bloodDonationModel.donatedUnits!} units)",
                          style: const TextStyle(color: Colors.red),
                        )
                      ],
                    ),
                    Text("Untill ${bloodDonationModel.deadLine!}")
                  ],
                ),
                sbh(4),
                const Divider(
                  thickness: 1,
                  height: 5,
                ),
                sbh(4),
                showHosp
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.gps_fixed),
                                
                                SizedBox(
                                  width: size.width /1.8,
                                  child: Text(
                                    bloodDonationModel.location!,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                )
                              ],
                            ),
                            Consumer<RequestProvider>(
                                builder: ((context, value, child) {
                              return InkWell(
                                onTap: () async {
                                  final image = await controller!
                                      .captureFromWidget(SharableWidget(
                                    bloodInfo: bloodDonationModel,
                                  ));
                                  value.shareImage(image);
                                  // final images =
                                  //     (await decodeImageFromList(image));
                                  // ByteData? byteData = await images.toByteData(
                                  //     format: ImageByteFormat.png);
                                },
                                child: Card(
                                  elevation: 20,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Container(
                                    //  padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: const Icon(Icons.share),
                                  ),
                                ),
                              );
                            }))
                          ],
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//dart
// // painter class paints home screen background curved
// class BackgroundDesign extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final height = size.height;
//     final width = size.width;
//     Paint paint = Paint();

//     Path ovalPath = Path();

//     // start paint from 20% height to the right
//     ovalPath.moveTo(width, height * 0);

//     // paint a curve from current position to middle of screen
//     ovalPath.quadraticBezierTo(width * 0.7, height * 0.75, 0, height);

//     // draw remaining line to bottom right side
//     ovalPath.lineTo(width, height);

//     // paint.color = kLightGreyColor.withOpacity(0.5);
//     // paint.color = kGoldenColor.withOpacity(0.99);
//     paint.color = AppColors.blackColor.withOpacity(0.85);
//     canvas.drawPath(ovalPath, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
//}
