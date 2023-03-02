import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:donation_blood/src/features/profile_det/provider/profile_provider.dart';
import 'package:donation_blood/src/features/shared/domain/models/user_profile_model.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../bottom_nav/screens/donate_blood/providers/requests_provider.dart';
import '../../../../../../bottom_nav/screens/donate_blood/screens/donate_blood_screen.dart';
import '../../../../../../connectivity/connectivity_repo.dart';
import '../../../../../utils/routes.dart';
import '../provider/bottom_nav_provider.dart';
import 'home/screens/home_screen.dart';
import 'notification/screens/notification_screen.dart';

class BottomNavScreen extends StatefulWidget {
  static const id = AppRoutes.bottomScreen;
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  late ConnectivityRepo connect;
  StreamSubscription<ConnectivityResult>? connectivitySubscription;
  // Color currentColor = Colors.white;
  // late ConnectivityRepo connectivityRepo;
  // late BottomNavProvider bottomNavProvider;
  late UserProfile userProfile;
  

  @override
  void initState() {
    //Provider.of<ProfileProvider>(context, listen: false).getUserInfo();
    userProfile =
        Provider.of<ProfileProvider>(context, listen: false).userProfile!;
    Provider.of<RequestProvider>(context, listen: false)
        .getTokenAndSave(userProfile.userId!);

    connect = Provider.of<ConnectivityRepo>(context, listen: false);
    connect.initConnectivity();
    connectivitySubscription = connect.connectivity.onConnectivityChanged
        .listen(connect.updateConnectionStatus);
    //   bottomNavProvider = Provider.of<BottomNavProvider>(context, listen: false);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //  bottomNavProvider = Provider.of<BottomNavProvider>(context, listen: false);
    connect = Provider.of<ConnectivityRepo>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPages = [
      const HomeScreen(),
      // const DonarsScreen(),
      const DonateBloodScreen(),
      const NotificationScreen(),
      const ProfileScreen(),
    ];
    return Consumer<BottomNavProvider>(builder: ((_, __, ___) {
      return Scaffold(
        body: bottomPages[__.pageId],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: __.pageId,
            backgroundColor: Colors.white,
            elevation: 10,
            onTap: (value) {
              __.setPageId(value);
            },
            items: [
              BottomNavigationBarItem(
                  label: "",
                  icon: SizedBox(
                    height: 30,
                    child: Image.asset(
                      'assets/bottom_nav/menu.png',
                      scale: __.pageId == 0 ? 20 : 25,
                      color: __.pageId == 0 ? Colors.red : Colors.grey,
                    ),
                  )),
              // BottomNavigationBarItem(
              //     label: "",
              //     icon: Image.asset(
              //       'assets/bottom_nav/search.png',
              //       scale: __.pageId == 1 ? 20 : 25,
              //       color: __.pageId == 1 ? Colors.red : Colors.grey,
              //     )),
              BottomNavigationBarItem(
                  label: "",
                  icon: Image.asset(
                    'assets/bottom_nav/donation.png',
                    scale: __.pageId == 1 ? 20 : 25,
                    color: __.pageId == 1 ? Colors.red : Colors.grey,
                  )),
              BottomNavigationBarItem(
                  label: "",
                  icon: Image.asset(
                    'assets/bottom_nav/notification.png',
                    scale: __.pageId == 2 ? 20 : 25,
                    color: __.pageId == 2 ? Colors.red : Colors.grey,
                  )),
              BottomNavigationBarItem(
                  label: "",
                  icon: Image.asset(
                    'assets/bottom_nav/user.png',
                    scale: __.pageId == 3 ? 20 : 25,
                    color: __.pageId == 3 ? Colors.red : Colors.grey,
                  )),
            ]),
      );
    }));
  }
}
