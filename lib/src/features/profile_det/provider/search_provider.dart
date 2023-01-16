import 'dart:convert';
import 'dart:developer';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/donars/provider/donar_provider.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';

import '../../../utils/navigation.dart';

class SearchProvider with ChangeNotifier {
  List<dynamic> _placesData = [];
  List<dynamic> get placesData => _placesData;

  Location? _userLocation;
  Location? get userLocation => _userLocation;

  String _selectedPlace = '';
  String get selectedPlace => _selectedPlace;

  configUserLoaction(Location loc) {
    _userLocation = loc;
  }

  configSelectedPlace(String s) {
    _selectedPlace = s;
    notifyListeners();
  }

  getCoOrdinates(String p, BuildContext context) async {
    try {
      final places =
          GoogleMapsPlaces(apiKey: 'AIzaSyBzm0NvCH2RFsttbwBBMTujYtidyYK97pY');

      await places.getDetailsByPlaceId(p).then((value) {
        _userLocation = value.result.geometry!.location;
        log("${_userLocation!.lat}latitude");
        log("${_userLocation!.lng} longitude");
        Provider.of<DonarProvider>(context, listen: false)
            .setHospitalLocation(_userLocation!);

        Navigation.instance.pushBack();
      });
    } catch (e) {
      log(e.toString());
    }
  }

  placeAutocomplete(String query) async {
    log(query.toString());
    Uri uri = Uri.https(
        "maps.googleapis.com",
        '/maps/api/place/autocomplete/json',
        {"input": query, "key": "AIzaSyBzm0NvCH2RFsttbwBBMTujYtidyYK97pY"});
    await fetchUrl(uri);
    // if (res != null) {
    //   log(res.toString());
    // }
  }

  fetchUrl(Uri uri, {Map<String, String>? headers}) async {
    try {
      final res = await http.get(uri, headers: headers);
      if (res.statusCode == 200) {
        log(res.body.toString());
        _placesData = jsonDecode(res.body.toString())['predictions'];
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          notifyListeners();
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
