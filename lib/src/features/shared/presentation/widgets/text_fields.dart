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
