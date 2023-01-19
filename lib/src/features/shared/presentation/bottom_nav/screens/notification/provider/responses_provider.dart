import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_blood/src/features/shared/domain/models/interested_donar_model.dart';
import 'package:donation_blood/src/utils/streams.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

class ResponseProvider with ChangeNotifier {
  final Streams _streams = Streams();

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  //############ seekers requests ###############

  List<QueryDocumentSnapshot<Map<String, dynamic>>> _seekerRequest = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get seekerRequest =>
      _seekerRequest;

  getAllSeekersRequest(String userId) async {
    //  try {
    // log("came");
    // log(userId);
    _isLoading = true;
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
    var a = await _streams.userQuery
        .doc(userId)
        .collection(Streams.seekersRequest)
        .get();
    _seekerRequest = a.docs;
    //   log(_seekerRequest.length.toString());
    _isLoading = false;
    log(_isLoading.toString());
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
    // } catch (e) {
    //   log(e.toString());
    // }
    // _seekerRequest = a.docs;
  }

  //############# this is to get user ! ############

  List<QueryDocumentSnapshot<Map<String, dynamic>>> _userToDonate = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get userToDonate =>
      _userToDonate;

  getUserResFromFirebase(String userId) async {
    _isLoading = true;
    var a = await _streams.userQuery
        .doc(userId)
        .collection(Streams.requestByUser)
        .get();
    _userToDonate = a.docs;
    // BloodDonationModel reqData =
    //     BloodDonationModel.fromMap(__.userToDonate[index].data());
    _isLoading = false;
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }

  //############# give res to user about donation req ########################

  changeStatofDonationReq(InterestedDonarsModel donarsModel, List a) {
    _streams.userQuery
        .doc(donarsModel.userTo)
        .collection(Streams.requestByUser)
        .doc(donarsModel.donationId)
        .update({"intrestedDonars": FieldValue.arrayUnion(a)});
  }
}
