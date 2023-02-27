import 'dart:ui';

import 'package:donation_blood/src/utils/navigation.dart';
import 'package:flutter/material.dart';

class BlurryDialog extends StatelessWidget {
  final String title;
  final String content;
  VoidCallback continueCallBack;

  BlurryDialog(this.title, this.content, this.continueCallBack, {super.key});
  TextStyle textStyle = const TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24))),
          title: Text(
            title,
            style: textStyle,
          ),
          content: Text(
            content,
            style: textStyle,
          ),
          actions: <Widget>[
            InkWell(
              child: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                    //  color: Colors.red.shade100,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: const Text("Cancel "),
              ),
              onTap: () {
                Navigation.instance.pushBack();
              },
            ),
            InkWell(
              child: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: const BorderRadius.all(Radius.circular(4))),
                child: const Text("Continue "),
              ),
              onTap: () {
                continueCallBack();
              },
            ),
          ],
        ));
  }
}
