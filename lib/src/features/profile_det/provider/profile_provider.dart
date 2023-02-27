import 'dart:developer';
import 'dart:io';

import 'package:donation_blood/src/features/shared/domain/models/blood_donation_model.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/bottom_nav_screen.dart';
import 'package:donation_blood/src/services/image_storage.dart';
import 'package:donation_blood/src/utils/navigation.dart';
import 'package:donation_blood/src/utils/user_pref/user_preferences.dart';
import 'package:donation_blood/src/utils/utils.dart';
import 'package:donation_blood/src/utils/widget_utils/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';

import '../../../utils/streams.dart';
import '../../shared/domain/models/user_profile_model.dart';

class ProfileProvider with ChangeNotifier {
  final Streams _streams = Streams();
  final Preferences _preferences = Preferences();

  String? _imageUrl;
  String? get imageUrl => _imageUrl;

//############### user profile #####################3
  UserProfile? _userProfile;
  UserProfile? get userProfile => _userProfile;

  setUserProfile() {}

//############# emergency checkbox ###################3
  bool _isEmergency = false;
  bool get isEmergency => _isEmergency;

  setIsEmergency(bool a) {
    _isEmergency = a;
    notifyListeners();
  }

//################3 is available###############3
  String _selectYN = 'No';
  String get selectYN => _selectYN;
  bool _isAvailabe = true;
  bool get isAvailable => _isAvailabe;

  setYesNo(String s) {
    if (s == "Yes") {
      _isAvailabe = false;
      _selectYN = s;
    } else {
      _isAvailabe = true;
      _selectYN = s;
    }
    log(_isAvailabe.toString());
    notifyListeners();
  }

//##############  gender ############################
  String _dropDownValue = 'Select Gender';
  String get dropDownValue => _dropDownValue;
  final List<String> _items = ["male", "female", "other"];
  List<String> get items => _items;

  setDropDownValue(String s) {
    _dropDownValue = s;
    notifyListeners();
  }

  final List<String> _yesNo = ['Yes', 'No  '];
  List<String> get yesNo => _yesNo;

  // #################### blood group ###################
  String _selectedBloodGroup = '';
  String get selectedBloodGroup => _selectedBloodGroup;
  final List<String> _allBloodGrp = [
    'O+',
    'A+',
    'B+',
    'AB+',
    'O-',
    'A-',
    'AB-',
    'B-',
    'Bombay Blood',
    'No Idea'
  ];

  List<String> get allBloodGrp => _allBloodGrp;

  setSelectedBloodGroup(String s) {
    _selectedBloodGroup = s;
    notifyListeners();
  }

  //############### med issues #####################
  String _selectedMedIssue = 'None';
  String get selectedMedIssue => _selectedMedIssue;
  final List<String> _medIssues = [
    'None',
    'Thalassemia',
    'Diabetes',
    'Heart Disease',
    'Lung Disease',
    'Cancer',
    'Aids',
    'Hepatitis B and C',
    'Other'
  ];

  List<String> get medIssues => _medIssues;

  setSelectedMedIssue(String s) {
    _selectedMedIssue = s;
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }

  final List<String> _units = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];

  //########  units blood #######################

  List<String> get units => _units;

  String _unitDrop = '1';
  String get unitDrop => _unitDrop;

  setUnitDrop(String drop) {
    _unitDrop = drop;
    notifyListeners();
  }

  //############ date of blood ##############
  String _reqDate = Jiffy(DateTime.now()).format('MMM do ');
  String get reqDate => _reqDate;

  setReqDate(String s) {
    _reqDate = s;
    notifyListeners();
  }

  //########### location description ################
  String _description = 'Search Your Location';
  String get description => _description;

  setDescription(String s) {
    _description = s;
    notifyListeners();
  }

//################# add user to firebase #############################
  addUserToFirebase(UserProfile userModel, String userId) async {
    try {
      Loading().witIndicator(
          context: Navigation.instance.navigationKey.currentState!.context,
          title: "Saving Info :)");
      await _streams.userQuery.doc(userId).set(userModel.toMap());
      Navigation.instance.navigateTo(BottomNavScreen.id.path);
    } catch (e) {
      log(e.toString());
    }
  }

//################# profile images to firebase#################
  addProfileImageToFirebase(String name) async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    File imageFile = File(image!.path);

    final String url = await uploadProfileImage(name, imageFile);
    _imageUrl = url;
    notifyListeners();
  }

//############## add blood request to firebase #########################

  addBloodRequestToFirebase(BloodDonationModel bloodDonation) async {
    try {
      String id = _preferences.getUserId();
      // Loading().witIndicator(
      //     context: Navigation.instance.navigationKey.currentState!.context,
      //     title: "Creating Request :)");
      await _streams.requestQuery
          .doc(bloodDonation.donationId)
          .set(bloodDonation.toMap());

      await _streams.userQuery
          .doc(id)
          .collection(Streams.requestByUser)
          .doc(bloodDonation.donationId)
          .set(bloodDonation.toMap());
      

     // Navigation.instance.pushBack();
      Navigation.instance.pushBack();
      Navigation.instance.pushBack();
      appToast("Succesfully Request Added Hold Tight :)");
    } catch (e) {
      log(e.toString());
    }
  }


// if emergency we will send notification to requested blood type users as well as waatti message

  //############ store userInfo ####################

  getUserInfo() async {
    String id = _preferences.getUserId();
    var a = await _streams.userQuery.doc(id).get();
    _userProfile = UserProfile.fromMap(a.data()!);
   // notifyListeners();
  }

  String bloogGroupComplement(String s) {
    switch (s) {
      case 'O+':
        return " You can save Lots of People :)";
      case 'A+':
        return " You can save Lots of People :)";
      case 'B+':
        return " You can save Lots of People :)";
      case 'AB+':
        return " You can save Lots of People :)";
      case 'B-':
        return "You have Rare blood 😮";
      case 'O-':
        return "You have Rare blood 😮";
      case 'A-':
        return "You have Rare blood 😮";
      case 'AB-':
        return "You have Rare blood 😮";
      case 'Bombay Blood':
        return "You have  very Rare blood 😮";
      default:
        return "";
    }
  }
}
