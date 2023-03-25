import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';
import '../../../assets_strings.dart';

class WarningWidget extends StatelessWidget {
  const WarningWidget({
    Key? key,
    this.scale,
    this.text1 = "0",
    required this.text,
  }) : super(key: key);
  final String text;
  final String text1;
  final double? scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        text1 != "0"
            ? Container(
                alignment: Alignment.bottomCenter,
                width: size.width,
                padding: const EdgeInsets.only(bottom: 16, top: 4),
                decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12))),
                child: Text(
                  text1,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ))
            : const SizedBox(),
        Column(
          children: [
            Image.asset(
              Assets.allImage,
              scale: scale,
            ),
            sbh(24),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
             sbh(24),
          ],
        )
      ],
    );
  }
}
