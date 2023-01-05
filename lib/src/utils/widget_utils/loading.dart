import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils.dart';

class Loading {
  void indicator(BuildContext context) {
    showDialog(
        context: (context),
        builder: (BuildContext context) =>
            const Center(child: SpinKitWave(color: Colors.white, size: 50.0)));
  }

  witIndicator(
      {required BuildContext context,
      required String? title,
      String subTitle = 'Please wait...',
      bool? barrier = false}) {
    showDialog(
      context: context,
      barrierDismissible: barrier!,
      builder: (context) => AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinKitDancingSquare(color: Colors.red),
            sbh(5),
            Text(
              title ?? "",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            sbh(5),
            Text(
              subTitle,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
