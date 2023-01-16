import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/notification/provider/responses_provider.dart';
import 'package:donation_blood/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BloodResponseScreen extends StatelessWidget {
  const BloodResponseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ResponseProvider>(builder: ((_, __, ___) {
      return ListView.builder(
          itemCount: 2,
          itemBuilder: ((context, index) {
            
            return Card(
                elevation: 20,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                child: Column(
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        radius: 30,
                      ),
                      title: const Text("Vishwa"),
                      trailing: const CircleAvatar(
                        radius: 30,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.gps_fixed),
                              Text(" 23 Km away ")
                            ],
                          ),
                          const Text("Blood required jan 28"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(8)),
                            child: const Center(child: Text("Accept Offer")),
                          )),
                          sbw(24),
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.all(8),
                            child: const Center(
                                child: Text("Reject With thanks ")),
                          ))
                        ],
                      ),
                    )
                  ],
                ));
          }));
    }));
  }
}
