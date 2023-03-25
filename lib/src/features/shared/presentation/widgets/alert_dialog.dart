import 'dart:ui';

import 'package:donation_blood/src/features/profile_det/provider/profile_provider.dart';
import 'package:donation_blood/src/utils/navigation.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/utils.dart';

// ignore: must_be_immutable
class BlurryDialog extends StatelessWidget {
  final String title;
  final String content;
  final bool isUnits;
  VoidCallback continueCallBack;

  BlurryDialog(this.title, this.content, this.continueCallBack,
      {super.key, this.isUnits = false});
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
          content: isUnits
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "No. of units donated ?",
                      style: textStyle,
                    ),
                    Consumer<ProfileProvider>(
                      builder: (context, value, child) {
                        return Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                                elevation: 6,
                                child: Image.asset(
                                  "assets/home/blood.png",
                                  scale: 20,
                                )),
                            sbw(4),
                            //    Text(value.unitDrop + " Units"),
                            DropdownButton2<String>(
                                underline: const SizedBox(),
                                buttonWidth: 100,
                                // icon: Icon(Icons.arrow_drop_down_circle_sharp),
                                // isExpanded: true,
                                value: value.unitDrop,
                                items: value.units
                                    .map<DropdownMenuItem<String>>(
                                        (String e) => DropdownMenuItem(
                                              // enabled: false,
                                              value: e,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 32.0),
                                                child: Text(e),
                                              ),
                                            ))
                                    .toList(),
                                onChanged: (v) {
                                  value.setUnitDrop(v!);
                                })
                          ],
                        );
                      },
                    )
                  ],
                )
              : Text(
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
