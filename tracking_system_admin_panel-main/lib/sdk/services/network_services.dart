import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
// import '../../sdk/sdk.dart';
class NetworkServices extends GetxController{
  static NetworkServices get to => Get.find();

  final RxBool _isConnected = false.obs;
  // final UserApi _userApi = UserApi();

  bool get isConnected => _isConnected.value;


  final Connectivity _connectivity = Connectivity();

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;


  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  _updateConnectionStatus(ConnectivityResult result){
    if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){
      _isConnected.value = true;
    }
    else {
      _isConnected.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}