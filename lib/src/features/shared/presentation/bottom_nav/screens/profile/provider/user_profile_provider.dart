import 'dart:developer';

import 'package:donation_blood/src/utils/streams.dart';
import 'package:flutter/cupertino.dart';

class UserProfileProvider extends ChangeNotifier {
  final Streams _streams = Streams();
  int _donationDays = 0;
  int get donationDays => _donationDays;

  String _daysLeft = "";
  String get daysLeft => _daysLeft;

  daysFromPresent(DateTime date, String userID) {
    DateTime now = DateTime.now(); // get the current date and time
    Duration difference =
        date.difference(now); // get the difference between the two dates
    int days = difference.inDays.abs();
    _donationDays = days;
    var a = 90 - days;
    _daysLeft = a.toString();
    if (_donationDays == 90) {
      updateUserAvailability(userID);
    }
    log(_donationDays
        .toString()); // convert the difference to days, and take the absolute value (in case the date is in the past)
  }

  updateUserAvailability(String userId) {
    _streams.userQuery.doc(userId).update({"isAvailable": true});
  }

  addWalletPointsToUser(String userId, String donId) async {
    await _streams.userQuery
        .doc(userId)
        .collection(Streams.seekersRequest)
        .doc(donId)
        .update({"donarStat": "claimed"});

    await _streams.userQuery
        .doc(userId)
        .collection(Streams.wallet)
        .doc(userId)
        .set({"coins": "500"});
  }

  String _livesCount = "0";
  String get livesCount => _livesCount;

  String _coins = "0";
  String get coins => _coins;

  String _liters = "";
  String get liters => _liters;

  getSavedLivesAndPoints(String userId) async {
    try {
      var a = await _streams.userQuery
          .doc(userId)
          .collection(Streams.seekersRequest)
          .where("donarStat", isEqualTo: "claimed")
          .get();

      var b = await _streams.userQuery
          .doc(userId)
          .collection(Streams.wallet)
          .doc(userId)
          .get();

      _livesCount = a.docs.length.toString();
      _coins = b.data()!['coins'];
      var c = double.parse(_livesCount);
      var d = c * 350;

      _liters = d.toString();
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }
}
