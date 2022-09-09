
import 'package:flutter/cupertino.dart';

class Session extends ChangeNotifier {
  bool isConnected = true;

  setIsConnected(bool connected) {
    isConnected = connected;
    notifyListeners();
  }
}