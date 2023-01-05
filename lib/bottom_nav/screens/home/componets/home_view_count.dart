import 'package:flutter/material.dart';

import '../../../../src/utils/colors.dart';
import '../../../../src/utils/utils.dart';

class HomeCountView extends StatelessWidget {
  final String count, text1, text2, image;
  const HomeCountView({
    Key? key,
    required this.count,
    required this.text1,
    required this.text2,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              count,
              style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 45,
                  fontWeight: FontWeight.bold),
            ),
            sbw(4),
            Image.asset(
              image,
              scale: 10,
              color: AppColors.whiteColor,
            )
          ],
        ),
        sbh(8),
        Text(
          text1,
          style: const TextStyle(color: AppColors.whiteColor),
        ),
        Text(
          text2,
          style: const TextStyle(color: AppColors.whiteColor),
        )
      ],
    );
  }
}
