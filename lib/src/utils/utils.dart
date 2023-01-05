import 'package:flutter/material.dart';

final window = WidgetsBinding.instance.window;
Size size = window.physicalSize / window.devicePixelRatio;

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

appToast(String message) {
  snackbarKey.currentState?.showSnackBar(SnackBar(
    content: Text(message),
  ));
}

sbh(double h) {
  return SizedBox(
    height: h,
  );
}

sbw(double w) {
  return SizedBox(
    width: w,
  );
}
