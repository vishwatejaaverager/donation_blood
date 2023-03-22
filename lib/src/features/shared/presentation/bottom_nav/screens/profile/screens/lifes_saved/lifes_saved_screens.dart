import 'package:donation_blood/src/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../../bottom_nav/screens/donate_blood/components/request_blood_card.dart';
import '../../../../../../../../../bottom_nav/screens/donate_blood/providers/requests_provider.dart';
import '../../../../../../domain/models/blood_donation_model.dart';
import '../../../../../widgets/warning_text.dart';

class LifesSavedScreen extends StatelessWidget {
  static const id = AppRoutes.lifesSavedScreen;
  const LifesSavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Lifes Saved by Blood Flow :)",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Consumer<RequestProvider>(builder: ((_, __, ___) {
          if (__.allRequests.isNotEmpty) {
            return ListView.builder(
                itemCount: __.isLoading ? 40 : __.completedReq.length,
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  if (!__.isLoading) {
                    BloodDonationModel requestData =
                        BloodDonationModel.fromMap(__.completedReq[index].data());
                    return RequestBloodCard(
                      bloodDonationModel: requestData,
                      isCompleted: true,
                      bottonText: "Completed",
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }));
          } else {
            return const WarningWidget(text: "No Blood Requests :)");
          }
        })));
  }
}
