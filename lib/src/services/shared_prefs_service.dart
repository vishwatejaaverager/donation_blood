import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  late SharedPreferences preferences;

  Future<SharedPrefsService> init() async {
    preferences = await SharedPreferences.getInstance();
    return this;
  }
}
