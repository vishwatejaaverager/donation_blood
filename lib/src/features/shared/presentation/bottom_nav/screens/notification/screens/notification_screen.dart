import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_blood/src/features/profile_det/provider/profile_provider.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/notification/provider/responses_provider.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/notification/screens/filtered_screens/blood_response_screen.dart';
import 'package:donation_blood/src/features/splash_screen/splash_screen.dart';
import 'package:donation_blood/src/utils/streams.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final Streams _streams = Streams();
  late TabController _tabController;
  late ResponseProvider responseProvider;
  //late Stream<QuerySnapshot<Map<String, dynamic>>> _bloodReqByUsers;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _seekerReqByUser;
  String? userId;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 1);
    userId = globalUserProfile!.userId;
    responseProvider = Provider.of<ResponseProvider>(context, listen: false);
    responseProvider.getAllSeekersRequest(userId!);
    log("${userId!}notification screen");
    // _bloodReqByUsers = _streams.userQuery
    //     .doc(userId)
    //     .collection(Streams.userInterests)
    //     .snapshots();
    _seekerReqByUser = _streams.userQuery
        .doc(userId)
        .collection(Streams.seekersRequest)
        .snapshots();

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
                  SizedBox(child: Center(child: Text("Seeker's  Requests"))),
                  //  SizedBox(child: Center(child: Text("Your Requests")))
                ],
                controller: _tabController,
                tags: const []),
            Expanded(
                child: TabBarView(
              controller: _tabController,
              children: [
                SeekersResponseScreen(
                  seekerRequests: _seekerReqByUser,
                ),
                // BloodUserResScreen(
                //   bloodReqByUsers: _bloodReqByUsers,
                // )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
