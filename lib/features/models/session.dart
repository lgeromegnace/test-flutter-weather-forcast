
import 'package:flutter/cupertino.dart';

class Session extends ChangeNotifier {
  bool isConnected = false;

  setIsConnected(bool connected) {
    isConnected = connected;
    notifyListeners();
  }
}