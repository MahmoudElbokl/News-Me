import 'dart:async';
import 'package:connectivity/connectivity.dart';

class ConnectivityService {
  StreamController<bool> connectionStatusController = StreamController<bool>();

  ConnectivityService() {
    // connectivity Chanaged Steam
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectionStatusController.add(_getStatusFromResult(result));
    });
  }

  bool _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return false;
      case ConnectivityResult.wifi:
        return false;
      case ConnectivityResult.none:
        return true;
      default:
        return true;
    }
  }
}

enum ConnectivityStatus { WiFi, Cellular, Offline }
