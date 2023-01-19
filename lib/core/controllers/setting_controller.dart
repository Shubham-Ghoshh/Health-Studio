import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/models/notificationlisting.dart';
import 'package:health_studio_user/core/models/user.dart';
import 'package:health_studio_user/core/request.dart';
import 'package:health_studio_user/ui/widgets/loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getstartenddetails();
      generatesurveylink();
      getnotifications();
    });
  }

  String accountStart = "";
  String accountExpiry = "";
  String? surveyname;
  String? from;
  String? surveylink;
  String? authkey;

  List<Subscription> getsubscription = [];
  List<UserDetails> getuserdetails = [];
  List<NotificationsListing> notifications = [];
  void getstartenddetails() async {
    Utility.showLoadingDialog();
    Map<String, dynamic> response = await getRequest("user/subscribe");
    Utility.closeDialog();
    if (response["error"] != 0) {
      Get.rawSnackbar(message: response["message"] ?? "");
    } else {
      getsubscription = response["details"] == null
          ? <Subscription>[]
          : List<Subscription>.from(response["details"]
              .map((e) => Subscription.fromJson(e))
              .toList());

      update();
    }
  }

  Future<void> generatesurveylink() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    authkey = prefs.getString('auth_key');
    await getUserDetails();

    (getuserdetails.isNotEmpty) ? surveyname = getuserdetails[0].firstName : "";
    surveylink =
        "https://healthstudiokw.com/api/survey.php?name=$surveyname&auth=$authkey";
  }

  Future<void> getUserDetails() async {
    Utility.showLoadingDialog();
    Map<String, dynamic> response = await getRequest("user/detail");
    Utility.closeDialog();
    if (response["error"] != 0) {
      Get.rawSnackbar(message: response["message"] ?? "");
    } else {
      getuserdetails = response["details"] == null
          ? <UserDetails>[]
          : List<UserDetails>.from(
              response["details"].map((e) => UserDetails.fromJson(e)).toList());

      update();
    }
  }

  void getnotifications() async {
    Utility.showLoadingDialog();
    Map<String, dynamic> response = await getRequest("user/messages");
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
    }
  }
}
