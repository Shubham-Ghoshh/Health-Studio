import 'dart:developer';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/auth_controller.dart';
import 'package:health_studio_user/core/controllers/order_controller.dart';
import 'package:health_studio_user/core/controllers/plan_controller.dart';
import 'package:health_studio_user/core/models/notificationlisting.dart';
import 'package:health_studio_user/core/models/user.dart';
import 'package:health_studio_user/core/request.dart';
import 'package:health_studio_user/ui/screens/home_screen.dart';
import 'package:health_studio_user/ui/screens/notification.dart';
import 'package:health_studio_user/ui/widgets/loader.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (Get.find<AuthController>().isLoggedIn) {
        getUserDetails();
        getUserSubscription();
      }

      getAppVersion();
    });
  }

  PackageInfo? packageInfo;

  void getAppVersion() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  String accountStart = "";
  String accountExpiry = "";
  String? surveyname;
  String? from;
  String? surveylink;
  String? changePasswordLink;
  String? authkey;

  List<Subscription> subscription = [];
  UserDetails? userDetails;
  List<NotificationsListing> notifications = [];

  void getUserSubscription() async {
    Utility.showLoadingDialog();
    Map<String, dynamic> response = await getRequest("user/subscribe");
    Utility.closeDialog();
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

    (userDetails != null) ? surveyname = userDetails!.firstName : "";
    surveylink =
        "https://healthstudiokw.com/api/survey.php?name=$surveyname&auth=$authkey";
    update();
    try {
      await launchUrlString(surveylink ?? "", mode: LaunchMode.platformDefault);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getUserDetails() async {
    Utility.showLoadingDialog();
    Map<String, dynamic> response = await getRequest("user/detail");
    Utility.closeDialog();
    if (response["error"] != 0) {
      Get.rawSnackbar(message: response["message"] ?? "");
    } else {
      userDetails = response["details"].isNotEmpty
          ? UserDetails.fromJson(response["details"].first)
          : null;

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
    var webUrl = "https://www.instagram.com/healthstudiokw";

    try {
      await launchUrl(Uri.parse(webUrl), mode: LaunchMode.platformDefault);
    } catch (e) {
      log(e.toString());
    }
  }

  launchFacebook() async {
    var webUrl = "https://m.facebook.com/healthstudiokw";

    try {
      await launchUrl(Uri.parse(webUrl), mode: LaunchMode.platformDefault);
    } catch (e) {
      log(e.toString());
    }
  }

  rateAppAndroid() async {
    var webUrl = Platform.isAndroid
        ? "https://play.google.com/store/apps/details?id=com.healthstudio.app&gl=US&pli=1"
        : Platform.isIOS
            ? "https://apps.apple.com/app/id=com.healthstudio.app"
            : "";

    try {
      await launchUrlString(webUrl, mode: LaunchMode.platformDefault);
    } catch (e) {
      log(e.toString());
    }
  }

  rateAppIos() async {
    var webUrl = "https://apps.apple.com/app/id=com.healthstudio.app";

    try {
      await launchUrlString(webUrl, mode: LaunchMode.platformDefault);
    } catch (e) {
      log(e.toString());
    }
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    Get.offAll(() => HomePage());
    Get.find<AuthController>().isLoggedIn = false;
  }

  void openMailApp() async {
    var url = "mailto:support@heatlhstudio.com";
    try {
      await launchUrlString(url, mode: LaunchMode.platformDefault);
    } catch (e) {
      log(e.toString());
    }
  }
}
