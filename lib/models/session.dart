
import 'package:flutter/cupertino.dart';
import 'package:weather/models/user.dart';

class Session extends ChangeNotifier {
  bool isConnected = false;
  User? user;

  setUser(User user){
    this.user = user;
    isConnected = true;
    notifyListeners();
  }
  setIsConnected(bool connected) {
    isConnected = connected;
    notifyListeners();
  }
}