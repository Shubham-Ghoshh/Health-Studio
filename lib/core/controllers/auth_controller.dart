import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/request.dart';
import 'package:health_studio_user/ui/screens/home_screen.dart';
import 'package:health_studio_user/ui/widgets/loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  String? mobile;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isValid = false;

  void login() async {
    Utility.showLoadingDialog();
    Map<String, dynamic> body = {
      "mobile": mobile,
      "password": password,
    };
    Map<String, dynamic> response = await postRequest("login", body);
    Utility.closeDialog();
    if (response["error"] != 0) {
      Get.rawSnackbar(message: response["message"]);
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("auth_key", response["details"]?[0]?["auth_key"]);
      Get.offAll(() => const HomePage());
    }
  }
}
