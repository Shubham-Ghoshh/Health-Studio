import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/models/package.dart';
import 'package:health_studio_user/core/models/user_dashboard.dart';
import 'package:health_studio_user/core/request.dart';
import 'package:health_studio_user/ui/screens/select_menu.dart';
import 'package:health_studio_user/ui/widgets/loader.dart';

class UserDashboardController extends GetxController {
  UserDashboard? userDashboard;
  PackageDetail? packageDetail;
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getUserDashboard();
    });
  }

  void getUserDashboard() async {
    Utility.showLoadingDialog();
    Map<String, dynamic> response = await getRequest("user/dashboard");
    Utility.closeDialog();
    if (response["error"] != 0) {
      Get.rawSnackbar(message: response["message"]);
    } else {
      userDashboard = UserDashboard.fromJson(response["details"]);
      update();
    }
  }

  void getPackageDetails(String planId, String? packageId) async {
    Utility.showLoadingDialog();
    Map<String, dynamic> response =
        await getRequest("package-detail/$planId/$packageId");
    Utility.closeDialog();
    if (response["error"] != 0) {
      Get.rawSnackbar(message: response["message"]);
    } else {
      packageDetail =
          PackageDetail.fromJson(response["details"]["package"].first);
      update();
      Get.to(() => const SelectMenuPage());
    }
  }
}
