import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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

//######################## all requests loading #################################
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _allRequests = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get allRequests =>
      _allRequests;
  getAllReuests() async {
    _isLoading = true;
    // String id = _preferences.getUserId();

    _streams.requestQuery.get().then((value) {
      _allRequests = value.docs;
      log(_allRequests.length.toString());
      storeEmergencyRequests(_allRequests);
    });
    _isLoading = false;
    log(_isLoading.toString());
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }

  storeEmergencyRequests(List req) {
    for (var element in req) {
      if (element['isEmergency']) {
        log("message");
      }
    }
    notifyListeners();
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
