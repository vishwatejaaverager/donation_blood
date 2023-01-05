import 'dart:developer';

import 'package:flutter/material.dart';


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class ConnectivityRepo with ChangeNotifier {
  final Connectivity connectivity = Connectivity();

  String _connectionStatus = 'Unknown';
  String get connectionStatus => _connectionStatus;

  bool _isNetworkConnectionAvailable = true;
  bool get isNetworkConnectionAvailable => _isNetworkConnectionAvailable;

  bool _checked = false;
  bool get checked => _checked;

  bool _checking = false;
  bool get checking => _checking;

  Future initConnectivity() async {
    ConnectivityResult? result;
    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log(e.toString());
    } catch (e) {
      log(e.toString());
    }
    //  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    //     return Future.value(null);
    //   });
    return updateConnectionStatus(result!);
  }

  updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        _connectionStatus = result.toString();
        _isNetworkConnectionAvailable = true;
        log('Result  : $_connectionStatus');
        break;

      case ConnectivityResult.mobile:
        _connectionStatus = result.toString();
        _isNetworkConnectionAvailable = true;
        break;

      case ConnectivityResult.none:
        _connectionStatus = result.toString();
        _isNetworkConnectionAvailable = false;
        log('Result  : $_connectionStatus');

        break;
      default:
        _connectionStatus = 'Failed to get connectivity.';
        _isNetworkConnectionAvailable = false;
        break;
    }
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
    return null;
    // return;
  }

  checkConnectivity() {
    _checking = true;

    Future.delayed(const Duration(milliseconds: 1000), () {
      _checked = true;
      _checking = false;
    });
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }

  handleConnectivity(bool haveInternet) {
    if (haveInternet) {
      _checking = false;
      _checked = false;
    }
    notifyListeners();
  }
}
