import 'package:donation_blood/src/utils/widget_utils/size_config.dart';
import 'package:flutter/material.dart';

import '../../../../src/utils/colors.dart';
import '../../../../src/utils/utils.dart';

class HomeCountView extends StatelessWidget {
  final String count, text1, text2, image;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  const HomeCountView({
    Key? key,
    required this.count,
    required this.text1,
    required this.text2,
    required this.image,
    this.mainAxisAlignment,
    this.crossAxisAlignment
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        Row(
        
          children: [
            Text(
              count,
              style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: getFontSize(45),
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
        Column(
          crossAxisAlignment:crossAxisAlignment?? CrossAxisAlignment.start,
          children: [
            Text(
              text1,
              style: const TextStyle(color: AppColors.whiteColor),
            ),
            Text(
              text2,
              style: const TextStyle(color: AppColors.whiteColor),
            )
          ],
        )
      ],
    );
  }
}
