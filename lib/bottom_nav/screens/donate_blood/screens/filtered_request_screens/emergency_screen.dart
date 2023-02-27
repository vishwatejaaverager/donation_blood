import 'package:donation_blood/src/features/shared/presentation/widgets/warning_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../../src/features/shared/domain/models/blood_donation_model.dart';
import '../../components/request_blood_card.dart';
import '../../providers/requests_provider.dart';

class EmergencyScreen extends StatelessWidget {
  final ScreenshotController controller;
  const EmergencyScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RequestProvider>(builder: ((_, __, ___) {
      if (__.allEmergency.isNotEmpty) {
        return ListView.builder(
            itemCount: __.isLoading ? 40 : __.allEmergency.length,
            shrinkWrap: true,
            itemBuilder: ((context, index) {
              if (!__.isLoading) {
                BloodDonationModel requestData =
                    BloodDonationModel.fromMap(__.allEmergency[index].data());
                return RequestBloodCard(
                  bloodDonationModel: requestData,
                  controller: controller,
                );
              } else {
                return const CircularProgressIndicator();
              }
            }));
      } else {
        return const WarningWidget(
          text: "No Emergency Blood Requests :)",
        );
      }
    }));
  }
}
