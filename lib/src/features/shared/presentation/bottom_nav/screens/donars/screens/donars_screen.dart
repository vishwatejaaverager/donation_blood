import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/donars/provider/donar_provider.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/donars/screens/filtered_req_screens/all_donars_screen.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/donars/screens/filtered_req_screens/my_type_donars_screen.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/donars/screens/filtered_req_screens/nearby_donars_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../bottom_nav/screens/donate_blood/screens/donate_blood_screen.dart';
import '../../../../../../../utils/routes.dart';
import '../../../../../../profile_det/provider/profile_provider.dart';
import '../../../../../domain/models/user_profile_model.dart';

class DonarsScreen extends StatefulWidget {
  static const id = AppRoutes.donarsScreen;
  const DonarsScreen({super.key});

  @override
  State<DonarsScreen> createState() => _DonarsScreenState();
}

class _DonarsScreenState extends State<DonarsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late DonarProvider _donarProvider;
  late UserProfile actualUserProfile;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    _donarProvider = Provider.of<DonarProvider>(context, listen: false);
     actualUserProfile =
        Provider.of<ProfileProvider>(context, listen: false).userProfile!;
    _donarProvider.getAllDonars(actualUserProfile);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _donarProvider = Provider.of<DonarProvider>(context, listen: false);
    super.didChangeDependencies();
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
              "Donars",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          FrequencyTabs(
              tabs: const [
                SizedBox(child: Center(child: Text("My Type"))),
                SizedBox(child: Center(child: Text("Nearby"))),
                SizedBox(child: Center(child: Text("All")))
              ],
              controller: _tabController,
              tags: const []),
          Expanded(
              child: TabBarView(
            controller: _tabController,
            children: const [
              MyTypeDonarsScreen(),
              NearbyDonarsScreen(),
              AllDonarsScreen()
            ],
          ))
        ],
      ),
    ));
  }
}
