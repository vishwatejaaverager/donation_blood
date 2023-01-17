import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_blood/src/features/shared/domain/models/user_profile_model.dart';
import 'package:donation_blood/src/utils/streams.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:map_launcher/map_launcher.dart';

class RequestProvider with ChangeNotifier {
  final Streams _streams = Streams();
  // final Preferences _preferences = Preferences();

  bool _isLoading = true;
  bool get isLoading => _isLoading;

// ################### request onboarding ########################################
  String _selectedOpt = 'Yes';
  String get selectedOpt => _selectedOpt;

  String _selectedOpt1 = 'Yes';
  String get selectedOpt1 => _selectedOpt1;

  String _selectedOpt2 = 'Yes';
  String get selectedOpt2 => _selectedOpt2;

  setSelectedOpt(String s) {
    _selectedOpt = s;
    notifyListeners();
  }

  setSelectedOpt1(String s) {
    _selectedOpt1 = s;
    notifyListeners();
  }

  setSelectedOpt2(String s) {
    _selectedOpt2 = s;
    notifyListeners();
  }

  addInterestedDonars(String userID) async {
    await _streams.requestQuery
        .where('userId', isEqualTo: userID)
        .get()
        .then((value) {
      String docId = value.docs.single.id;
      log(docId);
      _streams.requestQuery.doc(docId).update({
        'intrestedDonars': FieldValue.arrayUnion([userID])
      });
    });

    await _streams.userQuery
        .doc(userID)
        .collection(Streams.requestByUser)
        .where('userId', isEqualTo: userID)
        .get()
        .then((value) {
      String docId = value.docs.single.id;
      log(docId);
      _streams.userQuery
          .doc(userID)
          .collection(Streams.requestByUser)
          .doc(docId)
          .update({
        'intrestedDonars': FieldValue.arrayUnion([userID])
      });
    });
  }

//######################## all requests loading #################################
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _allRequests = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get allRequests =>
      _allRequests;
  getAllReuests(UserProfile userProfile) async {
    _isLoading = true;
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
    // String id = _preferences.getUserId();

    if (_allRequests.isEmpty) {
      var allReq = await _streams.requestQuery.get();
      _allRequests = allReq.docs;
      log(_allRequests.length.toString());
      for (var i = 0; i < _allRequests.length; i++) {
        log("message");
        storeBloodType(_allRequests, userProfile, i);
        storeEmergencyRequests(_allRequests, i);
      }
    }
    _isLoading = false;

    log(_isLoading.toString());
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }

  //##################### store emergency and  blood type #################
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> _allEmergency = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get allEmergency =>
      _allEmergency;

  storeEmergencyRequests(List req, int index) {
    //for (var element in req) {
    if (req[index]['isEmergency']) {
      _allEmergency.add(req[index]);
    }
    // }

    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    //   notifyListeners();
    // });
  }

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> _sameType = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get sameType => _sameType;

  storeBloodType(List req, UserProfile userProfile, int index) {
    //for (var element in req) {
    if (req[index]['bloodGroup'] == userProfile.bloodGroup) {
      _sameType.add(req[index]);
    }
    //  }
    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    //   notifyListeners();
    // });
  }

//########################## launch maps ###################################
  launchMaps(double lat, double lng, String hosp) async {
    try {
      final availableMap = await MapLauncher.installedMaps;
      log(availableMap.toString());

      await availableMap.first
          .showMarker(coords: Coords(lat, lng), title: hosp);
    } catch (e) {
      log(e.toString());
    }
  }
}
