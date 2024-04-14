import 'package:flutter/foundation.dart';

class GameNotificationProvider with ChangeNotifier {
  bool _isNewGameAdded = false;

  bool get isNewGameAdded => _isNewGameAdded;

  void setNewGameAdded(bool value) {
    _isNewGameAdded = value;
    notifyListeners();
  }
}
