import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/apn_controller.dart';
import 'dart:io' show Platform;
import 'package:health_studio_user/core/controllers/firebase_controller.dart';
import 'package:health_studio_user/core/controllers/setting_controller.dart';
import 'package:health_studio_user/core/request.dart';
import 'package:health_studio_user/ui/screens/authentication/login_screen.dart';
import 'package:health_studio_user/ui/screens/authentication/sign_up_screen.dart';
import 'package:health_studio_user/ui/screens/home_screen.dart';
import 'package:health_studio_user/ui/widgets/loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthController extends GetxController {
  String? mobile;
  String? password;
  String? name;
  String? email;
  String? age;
  String? gender;
  String? socialid;
  String? type;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  bool isValid = false;
  bool isLoggedIn = false;
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/userinfo.profile',
      'openid',
    ],
  );
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkLogin();
    });
  }

  void addDevice(String token) async {
    Map<String, dynamic> body = {};
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      body = {
        "token": token,
        "model": iosInfo.model,
        "version": Get.find<SettingsController>().packageInfo?.version ?? "",
        "identifier": "com.healthstudio.app",
        "platform": "iOS",
        "timezone": DateTime.now().timeZoneName,
      };
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      body = {
        "token": token,
        "model": androidInfo.model,
        "version": Get.find<SettingsController>().packageInfo?.version ?? "",
        "identifier": "com.healthstudio.app",
        "platform": "android",
        "timezone": DateTime.now().timeZoneName,
      };
    }

    Map<String, dynamic> response = await postRequest("add/device", body);
    // if (response["error"] != 0) {
    //   Get.rawSnackbar(message: response["message"]);
    // }
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
      isLoggedIn = true;
      update();

      Get.put(SettingsController()).getUserDetails();
      Get.put(SettingsController()).getUserSubscription();
      if (Platform.isIOS) {
        Get.put(APNController()).getToken();
      } else {
        Get.put(FirebaseController(), permanent: true).getToken();
      }
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
      Get.rawSnackbar(message: "Sign Up Successful! Please login.");
    }
  }

  void registersocial({Function()? onSuccess}) async {
    Utility.showLoadingDialog();
    Map<String, dynamic> body = {
      "mobile": mobile,
      "password": password,
      "name": name,
      "email": email,
      "age": age,
      "gender": gender,
      "social_id": socialid,
      "type": type,
    };
    Map<String, dynamic> response = await postRequest("register/social", body);
    Utility.closeDialog();
    if (response["error"] != 0) {
      Get.rawSnackbar(message: response["message"]);
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("auth_key", response["details"]?[0]?["auth_key"]);
      onSuccess == null ? Get.offAll(() => const LoginPage()) : onSuccess();
      Get.rawSnackbar(message: "Sign Up Successful! Please login.");
    }
  }

  void loginWithSocialAccount(String type, {Function()? onSuccess}) async {
    Utility.showLoadingDialog();

    switch (type) {
      case "google":
        {
          await disconnectGoogleAccount();
          final userinfo = await googleSignIn.signIn();
          if (userinfo == null) {
            Utility.closeDialog();
            Get.rawSnackbar(message: "Sign In Failed");
          } else {
            email = userinfo.email;
            name = userinfo.displayName;
            socialid = userinfo.id;
            type = "GOOGLE";
            bool accountExists = await loginSocialAPI();
            if (!accountExists) {
              Utility.closeDialog();
              Get.to(() => RegistrationPage(onSuccess: onSuccess));
            }
          }
          break;
        }
      case "apple":
        {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          try {
            AuthorizationCredentialAppleID credential =
                await SignInWithApple.getAppleIDCredential(
              scopes: [
                AppleIDAuthorizationScopes.email,
                AppleIDAuthorizationScopes.fullName,
              ],
            );
            print("CREDENTIAL!!! $credential");
            print("EMAIL");
            print(credential.email);

            if (credential.email != null) {
              print("EMAIL IS NOT NULL");
              prefs.setString("apple-id", credential.authorizationCode);
              prefs.setString("apple-email", credential.email ?? "");
              prefs.setString("apple-name",
                  "${credential.givenName ?? ""} ${credential.familyName ?? ""}");
              email = credential.email;
              name =
                  "${credential.givenName ?? ""} ${credential.familyName ?? ""}";
            } else {
              email = prefs.getString("apple-email");
              name = prefs.getString("apple-name");
            }

            socialid = credential.authorizationCode;
            type = "APPLE";
            bool accountExists = await loginSocialAPI();
            if (!accountExists) {
              Utility.closeDialog();
              Get.to(() => RegistrationPage(onSuccess: onSuccess));
            }
          } catch (e) {
            Utility.closeDialog();
            Get.rawSnackbar(message: "Apple Sign In Failed $e");
          }
          break;
        }
      default:
        Utility.closeDialog();
        break;
    }
  }

  Future<bool> loginSocialAPI({Function()? onSuccess}) async {
    Map<String, dynamic> body = {"email": email};
    Map<String, dynamic> response = await postRequest("login/social", body);
    if (response["details"][0]["continue_register"] == "0") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("auth_key", response["details"]?[0]?["auth_key"]);
      onSuccess == null ? Get.offAll(() => const HomePage()) : onSuccess();
      isLoggedIn = true;
      update();

      Get.put(SettingsController()).getUserDetails();
      Get.put(SettingsController()).getUserSubscription();
      return true;
    } else {
      return false;
    }
  }

  Future<void> disconnectGoogleAccount() async {
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.disconnect();
      await googleSignIn.signOut();
    }
  }
}
