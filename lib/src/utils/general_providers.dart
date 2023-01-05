
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
  ChangeNotifierProvider<SearchProvider>(
    create: (_) => SearchProvider(),
  ),
  ChangeNotifierProvider<BottomNavProvider>(create: (_) => BottomNavProvider()),
  ChangeNotifierProvider<ProfileProvider>(create: (_) => ProfileProvider()),
  ChangeNotifierProvider<ConnectivityRepo>(create: (_) => ConnectivityRepo()),
];
