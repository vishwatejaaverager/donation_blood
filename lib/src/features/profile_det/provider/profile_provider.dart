import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
import '../../notification/notification_services.dart';
import '../../shared/domain/models/interested_donar_model.dart';
import '../../shared/domain/models/user_profile_model.dart';

class ProfileProvider with ChangeNotifier {
  final Streams _streams = Streams();
  final Preferences _preferences = Preferences();

  String _imageUrl =
      "https://firebasestorage.googleapis.com/v0/b/donationblood-4e0d9.appspot.com/o/profile.jpg?alt=media&token=e4a37d85-8899-46ae-93a1-668bc7a26d78";
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
    log(_selectedBloodGroup.toString());
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
      await _streams.userQuery.doc(userId).set(userModel.toMap()).then((value) {
        Preferences.setUserID(userModel.userId!);
      });
      Navigation.instance.pushAndRemoveUntil(BottomNavScreen.id.path);
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
      Loading().witIndicator(
          context: Navigation.instance.navigationKey.currentState!.context,
          title: "Creating Request :)");
      await _streams.requestQuery
          .doc(bloodDonation.donationId)
          .set(bloodDonation.toMap());

      await _streams.userQuery
          .doc(id)
          .collection(Streams.requestByUser)
          .doc(bloodDonation.donationId)
          .set(bloodDonation.toMap());
    } catch (e) {
      log(e.toString());
    }
  }

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> _allDonars = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get allDonars => _allDonars;

  sendReqToOtherDonars(
    String userID,
    String donationId,
    InterestedDonarsModel bloodDonationModel, {
    bool isEmergency = false,
  }) async {
    // log(userID + " this is the user id ");
    // log(_allDonars.length.toString() + "all donars");
    // log(bloodDonationModel.bloodGroup.toString() + "required blood group");
    sendRequestAndNotification(
        donationId, bloodDonationModel, isEmergency, userID);
    Navigation.instance.pushBack();
    Navigation.instance.pushBack();
    Navigation.instance.pushBack();
    appToast("Succesfully Request Added Hold Tight :)");
    // });
  }

  sendRequestAndNotification(
      String donationId,
      InterestedDonarsModel donarsModel,
      bool isEmergency,
      String userId) async {
    checkComptabilityAndSendReq(
        donarsModel.bloodGroup!, donationId, donarsModel, userId);

    //Navigation.instance.pushBack();
    //  Navigation.instance.pushBack();
  }

  checkComptabilityAndSendReq(String bloodGrp, String donationId,
      InterestedDonarsModel donarsModel, String userId) {
    log("came to chaeck compatability");
    if (bloodGrp == 'A+') {
      _streams.userQuery
          .where('isAvailable', isEqualTo: true)
          .get()
          .then((value) {
        for (var i = 0; i < value.docs.length; i++) {
          if (value.docs[i].id != userId) {
            if (value.docs[i].data()['bloodGroup'] == 'A+' ||
                value.docs[i].data()['bloodGroup'] == 'A-' ||
                value.docs[i].data()['bloodGroup'] == 'O+' ||
                value.docs[i].data()['bloodGroup'] == 'O-') {
              final userToToken = value.docs[i].data()['token'];
              InterestedDonarsModel donar = InterestedDonarsModel(
                  patientName: donarsModel.patientName,
                  name: donarsModel.name,
                  donarName: donarsModel.name,
                  donarsNumber: donarsModel.donarsNumber,
                  userFrom: donarsModel.userFrom,
                  bloodGroup: donarsModel.bloodGroup,
                  donarImage: donarsModel.donarImage,
                  donationId: donarsModel.donationId,
                  userFromToken: donarsModel.userFromToken,
                  userToToken: userToToken,
                  userTo: '',
                  isAutomated: true,
                  isEmergency: donarsModel.isEmergency,
                  deadLine: donarsModel.deadLine,
                  phoneNumber: donarsModel.phoneNumber,
                  lat: donarsModel.lat,
                  lng: donarsModel.lng,
                  location: donarsModel.location,
                  donarStat: "nothing");
              _streams.userQuery
                  .doc(value.docs[i].id)
                  .collection(Streams.seekersRequest)
                  .doc(donationId)
                  .set(donar.toMap());
              NotificationService().sendPushNotification(userToToken,
                  title: "Blood Donation Request",
                  desc:
                      "We are in need of blood donors to help save the life of a patient undergoing medical treatment.You are elgible for this please do consider to donate");
            }
          }
        }
      });
    } else if (bloodGrp == 'O+') {
      _streams.userQuery
          .where('isAvailable', isEqualTo: true)
          .get()
          .then((value) {
        log("came O+ group");
        log("${value.docs.length}this is the user length");
        for (var i = 0; i < value.docs.length; i++) {
          if (value.docs[i].id != userId) {
            if (value.docs[i].data()['bloodGroup'] == 'O+' ||
                value.docs[i].data()['bloodGroup'] == 'O-') {
              log("elgible");

              final userToToken = value.docs[i].data()['token'];
              InterestedDonarsModel donar = InterestedDonarsModel(
                  patientName: donarsModel.patientName,
                  name: donarsModel.name,
                  donarName: donarsModel.name,
                  donarsNumber: donarsModel.donarsNumber,
                  userFrom: donarsModel.userFrom,
                  bloodGroup: donarsModel.bloodGroup,
                  donarImage: donarsModel.donarImage,
                  donationId: donarsModel.donationId,
                  userFromToken: donarsModel.userFromToken,
                  userToToken: userToToken,
                  userTo: '',
                  isAutomated: true,
                  isEmergency: donarsModel.isEmergency,
                  deadLine: donarsModel.deadLine,
                  phoneNumber: donarsModel.phoneNumber,
                  lat: donarsModel.lat,
                  lng: donarsModel.lng,
                  location: donarsModel.location,
                  donarStat: "nothing");
              _streams.userQuery
                  .doc(value.docs[i].id)
                  .collection(Streams.seekersRequest)
                  .doc(donationId)
                  .set(donar.toMap());
              NotificationService().sendPushNotification(userToToken,
                  title: "Blood Donation Request",
                  desc:
                      "We are in need of blood donors to help save the life of a patient undergoing medical treatment.You are elgible for this please do consider to donate");
            }
          }
        }
      });
    } else if (bloodGrp == 'B+') {
      _streams.userQuery
          .where('isAvailable', isEqualTo: true)
          .get()
          .then((value) {
        for (var i = 0; i < value.docs.length; i++) {
          if (value.docs[i].id != userId) {
            if (value.docs[i].data()['bloodGroup'] == 'B+' ||
                value.docs[i].data()['bloodGroup'] == 'B-' ||
                value.docs[i].data()['bloodGroup'] == 'O+' ||
                value.docs[i].data()['bloodGroup'] == 'O-') {
              final userToToken = value.docs[i].data()['token'];
              InterestedDonarsModel donar = InterestedDonarsModel(
                  patientName: donarsModel.patientName,
                  name: donarsModel.name,
                  donarName: donarsModel.name,
                  donarsNumber: donarsModel.donarsNumber,
                  userFrom: donarsModel.userFrom,
                  bloodGroup: donarsModel.bloodGroup,
                  donarImage: donarsModel.donarImage,
                  donationId: donarsModel.donationId,
                  userFromToken: donarsModel.userFromToken,
                  userToToken: userToToken,
                  userTo: '',
                  isAutomated: true,
                  isEmergency: donarsModel.isEmergency,
                  deadLine: donarsModel.deadLine,
                  phoneNumber: donarsModel.phoneNumber,
                  lat: donarsModel.lat,
                  lng: donarsModel.lng,
                  location: donarsModel.location,
                  donarStat: "nothing");
              _streams.userQuery
                  .doc(value.docs[i].id)
                  .collection(Streams.seekersRequest)
                  .doc(donationId)
                  .set(donar.toMap());
              NotificationService().sendPushNotification(userToToken,
                  title: "Blood Donation Request",
                  desc:
                      "We are in need of blood donors to help save the life of a patient undergoing medical treatment.You are elgible for this please do consider to donate");
            }
          }
        }
      });
    } else if (bloodGrp == 'AB+') {
      _streams.userQuery
          .where('isAvailable', isEqualTo: true)
          .get()
          .then((value) {
        for (var i = 0; i < value.docs.length; i++) {
          if (value.docs[i].id != userId) {
            final userToToken = value.docs[i].data()['token'];
            InterestedDonarsModel donar = InterestedDonarsModel(
                patientName: donarsModel.patientName,
                name: donarsModel.name,
                donarName: donarsModel.name,
                donarsNumber: donarsModel.donarsNumber,
                userFrom: donarsModel.userFrom,
                bloodGroup: donarsModel.bloodGroup,
                donarImage: donarsModel.donarImage,
                donationId: donarsModel.donationId,
                userFromToken: donarsModel.userFromToken,
                userToToken: userToToken,
                userTo: '',
                isAutomated: true,
                isEmergency: donarsModel.isEmergency,
                deadLine: donarsModel.deadLine,
                phoneNumber: donarsModel.phoneNumber,
                lat: donarsModel.lat,
                lng: donarsModel.lng,
                location: donarsModel.location,
                donarStat: "nothing");
            _streams.userQuery
                .doc(value.docs[i].id)
                .collection(Streams.seekersRequest)
                .doc(donationId)
                .set(donar.toMap());
            NotificationService().sendPushNotification(userToToken,
                title: "Blood Donation Request",
                desc:
                    "We are in need of blood donors to help save the life of a patient undergoing medical treatment.You are elgible for this please do consider to donate");
          }
        }
      });
    } else if (bloodGrp == 'AB-') {
      _streams.userQuery
          .where('isAvailable', isEqualTo: true)
          .get()
          .then((value) {
        for (var i = 0; i < value.docs.length; i++) {
          if (value.docs[i].id != userId) {
            if (value.docs[i].data()['bloodGroup'] == 'AB-' ||
                value.docs[i].data()['bloodGroup'] == 'A-' ||
                value.docs[i].data()['bloodGroup'] == 'B-' ||
                value.docs[i].data()['bloodGroup'] == 'O-') {
              final userToToken = value.docs[i].data()['token'];
              InterestedDonarsModel donar = InterestedDonarsModel(
                  patientName: donarsModel.patientName,
                  name: donarsModel.name,
                  donarName: donarsModel.name,
                  donarsNumber: donarsModel.donarsNumber,
                  userFrom: donarsModel.userFrom,
                  bloodGroup: donarsModel.bloodGroup,
                  donarImage: donarsModel.donarImage,
                  donationId: donarsModel.donationId,
                  userFromToken: donarsModel.userFromToken,
                  userToToken: userToToken,
                  userTo: '',
                  isAutomated: true,
                  isEmergency: donarsModel.isEmergency,
                  deadLine: donarsModel.deadLine,
                  phoneNumber: donarsModel.phoneNumber,
                  lat: donarsModel.lat,
                  lng: donarsModel.lng,
                  location: donarsModel.location,
                  donarStat: "nothing");
              _streams.userQuery
                  .doc(value.docs[i].id)
                  .collection(Streams.seekersRequest)
                  .doc(donationId)
                  .set(donar.toMap());
              NotificationService().sendPushNotification(userToToken,
                  title: "Blood Donation Request",
                  desc:
                      "We are in need of blood donors to help save the life of a patient undergoing medical treatment.You are elgible for this please do consider to donate");
            }
          }
        }
      });
    } else if (bloodGrp == 'A-') {
      _streams.userQuery
          .where('isAvailable', isEqualTo: true)
          .get()
          .then((value) {
        for (var i = 0; i < value.docs.length; i++) {
          if (value.docs[i].id != userId) {
            if (value.docs[i].data()['bloodGroup'] == 'A-' ||
                value.docs[i].data()['bloodGroup'] == 'O-') {
              final userToToken = value.docs[i].data()['token'];
              InterestedDonarsModel donar = InterestedDonarsModel(
                  patientName: donarsModel.patientName,
                  name: donarsModel.name,
                  donarName: donarsModel.name,
                  donarsNumber: donarsModel.donarsNumber,
                  userFrom: donarsModel.userFrom,
                  bloodGroup: donarsModel.bloodGroup,
                  donarImage: donarsModel.donarImage,
                  donationId: donarsModel.donationId,
                  userFromToken: donarsModel.userFromToken,
                  userToToken: userToToken,
                  userTo: '',
                  isAutomated: true,
                  isEmergency: donarsModel.isEmergency,
                  deadLine: donarsModel.deadLine,
                  phoneNumber: donarsModel.phoneNumber,
                  lat: donarsModel.lat,
                  lng: donarsModel.lng,
                  location: donarsModel.location,
                  donarStat: "nothing");
              _streams.userQuery
                  .doc(value.docs[i].id)
                  .collection(Streams.seekersRequest)
                  .doc(donationId)
                  .set(donar.toMap());
              NotificationService().sendPushNotification(userToToken,
                  title: "Blood Donation Request",
                  desc:
                      "We are in need of blood donors to help save the life of a patient undergoing medical treatment.You are elgible for this please do consider to donate");
            }
          }
        }
      });
    } else if (bloodGrp == 'B-') {
      _streams.userQuery
          .where('isAvailable', isEqualTo: true)
          .get()
          .then((value) {
        for (var i = 0; i < value.docs.length; i++) {
          if (value.docs[i].id != userId) {
            if (value.docs[i].data()['bloodGroup'] == 'B-' ||
                value.docs[i].data()['bloodGroup'] == 'O-') {
              final userToToken = value.docs[i].data()['token'];
              InterestedDonarsModel donar = InterestedDonarsModel(
                  patientName: donarsModel.patientName,
                  name: donarsModel.name,
                  donarName: donarsModel.name,
                  donarsNumber: donarsModel.donarsNumber,
                  userFrom: donarsModel.userFrom,
                  bloodGroup: donarsModel.bloodGroup,
                  donarImage: donarsModel.donarImage,
                  donationId: donarsModel.donationId,
                  userFromToken: donarsModel.userFromToken,
                  userToToken: userToToken,
                  userTo: '',
                  isAutomated: true,
                  isEmergency: donarsModel.isEmergency,
                  deadLine: donarsModel.deadLine,
                  phoneNumber: donarsModel.phoneNumber,
                  lat: donarsModel.lat,
                  lng: donarsModel.lng,
                  location: donarsModel.location,
                  donarStat: "nothing");
              _streams.userQuery
                  .doc(value.docs[i].id)
                  .collection(Streams.seekersRequest)
                  .doc(donationId)
                  .set(donar.toMap());
              NotificationService().sendPushNotification(userToToken,
                  title: "Blood Donation Request",
                  desc:
                      "We are in need of blood donors to help save the life of a patient undergoing medical treatment.You are elgible for this please do consider to donate");
            }
          }
        }
      });
    } else if (bloodGrp == 'O-') {
      _streams.userQuery
          .where('isAvailable', isEqualTo: true)
          .get()
          .then((value) {
        for (var i = 0; i < value.docs.length; i++) {
          if (value.docs[i].id != userId) {
            if (value.docs[i].data()['bloodGroup'] == 'O-') {
              final userToToken = value.docs[i].data()['token'];
              InterestedDonarsModel donar = InterestedDonarsModel(
                  patientName: donarsModel.patientName,
                  name: donarsModel.name,
                  donarName: donarsModel.name,
                  donarsNumber: donarsModel.donarsNumber,
                  userFrom: donarsModel.userFrom,
                  bloodGroup: donarsModel.bloodGroup,
                  donarImage: donarsModel.donarImage,
                  donationId: donarsModel.donationId,
                  userFromToken: donarsModel.userFromToken,
                  userToToken: userToToken,
                  userTo: '',
                  isAutomated: true,
                  isEmergency: donarsModel.isEmergency,
                  deadLine: donarsModel.deadLine,
                  phoneNumber: donarsModel.phoneNumber,
                  lat: donarsModel.lat,
                  lng: donarsModel.lng,
                  location: donarsModel.location,
                  donarStat: "nothing");
              _streams.userQuery
                  .doc(value.docs[i].id)
                  .collection(Streams.seekersRequest)
                  .doc(donationId)
                  .set(donar.toMap());
              NotificationService().sendPushNotification(userToToken,
                  title: "Blood Donation Request",
                  desc:
                      "We are in need of blood donors to help save the life of a patient undergoing medical treatment.You are elgible for this please do consider to donate");
            }
          }
        }
      });
    }
  }

// if emergency we will send notification to requested blood type users as well as waatti message

  //############ store userInfo ####################

  Future<UserProfile?> getUserInfo() async {
    String id = _preferences.getUserId();
    var a = await _streams.userQuery.doc(id).get();
    _userProfile = UserProfile.fromMap(a.data()!);
    return _userProfile;
    // notifyListeners();
  }

  Future<UserProfile?> checkAndGetUser() async {
    String id = _preferences.getUserId();
    await Streams()
        .userQuery
        .where("userId", isEqualTo: id)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        return _userProfile = null;
      } else {
        var a = value.docs;
        _userProfile = UserProfile.fromMap(a.first.data());
        return _userProfile;
      }
    });
    if (_userProfile != null) {
      return _userProfile;
    } else {
      return null;
    }
//    return null;
  }

  // Future<bool> checkUser(){

  // }

  setUserInfo(UserProfile userProfile) {
    _userProfile = userProfile;
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
