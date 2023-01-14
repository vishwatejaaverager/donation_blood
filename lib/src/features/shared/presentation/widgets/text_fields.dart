import 'package:flutter/material.dart';

class DetailedTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final Widget? dropDown;
  final bool enabled;
  final TextInputType? textInputType;
  final Function()? onpressed;
  const DetailedTextFiled(
      {Key? key,
      this.enabled = true,
      required this.controller,
      required this.text,
      this.textInputType,
      this.onpressed,
      this.dropDown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFormField(
          controller: controller,
          keyboardType: textInputType,
          // validator: (value) {
          //   if (controller.text.isNotEmpty)
          //     return null;
          //   else
          //     return 'Enter this field';
          // },
          decoration: InputDecoration(
              enabled: enabled,
              labelText: text,
              suffixIcon: dropDown,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
              ),
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.all(4)),
        ),
      ),
    );
  }
}

class ReqTextFiled extends StatelessWidget {
  final String sideHeading, hintText;
  final TextEditingController controller;
  final Widget icon;
  final bool isDisabled;
  const ReqTextFiled({
    required this.sideHeading,
    this.hintText = '',
    required this.controller,
    required this.icon,
    this.isDisabled = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(sideHeading),
        Card(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              // border: Border.all(color: Colors.black)
            ),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                  enabled: isDisabled,
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    fontSize: 16,
                  ),
                  icon: Card(
                    child: Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: icon),
                  ),
                  border: InputBorder.none),
            ),
          ),
        )
      ],
    );
  }
}

class EmptyTextField extends StatelessWidget {
  final Widget text;
  final Widget? widget;
  const EmptyTextField({super.key, required this.text, this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [text, widget ?? const SizedBox()],
        ));
  }
}
