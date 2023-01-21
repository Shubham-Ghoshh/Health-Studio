import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  bool loggedIn = false;
  PackageInfo? packageInfo;
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        checkIsUserLoggedIn();
        getAppVersion();
      },
    );
  }

  void checkIsUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("auth_key");
    if (value != null) {
      loggedIn = true;
      update();
    }
  }

  void getAppVersion() async {
    packageInfo = await PackageInfo.fromPlatform();
  }
}
