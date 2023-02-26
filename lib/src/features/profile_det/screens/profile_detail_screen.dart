import 'package:donation_blood/src/utils/widget_utils/cache_image.dart';
import 'package:google_maps_webservice/src/core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/navigation.dart';
import '../../../utils/routes.dart';
import '../../../utils/utils.dart';
import '../../authentication/data/providers/login_provider.dart';
import '../../authentication/presentation/login_screen/login_button.dart';
import '../../shared/domain/models/user_profile_model.dart';
import '../../shared/presentation/widgets/text_fields.dart';
import '../provider/profile_provider.dart';
import '../provider/search_provider.dart';
import 'location_search_screen.dart';

class EditProfileScreen extends StatefulWidget {
  static const id = AppRoutes.editProfileScreen;
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  //final TextEditingController _gender = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Consumer<ProfileProvider>(
      builder: (_, __, ___) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Get Ready To Save Lifes :)",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      String phone =
                          Provider.of<LoginProvider>(context, listen: false)
                              .phone;
                      __.addProfileImageToFirebase(phone);
                    },
                    child: Center(
                      // backgroundColor: Colors.white,
                      child: __.imageUrl != null
                          ? CacheImage(
                              height: 100,
                              width: 100,
                              image: __.imageUrl!,
                              fit: BoxFit.cover,
                            )
                          : const CircleAvatar(
                              radius: 44,
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.grey,
                              ),
                            ),
                    ),
                  ),

                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
                    child: Text(
                      "Personal details",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  DetailedTextFiled(
                    controller: _nameController,
                    text: "Name",
                  ),
                  sbh(12),
                  DetailedTextFiled(
                    controller: _ageController,
                    text: "Age",
                    textInputType: TextInputType.number,
                  ),
                  sbh(12),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: Text(
                      "Select Location",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Consumer(builder: ((context, value, child) {
                    return Row(
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
                    );
                  })),
                  // EmptyTextField(
                  //     text: __.dropDownValue,
                  //     widget: InkWell(
                  //       child: DropdownButton(
                  //           // isExpanded: true,
                  //           items: __.items.map((String items) {
                  //             return DropdownMenuItem(
                  //               value: items,
                  //               child: Text(items),
                  //             );
                  //           }).toList(),
                  //           onChanged: ((String? value) {
                  //             __.setDropDownValue(value!);
                  //           })),
                  //     )),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: Text(
                      "Select Gender",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: List.generate(
                          __.items.length,
                          (index) => InkWell(
                                onTap: () {
                                  __.setDropDownValue(__.items[index]);
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: SelectionBoxView(
                                      padding: 4,
                                      index: index,
                                      options: __.items,
                                      selected: __.dropDownValue),
                                ),
                              )),
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: Text(
                      "Have You Donated Blood from past 3 months",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: List.generate(
                          __.yesNo.length,
                          (index) => InkWell(
                                onTap: () {
                                  __.setYesNo(__.yesNo[index]);
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: SelectionBoxView(
                                      padding: 4,
                                      index: index,
                                      options: __.yesNo,
                                      selected: __.selectYN),
                                ),
                              )),
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: Text(
                      "Select Blood Group",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: __.allBloodGrp.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 5,
                            childAspectRatio: (1 / .2),
                          ),
                          itemBuilder: ((context, index) {
                            return InkWell(
                              onTap: () {
                                __.setSelectedBloodGroup(__.allBloodGrp[index]);
                              },
                              child: SelectionBoxView(
                                index: index,
                                options: __.allBloodGrp,
                                selected: __.selectedBloodGroup,
                              ),
                            );
                          }))),
                  Visibility(
                      visible: __.selectedBloodGroup != '',
                      child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            " ${__.bloogGroupComplement(__.selectedBloodGroup)}",
                            style: TextStyle(
                                color: Colors.red.shade200,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ))),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: Text(
                      "Select Med Issues (if any) ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: __.medIssues.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 5,
                            childAspectRatio: (1 / .2),
                          ),
                          itemBuilder: ((context, index) {
                            return InkWell(
                              onTap: () {
                                __.setSelectedMedIssue(__.medIssues[index]);
                              },
                              child: SelectionBoxView(
                                index: index,
                                options: __.medIssues,
                                selected: __.selectedMedIssue,
                              ),
                            );
                          }))),
                  Visibility(
                      visible: __.selectedMedIssue != '',
                      child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            __.selectedMedIssue == 'None'
                                ? "You can Gift Lifes :)"
                                : "Dont worry You can still help by sharing :)",
                            style: TextStyle(
                                color: Colors.red.shade200,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ))),

                  // Container(
                  //   margin: const EdgeInsets.symmetric(horizontal: 16),
                  //   child: SelectState(
                  //     decoration: const InputDecoration(
                  //         contentPadding: EdgeInsets.all(16)),
                  //     spacing: 16,
                  //     onCountryChanged: (value) {
                  //       __.setCountry(value);
                  //     },
                  //     onStateChanged: (value) {
                  //       __.setState(value);
                  //     },
                  //     onCityChanged: (value) {
                  //       __.setCity(value);
                  //     },
                  //   ),
                  // ),
                  LoginButton(
                      onPressed: () {
                        String userId =
                            Provider.of<LoginProvider>(context, listen: false)
                                .userId;
                        String phone =
                            Provider.of<LoginProvider>(context, listen: false)
                                .phone;
                        Location loc =
                            Provider.of<SearchProvider>(context, listen: false)
                                .userLocation!;
                        UserProfile userProfile = UserProfile(
                            userId: userId,
                            name: _nameController.text,
                            age: _ageController.text,
                            gender: __.dropDownValue,
                            isAvailable: __.isAvailable,
                            bloodGroup: __.selectedBloodGroup,
                            medIssues: __.selectedMedIssue,
                            location: __.description,
                            profileImage: __.imageUrl,
                            lat: loc.lat,
                            long: loc.lng,
                            donatedTime: "",
                            phone: phone);
                        __.addUserToFirebase(userProfile, userId);
                      },
                      text: "Submit"),
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}

