import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_blood/src/features/shared/domain/models/blood_req_model.dart';
import 'package:donation_blood/src/features/shared/domain/models/user_profile_model.dart';
import 'package:donation_blood/src/services/dist_util.dart';
import 'package:donation_blood/src/utils/streams.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_webservice/places.dart';

import '../../../../../../profile_det/provider/profile_provider.dart';

class DonarProvider with ChangeNotifier {
  final Streams _streams = Streams();

  bool _isLoading = true;
  bool get isLoading => _isLoading;
//######## set location #################
  Location? _hospLocation;
  Location? get hospLoc => _hospLocation;

  setHospitalLocation(Location hosp) {
    _hospLocation = hosp;
  }

  //###################### donars #######################3
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _allDonars = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get allDonars => _allDonars;

  getAllDonars(UserProfile userProfile) async {
    _isLoading = true;
    if (_allDonars.isEmpty) {
      QuerySnapshot<Map<String, dynamic>> fetchDonars =
          await _streams.userQuery.where('isAvailable', isEqualTo: true).get();
      _allDonars = fetchDonars.docs;
      for (var i = 0; i < _allDonars.length; i++) {
        getSameTypeDonars(_allDonars, userProfile, i);
        getNearbyDonars(_allDonars, userProfile, i);
      }
    }
    _isLoading = false;
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }

//########################### fetch same type and nearby donars ##############
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> _sameType = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get sameType => _sameType;

  getSameTypeDonars(List req, UserProfile userProfile, int index) {
    log(req[index]['name']);
    if (req[index]['bloodGroup'] == userProfile.bloodGroup) {
      _sameType.add(req[index]);
    }
  }

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> _nearby = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get nearby => _nearby;

  getNearbyDonars(List req, UserProfile userProfile, int index) {
    double dist = calculateDistances(
        userProfile.lat!.toDouble(),
        userProfile.long!.toDouble(),
        req[index]['lat'].toDouble(),
        req[index]['long'].toDouble());
    if (dist < 5000) {
      _nearby.add(req[index]);
    }

    log(dist.toString());
  }

//########### calc dist from user pov###################
  String calcDistFromUser(
    BuildContext context, {
    bool isUser = true,
    Location? hospLoc,
    UserProfile? fetchedUser,
  }) {
    UserProfile actualUserProfile =
        Provider.of<ProfileProvider>(context, listen: false).userProfile!;
    if (isUser) {
      double dist = calculateDistances(
          actualUserProfile.lat!.toDouble(),
          actualUserProfile.long!.toDouble(),
          fetchedUser!.lat!.toDouble(),
          fetchedUser.long!.toDouble());
      double distanceInKiloMeters = dist / 1000;
      double roundDistanceInKM =
          double.parse((distanceInKiloMeters).toStringAsFixed(2));
      return roundDistanceInKM.toString();
    } else {
      double dist = calculateDistances(
          actualUserProfile.lat!.toDouble(),
          actualUserProfile.long!.toDouble(),
          hospLoc!.lat.toDouble(),
          hospLoc.lng.toDouble());
      double distanceInKiloMeters = dist / 1000;
      double roundDistanceInKM =
          double.parse((distanceInKiloMeters).toStringAsFixed(2));
      return roundDistanceInKM.toString();
    }
  }

//################# create request in user #############################
  createBloodRequest(BloodRequestModel bloodRequestModel) {
    _streams.userQuery
        .doc(bloodRequestModel.userFrom)
        .collection(Streams.requests)
        .doc()
        .set(bloodRequestModel.toMap());
    _streams.userQuery
        .doc(bloodRequestModel.userTo)
        .collection(Streams.seekersRequest)
        .doc()
        .set(bloodRequestModel.toMap());
  }
}
