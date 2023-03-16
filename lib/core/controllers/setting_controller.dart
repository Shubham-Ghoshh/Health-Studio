import 'dart:async';
import 'dart:developer';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/auth_controller.dart';
import 'package:health_studio_user/core/controllers/bmr_calculator_controller.dart';
import 'package:health_studio_user/core/controllers/firebase_controller.dart';
import 'package:health_studio_user/core/controllers/order_controller.dart';
import 'package:health_studio_user/core/controllers/plan_controller.dart';
import 'package:health_studio_user/core/models/notificationlisting.dart';
import 'package:health_studio_user/core/models/user.dart';
import 'package:health_studio_user/core/request.dart';
import 'package:health_studio_user/ui/screens/home_screen.dart';
import 'package:health_studio_user/ui/screens/notification.dart';
import 'package:health_studio_user/ui/widgets/loader.dart';
import 'package:health_studio_user/utils/constants.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:version/version.dart';

class SettingsController extends GetxController {
  PackageInfo? packageInfo;

  void getAppVersion() async {
    packageInfo = await PackageInfo.fromPlatform();
    update();
    Get.put(FirebaseController(), permanent: true).getToken();

    getVersion();
    getUserDetails();
  }

  String accountStart = "";
  String accountExpiry = "";
  String? surveyname;
  String? from;
  String? surveylink;
  String? changePasswordLink;
  String? authkey;
  String termsEn = "";
  String termsAr = "";

  List<Subscription> subscription = [];
  UserDetails? userDetails;
  List<NotificationsListing> notifications = [];

  void getUserSubscription() async {
    Map<String, dynamic> response = await getRequest("user/subscribe");

    if (response["error"] != 0) {
      // Get.rawSnackbar(message: response["message"] ?? "");
      accountStart = "";
      accountExpiry = "";
    } else {
      subscription = response["details"] == null
          ? <Subscription>[]
          : List<Subscription>.from(response["details"]
              .map((e) => Subscription.fromJson(e))
              .toList());

      update();

      if (subscription.isNotEmpty) {
        Get.put(OrderController()).orderReference =
            subscription.first.orderReference;
        await Get.put(OrderController()).getOrderDetails(navigate: false);
        if (Get.find<OrderController>().orderDetails != null) {
          Get.put(PlanController()).getPlanDetail(
              Get.find<OrderController>().orderDetails!.categoryId,
              navigate: false);
        }
      }
    }
  }

  getChangePasswordLink() async {
    Utility.showLoadingDialog();
    Map<String, dynamic> response = await getRequest("settingmenu");
    Utility.closeDialog();
    if (response["error"] != 0) {
      Get.rawSnackbar(message: response["message"] ?? "");
    } else {
      for (int i = 0; i < (response["details"]?.length ?? 0); i++) {
        if (response["details"]![i]["title_en"] == "Change Password") {
          changePasswordLink = response["details"]![i]["link"];
          update();
          try {
            await launchUrlString(changePasswordLink ?? "",
                mode: LaunchMode.platformDefault);
          } catch (e) {
            log(e.toString());
          }
        }
      }
    }
  }

  Future<void> generatesurveylink() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    authkey = prefs.getString('auth_key');

    surveyname = userDetails?.firstName?.split(" ").first;
    surveylink =
        "https://healthstudiokw.com/api/survey2.php?${surveyname != null ? "name=$surveyname&auth=$authkey" : ""}";
    update();
    print("SURVEY LINK $surveylink");
    try {
      await launchUrlString(surveylink ?? "", mode: LaunchMode.platformDefault);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getUserDetails() async {
    Map<String, dynamic> response = await getRequest("user/detail");
    if (response["error"] != 0) {
      Get.rawSnackbar(message: response["message"] ?? "");
    } else {
      userDetails = response["details"].isNotEmpty
          ? UserDetails.fromJson(response["details"].first)
          : null;

      if (userDetails?.totalCalories != "" &&
          userDetails?.totalCalories != null) {
        BMRController bmrController = Get.put(BMRController());
        bmrController.weight = userDetails?.weight ?? "";
        bmrController.height = userDetails?.height ?? "";
        bmrController.carbs = double.parse(userDetails?.carbs ?? "0.0");
        bmrController.proteins = double.parse(userDetails?.proteins ?? "0.0");
        bmrController.fats = double.parse(userDetails?.fats ?? "0.0");
        bmrController.bmr = double.parse(userDetails?.totalCalories ?? "0.0");
      }

      update();
    }
  }

  Future getnotifications() async {
    Utility.showLoadingDialog();
    Map<String, dynamic> response = await getRequest("messages");
    Utility.closeDialog();
    if (response["error"] != 0) {
      Get.rawSnackbar(message: response["message"] ?? "");
    } else {
      notifications = response["details"] == null
          ? <NotificationsListing>[]
          : List<NotificationsListing>.from(response["details"]
              .map((e) => NotificationsListing.fromJson(e))
              .toList());
      update();
      Get.to(() => const NotificationScreen());
      return notifications;
    }
  }

  launchInstagram() async {
    var webUrl =
        "https://www.instagram.com/healthstudiokw/?utm_medium=copy_link";

    try {
      await launchUrl(Uri.parse(webUrl), mode: LaunchMode.platformDefault);
    } catch (e) {
      log(e.toString());
    }
  }

  launchFacebook() async {
    var webUrl = "https://www.facebook.com/healthstudiokw";

    try {
      await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
    } catch (e) {
      log(e.toString());
    }
  }

  rateApp() async {
    var webUrl = Platform.isAndroid
        ? androidLink
        : Platform.isIOS
            ? appleLink
            : "";

    try {
      await launchUrlString(webUrl, mode: LaunchMode.platformDefault);
    } catch (e) {
      log(e.toString());
    }
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? code = prefs.getString("apple-id");
    String? email = prefs.getString("apple-email");
    String? name = prefs.getString("apple-name");

    prefs.clear();

    Get.find<OrderController>().orderDetails = null;
    Get.find<OrderController>().update();
    Get.offAll(() => const HomePage());
    Get.find<AuthController>().isLoggedIn = false;
    prefs.setString("apple-id", code ?? "");

    prefs.setString("apple-email", email ?? "");
    prefs.setString("apple-name", name ?? "");
  }

  void openMailApp() async {
    var url = "mailto:support@healthstudiokw.com";
    try {
      await launchUrlString(url, mode: LaunchMode.platformDefault);
    } catch (e) {
      log(e.toString());
    }
  }

  void getVersion() async {
    Map<String, dynamic> response = await getRequest("commons");

    String version = Platform.isIOS
        ? response["details"][9]["common_value"]
        : response["details"][10]["common_value"];
    termsEn = response["details"][11]["common_value"];
    termsAr = response["details"][13]["common_value"];

    String forceUpdate = response["details"][16]["common_value"];

    if (Version.parse(version) > Version.parse(packageInfo?.version ?? "")) {
      showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: forceUpdate == "1" ? false : true,
          builder: (context) {
            return AlertDialog(
              title: const Text("Update Available"),
              content: const Text(
                  "New update is available! Please update for better experience."),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Okay'),
                  onPressed: () {
                    if (forceUpdate == "0") Get.back();
                    rateApp();
                  },
                ),
                Visibility(
                  visible: forceUpdate == "1" ? false : true,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Cancel'),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ],
            );
          });
    }
  }
}
