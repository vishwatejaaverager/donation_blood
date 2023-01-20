import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../src/features/shared/domain/models/blood_donation_model.dart';
import '../../components/request_blood_card.dart';
import '../../providers/requests_provider.dart';
import '../donate_blood_screen.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RequestProvider>(builder: ((_, __, ___) {
      return ListView.builder(
          itemCount: __.isLoading ? 40 : __.allEmergency.length,
          shrinkWrap: true,
          itemBuilder: ((context, index) {
            if (!__.isLoading) {
              BloodDonationModel requestData =
                  BloodDonationModel.fromMap(__.allEmergency[index].data());
              return RequestBloodCard(bloodDonationModel: requestData);
            } else {
              return const CircularProgressIndicator();
            }
          }));
    }));
  }
}
