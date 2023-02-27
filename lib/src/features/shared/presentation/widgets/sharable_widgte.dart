import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';
import '../../domain/models/blood_donation_model.dart';

class SharableWidget extends StatelessWidget {
  final BloodDonationModel bloodInfo;
  const SharableWidget({
    Key? key,
    required this.bloodInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: size.height / 1.5,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.red.shade700,
                Colors.red.shade300,
              ],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: size.width / 1.2,
                child: Text(
                  'Urgent Request - Need ${bloodInfo.bloodGroup} Blood immediately in ${bloodInfo.location},donars kindly Whatsapp or call at ${bloodInfo.number} ,seeking your support in passing on this message to Possible donars ',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
            sbh(12),
            const Text(
              "For more info Download the app ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
    );
  }
}
