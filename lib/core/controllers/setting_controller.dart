import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/models/user.dart';
import 'package:health_studio_user/core/request.dart';
import 'package:health_studio_user/ui/widgets/loader.dart';

class SettingsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getstartenddetails();
    });
  }

  String accountStart = "";
  String accountExpiry = "";

  List<Subscription> getsubscription = [];
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
}
