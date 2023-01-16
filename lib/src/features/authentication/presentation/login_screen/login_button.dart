import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/utils.dart';

class LoginButton extends StatelessWidget {
  final Function() onPressed;
  final Widget? icons;
  final String text;
  const LoginButton({
    Key? key,
    this.icons,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          margin: const EdgeInsets.all(16),
          width: size.width,
          height: 50,
          decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                      color: AppColors.whiteColor, fontWeight: FontWeight.bold),
                ),
                icons ??
                    const Icon(
                      Icons.arrow_right_rounded,
                      color: AppColors.whiteColor,
                      size: 32,
                    )
              ],
            ),
          )),
    );
  }
}
