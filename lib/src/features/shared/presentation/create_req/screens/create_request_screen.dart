import 'dart:developer';

import 'package:donation_blood/src/features/authentication/presentation/login_screen/login_button.dart';
import 'package:donation_blood/src/features/profile_det/provider/profile_provider.dart';
import 'package:donation_blood/src/features/profile_det/provider/search_provider.dart';
import 'package:donation_blood/src/features/profile_det/screens/location_search_screen.dart';
import 'package:donation_blood/src/features/shared/domain/models/blood_donation_model.dart';
import 'package:donation_blood/src/features/shared/domain/models/user_profile_model.dart';
import 'package:donation_blood/src/utils/navigation.dart';
import 'package:donation_blood/src/utils/routes.dart';
import 'package:donation_blood/src/utils/utils.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

import '../../../../profile_det/screens/profile_detail_screen.dart';
import '../../widgets/text_fields.dart';

class CreateReqScreen extends StatefulWidget {
  static const id = AppRoutes.createReqScreen;
  const CreateReqScreen({super.key});

  @override
  State<CreateReqScreen> createState() => _CreateReqScreenState();
}

class _CreateReqScreenState extends State<CreateReqScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _hospitalController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigation.instance.pushBack();
                        },
                        icon: const Icon(Icons.arrow_back_ios)),
                    const Text(
                      "Request Donation",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Icon(Icons.notifications)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReqTextFiled(
                      controller: _nameController,
                      sideHeading: "Patient Name",
                      icon: const Icon(Icons.person),
                    ),
                    sbh(12),
                    ReqTextFiled(
                      controller: _mobileController,
                      sideHeading: "Mobile",
                      icon: const Icon(Icons.phone),
                    ),
                    sbh(12),
                    const Text("Blood Type"),
                    Consumer<ProfileProvider>(builder: ((_, __, ___) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 9,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 5,
                              childAspectRatio: (1 / .2),
                            ),
                            itemBuilder: ((context, index) {
                              return InkWell(
                                onTap: () {
                                  __.setSelectedBloodGroup(
                                      __.allBloodGrp[index]);
                                },
                                child: SelectionBoxView(
                                  index: index,
                                  options: __.allBloodGrp,
                                  selected: __.selectedBloodGroup,
                                ),
                              );
                            })),
                      );
                    })),
                    sbh(12),
                    Consumer<ProfileProvider>(
                        builder: ((context, value, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Units"),
                              Card(
                                child: SizedBox(
                                  height: 40,
                                  // width: 100,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Card(
                                          elevation: 6,
                                          child: Image.asset(
                                            "assets/home/blood.png",
                                            scale: 20,
                                          )),
                                      sbw(4),
                                      //    Text(value.unitDrop + " Units"),
                                      DropdownButton2<String>(
                                          underline: const SizedBox(),
                                          buttonWidth: 100,
                                          // icon: Icon(Icons.arrow_drop_down_circle_sharp),
                                          // isExpanded: true,
                                          value: value.unitDrop,
                                          items: value.units
                                              .map<DropdownMenuItem<String>>(
                                                  (String e) =>
                                                      DropdownMenuItem(
                                                        // enabled: false,
                                                        value: e,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 32.0),
                                                          child: Text(e),
                                                        ),
                                                      ))
                                              .toList(),
                                          onChanged: (v) {
                                            value.setUnitDrop(v!);
                                          })
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Required by"),
                              Card(
                                child: SizedBox(
                                  height: 40,
                                  // width: 100,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            value.setReqDate(formattedDate);
                                          }
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Text(value.reqDate)),
                                      ),

                                      //    Text(value.unitDrop + " Units"),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    })),
                    sbh(12),
                    Consumer<ProfileProvider>(builder: ((_, __, ___) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigation.instance
                                  .navigateTo(LocationSeachScreen.id.path);
                              //__.setDescription(s)
                            },
                            child: ReqTextFiled(
                                isDisabled: false,
                                hintText: __.description == ''
                                    ? "Hospital Location"
                                    : __.description,
                                sideHeading: "Hospital",
                                controller: _hospitalController,
                                icon: const Icon(Icons.gps_fixed)),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  splashRadius: 24,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  value: __.isEmergency,
                                  onChanged: ((value) {
                                    __.setIsEmergency(value!);
                                  })),
                              const Text(
                                "Emergency Request",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Visibility(
                              visible: __.isEmergency,
                              child: const Padding(
                                padding: EdgeInsets.only(left: 16.0),
                                child:
                                    Text("Dont Worry We Will Help You Out :)"),
                              )),
                          sbh(24),
                          LoginButton(
                              onPressed: (() {
                                log(__.selectedBloodGroup);
                                log(__.description);
                                log(_nameController.text);
                                log(_mobileController.text);
                                if (_nameController.text.isNotEmpty &&
                                    _mobileController.text.isNotEmpty &&
                                    __.selectedBloodGroup != '' &&
                                    __.description != 'Search Your Location') {
                                  var hospLoc = Provider.of<SearchProvider>(
                                          context,
                                          listen: false)
                                      .userLocation;
                                  UserProfile userProfile =
                                      Provider.of<ProfileProvider>(context,
                                              listen: false)
                                          .userProfile!;
                                  String a = DateTime.now()
                                      .microsecondsSinceEpoch
                                      .toString();
                                  BloodDonationModel bloodDonationModel =
                                      BloodDonationModel(
                                        donationId: a,
                                          name: userProfile.name,
                                          image: userProfile.profileImage,
                                          userId: userProfile.userId,
                                          patientName: _nameController.text,
                                          number: _mobileController.text,
                                          bloodGroup: __.selectedBloodGroup,
                                          donationStat: "in process",
                                          units: __.unitDrop,
                                          intrestedDonars: [],
                                          deadLine: __.reqDate,
                                          donatedUnits: '0',
                                          location: __.description,
                                          lat: hospLoc!.lat,
                                          isEmergency: __.isEmergency,
                                          long: hospLoc.lng);
                                  __.addBloodRequestToFirebase(
                                      bloodDonationModel);
                                } else {
                                  appToast("Please Do Fill All The Details :(");
                                }
                              }),
                              text: "Request Donation")
                        ],
                      );
                    })),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
