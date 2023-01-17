import 'dart:developer';

import 'package:donation_blood/src/features/authentication/presentation/login_screen/login_button.dart';
import 'package:donation_blood/src/features/profile_det/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

import '../../../../../../../utils/navigation.dart';
import '../../../../../../../utils/utils.dart';
import '../../../../../../../utils/widget_utils/cache_image.dart';
import '../../../../../../profile_det/screens/location_search_screen.dart';
import '../../../../../domain/models/blood_req_model.dart';
import '../../../../../domain/models/user_profile_model.dart';
import '../../../../widgets/text_fields.dart';
import '../provider/donar_provider.dart';

class DonarCardWidget extends StatelessWidget {
  final UserProfile userProfile;
  final DonarProvider donarProvider;

  const DonarCardWidget({
    required this.userProfile,
    required this.donarProvider,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      //shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 8,
      child: ListTile(
        onTap: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              builder: ((context) {
                return DonarsBottomSheet(
                    userProfile: userProfile, donarProvider: donarProvider);
              }));
        },
        title: Text(userProfile.name!),
        leading: CircleAvatar(
          radius: 30,
          child: CacheImage(
              fit: BoxFit.fitWidth, image: userProfile.profileImage!),
        ),
        trailing: CircleAvatar(
          backgroundColor: Colors.redAccent,
          radius: 30,
          child: Text(
            userProfile.bloodGroup!,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: SizedBox(
            width: size.width / 3,
            child: Text(
              userProfile.location!,
              overflow: TextOverflow.ellipsis,
            )),
      ),
    );
  }
}

class DonarsBottomSheet extends StatefulWidget {
  const DonarsBottomSheet({
    Key? key,
    required this.userProfile,
    required this.donarProvider,
  }) : super(key: key);

  final UserProfile userProfile;
  final DonarProvider donarProvider;

  @override
  State<DonarsBottomSheet> createState() => _DonarsBottomSheetState();
}

class _DonarsBottomSheetState extends State<DonarsBottomSheet> {
  TextEditingController nameController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CacheImage(image: widget.userProfile.profileImage!),
              title: Text(widget.userProfile.name!),
              subtitle: Text(widget.donarProvider.calcDistFromUser(
                          fetchedUser: widget.userProfile, context) ==
                      "0.0"
                  ? "0.10 km"
                  : "${widget.donarProvider.calcDistFromUser(fetchedUser: widget.userProfile, context)} Km's"),
            ),
            Consumer<ProfileProvider>(builder: ((context, __, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 4),
                    child: ReqTextFiled(
                      controller: nameController,
                      sideHeading: "Patient Name",
                      icon: const Icon(Icons.person),
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                    child: Text(
                      "Required by",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                            elevation: 6,
                            child: Image.asset(
                              "assets/home/calendar.png",
                              scale: 20,
                            )),
                        sbw(4),
                        InkWell(
                          onTap: () async {
                            final picker = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2025),
                            );
                            if (picker != null) {
                              String formattedDate =
                                  Jiffy(picker).format('MMM do ');
                              __.setReqDate(formattedDate);
                            }
                          },
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(__.reqDate)),
                        ),

                        //    Text(value.unitDrop + " Units"),
                      ],
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                    child: Text(
                      "Search Hospital",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                Navigation.instance
                                    .navigateTo(LocationSeachScreen.id.path);
                              },
                              child: EmptyTextField(
                                text: SizedBox(
                                  width: size.width / 1.4,
                                  child: Text(
                                    __.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ))),
                      Container(
                        margin: const EdgeInsets.only(right: 16),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey)),
                        child: const Icon(Icons.gps_fixed),
                      )
                    ],
                  ),
                  sbh(4),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                    child: Text(
                      "Want to say some thing !?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextFormField(
                      maxLines: 3,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: " Add a note  to donar ",
                        hintStyle: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          "Emergency Request",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Checkbox(
                          splashRadius: 24,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          value: __.isEmergency,
                          onChanged: ((value) {
                            __.setIsEmergency(value!);
                          })),
                    ],
                  ),
                  LoginButton(
                    onPressed: () {
                      log(widget.userProfile.userId.toString());
                      UserProfile actualUserProfile =
                          Provider.of<ProfileProvider>(context, listen: false)
                              .userProfile!;
                      BloodRequestModel bloodRequestModel = BloodRequestModel(
                          name: actualUserProfile.name,
                          image: actualUserProfile.profileImage,
                          phone: actualUserProfile.phone,
                          userFrom: actualUserProfile.userId,
                          userTo: widget.userProfile.userId,
                          reqStat: '',
                          patientName: nameController.text,
                          location: __.description,
                          deadLine: __.reqDate,
                          note: noteController.text.isEmpty
                              ? "Please do help me"
                              : noteController.text,
                          distance: widget.donarProvider.calcDistFromUser(
                              context,
                              isUser: false,
                              hospLoc: widget.donarProvider.hospLoc),
                          isEmergency: __.isEmergency,
                          bloodGroup: widget.userProfile.bloodGroup);

                      widget.donarProvider
                          .createBloodRequest(bloodRequestModel);
                    },
                    text: "Request",
                    icons: Image.asset(
                      "assets/home/blood_help.png",
                      scale: 20,
                    ),
                  )
                ],
              );
            }))
          ],
        ),
      ),
    );
  }
}
