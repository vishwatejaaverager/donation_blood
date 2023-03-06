import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_blood/src/features/notification/notification_services.dart';
import 'package:donation_blood/src/features/shared/domain/models/blood_donation_model.dart';
import 'package:donation_blood/src/features/shared/domain/models/interested_donar_model.dart';
import 'package:donation_blood/src/utils/navigation.dart';
import 'package:donation_blood/src/utils/streams.dart';
import 'package:donation_blood/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:url_launcher/url_launcher.dart';

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

  changeStatofDonationReq(
      InterestedDonarsModel donarsModel, List a, List b, String stat) {
    _streams.userQuery
        .doc(donarsModel.userTo)
        .collection(Streams.requestByUser)
        .doc(donarsModel.donationId)
        .update({'intrestedDonars': FieldValue.arrayRemove(b)});
    _streams.userQuery
        .doc(donarsModel.userTo)
        .collection(Streams.requestByUser)
        .doc(donarsModel.donationId)
        .update({'intrestedDonars': FieldValue.arrayUnion(a)});
    _streams.userQuery
        .doc(donarsModel.userFrom)
        .collection(Streams.userInterests)
        .doc(donarsModel.donationId)
        .update({"donarStat": stat});
  }

  acceptDonationFromDonarAndReject(
      InterestedDonarsModel donarsModel, String response,
      {BloodDonationModel? bloodDonationModel, bool isReject = true}) async {
    if (isReject) {
      await _streams.userQuery
          .doc(donarsModel.userFrom)
          .collection(Streams.requestByUser)
          .doc(donarsModel.donationId)
          .collection(Streams.shownInterestToDonate)
          .doc(donarsModel.userTo)
          .update({'donarStat': response});

      _streams.userQuery
          .doc(donarsModel.userTo)
          .collection(Streams.seekersRequest)
          .doc(donarsModel.donationId)
          .update({'donarStat': response});

      log("${donarsModel.userToToken!}notification sent ");

      NotificationService().sendPushNotification(donarsModel.userToToken!,
          title: "Dear ${donarsModel.donarName}",
          desc:
              "We are delighted to inform you that your blood donation request has been accepted by one of our recipients. Your donation will make a significant impact on their health and well-being, and we cannot thank you enough for your generosity.");
      Navigation.instance.pushBack();
    } else {
      await _streams.userQuery
          .doc(donarsModel.userFrom)
          .collection(Streams.requestByUser)
          .doc(donarsModel.donationId)
          .collection(Streams.shownInterestToDonate)
          .doc(donarsModel.userTo)
          .update({'donarStat': response});
    }
  }

  actualAcceptAndRejectDonation(
      InterestedDonarsModel donarsModel, String response,
      {BloodDonationModel? bloodDonationModel}) async {
    log("${donarsModel.userTo} thisss is thi s");
    log("${donarsModel.userFrom} thisss is thi s");
    await _streams.userQuery
        .doc(donarsModel.userTo)
        .collection(Streams.requestByUser)
        .doc(donarsModel.donationId)
        .collection(Streams.shownInterestToDonate)
        .doc(donarsModel.userFrom)
        .update({'donarStat': response});

    await _streams.userQuery
        .doc(donarsModel.userFrom)
        .collection(Streams.seekersRequest)
        .doc(donarsModel.donationId)
        .update({'donarStat': response});

    NotificationService().sendPushNotification(donarsModel.userToToken!,
        title: "Dear ${donarsModel.donarName}",
        desc:
            "We want to express our heartfelt gratitude for your recent blood donation at our center. Your selfless act of kindness has brought hope and support to those in need, and we cannot thank you enough for your generosity.");

    if (response == 'donated') {
      var a = int.parse(bloodDonationModel!.units!);
      var d = int.parse(bloodDonationModel.donatedUnits!);
      int donatedUnits = d + 1;
      int units = a - 1;

      _streams.userQuery.doc(donarsModel.userFrom).update(
          {"isAvailable": false, "donatedTime": DateTime.now().toString()});

      await _streams.requestQuery.doc(donarsModel.donationId).update(
          {"units": units.toString(), "donatedUnits": donatedUnits.toString()});

      await _streams.userQuery
          .doc(donarsModel.userTo)
          .collection(Streams.requestByUser)
          .doc(donarsModel.donationId)
          .update({
        "units": units.toString(),
        "donatedUnits": donatedUnits.toString()
      });
      if (units == 0) {
        await _streams.requestQuery
            .doc(donarsModel.donationId)
            .update({"donationStat": "completed"});

        await _streams.userQuery
            .doc(donarsModel.userTo)
            .collection(Streams.requestByUser)
            .doc(donarsModel.donationId)
            .update({"donationStat": "completed"});
      }
    }
    Navigation.instance.pushBack();
  }

  void launchPhoneApp(String phoneNumber) async {
    final phoneUrl = 'tel:$phoneNumber';
    if (await canLaunchUrl(Uri.parse(phoneUrl))) {
      await launchUrl(Uri.parse(phoneUrl));
    } else {
      appToast("some thing went wrong :( ");
    }
  }
}
