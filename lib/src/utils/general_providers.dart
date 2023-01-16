
import 'package:donation_blood/bottom_nav/screens/donate_blood/providers/requests_provider.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/donars/provider/donar_provider.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/notification/provider/responses_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../connectivity/connectivity_repo.dart';
import '../features/authentication/data/providers/login_provider.dart';
import '../features/profile_det/provider/profile_provider.dart';
import '../features/profile_det/provider/search_provider.dart';
import '../features/shared/presentation/bottom_nav/provider/bottom_nav_provider.dart';

List<SingleChildWidget> generalProviders = [
  ChangeNotifierProvider<LoginProvider>(
    create: (_) => LoginProvider(),
  ),
  ChangeNotifierProvider<RequestProvider>(
    create: (_) => RequestProvider(),
  ),
  ChangeNotifierProvider<SearchProvider>(
    create: (_) => SearchProvider(),
  ),
  ChangeNotifierProvider<BottomNavProvider>(create: (_) => BottomNavProvider()),
  ChangeNotifierProvider<ProfileProvider>(create: (_) => ProfileProvider()),
  ChangeNotifierProvider<ConnectivityRepo>(create: (_) => ConnectivityRepo()),
  ChangeNotifierProvider<DonarProvider>(create: (_) => DonarProvider()),
   ChangeNotifierProvider<ResponseProvider>(create: (_) => ResponseProvider()),
];
