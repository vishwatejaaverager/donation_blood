import 'package:flutter/material.dart';

import '../../../../../../../utils/colors.dart';
import '../../../../../../../utils/utils.dart';
import '../../../../../../../utils/widget_utils/size_config.dart';

class HomeTile extends StatelessWidget {
  const HomeTile({
    Key? key,
    required this.image,
    required this.text,
    required this.ontap,
    required this.scale,
  }) : super(key: key);

  final String image, text;
  final Function() ontap;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        elevation: 10,
        child: Container(
            height: getProportionateScreenWidth(size.width / 3.5),
            width: getProportionateScreenWidth(size.width / 3),
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  image,
                  scale: scale,
                ),
                sbh(8),
                Text(text)
              ],
            )),
      ),
    );
  }
}
