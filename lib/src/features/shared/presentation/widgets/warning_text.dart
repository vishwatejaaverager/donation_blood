import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';
import '../../../assets_strings.dart';

class WarningWidget extends StatelessWidget {
  const WarningWidget({
    Key? key,
    this.scale,
    required this.text,
  }) : super(key: key);
  final String text;
  final double? scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
        )
      ],
    );
  }
}
