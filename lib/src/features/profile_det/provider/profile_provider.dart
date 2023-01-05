import 'dart:developer';
import 'dart:io';

import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/bottom_nav_screen.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/home/screens/home_screen.dart';
import 'package:donation_blood/src/services/image_storage.dart';
import 'package:donation_blood/src/utils/navigation.dart';
import 'package:donation_blood/src/utils/widget_utils/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/streams.dart';
import '../../shared/domain/models/user_profile_model.dart';

class ProfileProvider with ChangeNotifier {
  final Streams _streams = Streams();

  String? _imageUrl;
  String? get imageUrl => _imageUrl;

  String _dropDownValue = 'Select Gender';
  String get dropDownValue => _dropDownValue;

  String _selectedBloodGroup = '';
  String get selectedBloodGroup => _selectedBloodGroup;

  String _selectedMedIssue = 'None';
  String get selectedMedIssue => _selectedMedIssue;

  String _selectYN = 'No';
  String get selectYN => _selectYN;

  bool _isAvailabe = true;
  bool get isAvailable => _isAvailabe;

  final List<String> _items = ["male", "female", "other"];
  List<String> get items => _items;

  String _country = '';
  String get country => _country;

  String _state = '';
  String get state => _state;

  String _city = '';
  String get city => _city;

  final List<String> _yesNo = ['Yes', 'No  '];
  List<String> get yesNo => _yesNo;

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

  // final List<String> _popBloodGrp = ['O+', 'A+', 'B+', 'AB+'];
  // List<String> get popBloodGrp => _popBloodGrp;

  // final List<String> _rareBloodGrp = ['O-', 'A-', 'AB-', 'B-'];
  // List<String> get rareBloodGrp => _rareBloodGrp;

  String _description = 'Search Your Location';
  String get description => _description;

  setDescription(String s) {
    _description = s;
    notifyListeners();
  }

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

  setCountry(String s) {
    _country = s;
  }

  setState(String s) {
    _state = s;
  }

  setCity(String s) {
    _city = s;
  }

  setSelectedMedIssue(String s) {
    _selectedMedIssue = s;
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }

  setSelectedBloodGroup(String s) {
    _selectedBloodGroup = s;
    notifyListeners();
  }

  setDropDownValue(String s) {
    _dropDownValue = s;
    notifyListeners();
  }

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

  addProfileImageToFirebase(String name) async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    File imageFile = File(image!.path);
    
    final String url = await uploadProfileImage(name, imageFile);
    _imageUrl = url;
    notifyListeners();
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
