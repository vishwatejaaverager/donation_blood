import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

class BottomNavProvider with ChangeNotifier {
  int _pageId = 0;
  int get pageId => _pageId;

  setPageId(int id) {
    _pageId = id;
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }
}