class SelectionBoxView extends StatelessWidget {
  final int index;
  final List<String> options;
  final String selected;
  final double padding;
  const SelectionBoxView({
    Key? key,
    this.padding = 0,
    required this.index,
    required this.options,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
          color: selected != options[index] ? Colors.white : Colors.redAccent,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4)),
      child: Center(child: Text(options[index])),
    );
  }
}


// Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,

//                   children: [
//                     Container(
//                       margin: const EdgeInsets.all(8),
//                       padding: const EdgeInsets.all(4),
//                       decoration:
//                           BoxDecoration(border: Border.all(color: blackColor),
//                           borderRadius: BorderRadius.circular(4)
//                           ),
//                       child: Row(
//                         children: [
//                           const Text("data"),
//                           sbw(4),
//                           const Icon(Icons.date_range)
//                         ],
//                       ),
//                     ),
//                     Container(
//                       margin: const EdgeInsets.all(8),
//                       padding: const EdgeInsets.all(4),
//                       decoration: BoxDecoration(
//                           border: Border.all(color: blackColor),
//                           borderRadius: BorderRadius.circular(4)),
//                       child: Row(
//                         children: [
//                           const Text("data"),
//                           sbw(4),
//                           const Icon(Icons.date_range)
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),

// GridView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: 8,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 3,
//                               mainAxisSpacing: 5,
//                               childAspectRatio: 4),
//                       itemBuilder: ((context, index) {
//                         return Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 4),
//                           decoration: BoxDecoration(
//                               border: Border.all(color: Colors.grey),
//                               borderRadius: BorderRadius.circular(12)),
//                           child: Center(child: Text(__.allBloodGrp[index])),
//                         );
//                       }))

// child: Row(
//                   children: List.generate(
//                       __.allBloodGrp.length,
//                       (index) => Container(
//                             margin: const EdgeInsets.all(4),
//                             padding: const EdgeInsets.all(4),
//                             decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.grey),
//                                 borderRadius: BorderRadius.circular(12)),
//                             child: Text(__.allBloodGrp[index]),
//                           )),
//                 ),
