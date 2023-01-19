import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/request.dart';
import 'package:health_studio_user/ui/screens/authentication/login_screen.dart';
import 'package:health_studio_user/ui/screens/authentication/sign_up_screen.dart';
import 'package:health_studio_user/ui/screens/home_screen.dart';
import 'package:health_studio_user/ui/widgets/loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  String? mobile;
  String? password;
  String? name;
  String? email;
  String? age;
  String? gender;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isValid = false;
  bool isLoggedIn = false;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkLogin();
    });
  }

  void checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authKey = prefs.getString("auth_key");
    isLoggedIn = authKey != null;
    update();
  }

  void login({Function()? onSuccess}) async {
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
      onSuccess == null ? Get.offAll(() => const HomePage()) : onSuccess();
    }
  }

  void signUp({Function()? onSuccess}) async {
    Utility.showLoadingDialog();
    Map<String, dynamic> body = {
      "mobile": mobile,
      "password": password,
      "name": name,
      "email": email,
      "age": age,
      "gender": gender,
    };
    Map<String, dynamic> response = await postRequest("register/", body);
    Utility.closeDialog();
    if (response["error"] != 0) {
      Get.rawSnackbar(message: response["message"]);
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("auth_key", response["details"]?[0]?["auth_key"]);
      onSuccess == null ? Get.offAll(() => const LoginPage()) : onSuccess();
    }
  }
}
