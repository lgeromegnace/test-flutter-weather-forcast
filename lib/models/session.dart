
import 'package:flutter/cupertino.dart';
import 'package:weather/models/user.dart';

class Session extends ChangeNotifier {
  bool _isConnected = false;
  User? _user;

  get isConnected => _isConnected;
  get user => _user;

  setUser(User user){
    _user = user;
    _isConnected = true;
    notifyListeners();
  }
  setIsConnected(bool connected) {
    if(_user != null) {
      _isConnected = connected;
      notifyListeners();
    }
  }
}