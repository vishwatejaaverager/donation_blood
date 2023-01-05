import 'package:flutter/material.dart';

class LoginMethodButton extends StatelessWidget {
  final String text;
  final Widget widget;
  final Function() onpressed;

  const LoginMethodButton({
    Key? key,
    required this.text,
    required this.onpressed,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Container(
        width: MediaQuery.of(context).size.width - 32,
        // margin: const EdgeInsets.symmetric(horizontal: 34, vertical: 8),
        padding: const EdgeInsets.all(8),
        //height: 50,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(24))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget,
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w900),
            )
          ],
        ),
      ),
    );
  }
}
