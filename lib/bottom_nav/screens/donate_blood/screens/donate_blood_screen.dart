import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_blood/bottom_nav/screens/donate_blood/screens/filtered_request_screens/user_blood_requests.dart';
import 'package:donation_blood/src/features/splash_screen/splash_screen.dart';
import 'package:donation_blood/src/utils/routes.dart';
import 'package:donation_blood/src/utils/streams.dart';
import 'package:donation_blood/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import '../providers/requests_provider.dart';
import 'filtered_request_screens/all_req_screen.dart';
import 'filtered_request_screens/blood_type_screen.dart';
import 'filtered_request_screens/emergency_screen.dart';

class DonateBloodScreen extends StatefulWidget {
  static const id = AppRoutes.donateBloodScreen;
  const DonateBloodScreen({super.key});

  @override
  State<DonateBloodScreen> createState() => _DonateBloodScreenState();
}

class _DonateBloodScreenState extends State<DonateBloodScreen>
    with SingleTickerProviderStateMixin {
  final Streams _streams = Streams();

  late TabController _tabController;
  // late UserProfile userProfile;

  late Stream<QuerySnapshot<Map<String, dynamic>>> _bloodReqByUsers;
  @override
  void initState() {
    // Provider.of<ProfileProvider>(context, listen: false).getUserInfo();
    Provider.of<RequestProvider>(context, listen: false)
        .getAllReuests(globalUserProfile!);
    // userProfile =
    //     Provider.of<ProfileProvider>(context, listen: false).userProfile!;
    _tabController = TabController(vsync: this, length: 4);
    // actualUserProfile =
    //     Provider.of<ProfileProvider>(context, listen: false).userProfile!;
    _bloodReqByUsers = _streams.userQuery
        .doc(globalUserProfile!.userId!)
        .collection(Streams.requestByUser)
        .snapshots();

    //
    // getAllRequests(requestProvider, userProfile);
    // requestProvider.getAllReuests(userProfile);

    super.initState();
  }

  // getAllRequests(
  //     RequestProvider requestProvider, UserProfile userProfile) async {
  //   await requestProvider.getAllReuests(userProfile);
  //   //requestProvider.storeEmergencyRequests();
  // }

  @override
  Widget build(BuildContext context) {
    final ssController = ScreenshotController();
    //final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.red.withOpacity(0.8),
        //   title: Text("Blood Requests"),
        // ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 16.0),
              child: Text(
                "Requests",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

            FrequencyTabs(
                tabs: const [
                  SizedBox(child: Center(child: Text("Your Requests"))),
                  SizedBox(child: Center(child: Text("My Type"))),
                  SizedBox(child: Center(child: Text("Emergency"))),
                  SizedBox(child: Center(child: Text("Others")))
                ],
                controller: _tabController,
                tags: const []),

            Expanded(
                child: TabBarView(
              controller: _tabController,
              children: [
                UserBloodRequestsScreen(bloodReqByUsers: _bloodReqByUsers),
                BloodTypeScreen(
                  controller: ssController,
                ),
                EmergencyScreen(
                  controller: ssController,
                ),
                AllRequestsScreeen(
                  controller: ssController,
                ),
              ],
            ))

            //RequestBloodCard()
          ],
        ),
      ),
    );
  }
}

class FrequencyTabs extends StatelessWidget {
  final TabController controller;
  final List tags;
  final List<Widget> tabs;
  const FrequencyTabs(
      {super.key,
      required this.controller,
      required this.tags,
      required this.tabs});

  @override
  Widget build(BuildContext context) {
    return Container(
        //margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(2),
        height: 50,
        width: size.width,
        // decoration: BoxDecoration(
        //     color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: TabBar(
              controller: controller,
              // indicator: BoxDecoration(
              //     color: Colors.red.withOpacity(0.8),
              //     borderRadius: BorderRadius.circular(12),
              //     border: Border.all(color: Colors.redAccent.withOpacity(0.5))),
              isScrollable: true,
              indicatorWeight: 3.5,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.black,
              tabs: tabs),
        ));
  }
}
