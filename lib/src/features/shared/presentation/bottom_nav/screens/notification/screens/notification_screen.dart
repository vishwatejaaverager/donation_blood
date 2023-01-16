import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/notification/screens/filtered_screens/blood_response_screen.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/notification/screens/filtered_screens/blood_user_res_screen.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../bottom_nav/screens/donate_blood/screens/donate_blood_screen.dart';
import '../../../../../../../utils/routes.dart';

class NotificationScreen extends StatefulWidget {
  static const id = AppRoutes.notificationScreen;
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 16.0),
              child: Text(
                "History",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            FrequencyTabs(
                tabs: const [
                  SizedBox(child: Center(child: Text("Request History"))),
                  SizedBox(child: Center(child: Text("All")))
                ],
                controller: _tabController,
                tags: const []),
            Expanded(
                child: TabBarView(
              controller: _tabController,
              children: const [BloodResponseScreen(), BloodUserResScreen()],
            ))
          ],
        ),
      ),
    );
  }
}
