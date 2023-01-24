import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/models/meal.dart';
import 'package:health_studio_user/core/models/package.dart';
import 'package:health_studio_user/core/models/user_dashboard.dart';
import 'package:health_studio_user/core/request.dart';
import 'package:health_studio_user/ui/screens/gridview.dart';
import 'package:health_studio_user/ui/screens/select_menu.dart';
import 'package:health_studio_user/ui/widgets/loader.dart';

class UserDashboardController extends GetxController {
  UserDashboard? userDashboard;
  PackageDetail? packageDetail;
  List<Meal> meals = [];
  String price = "";

  String carbValue = "0";
  String proteinValue = "0";

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

  void getPackageDetails(String planId, String? packageId, String date) async {
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
      Get.to(() => SelectMenuPage(
            date: date,
          ));
    }
  }

  void getMenuByTypeAndDate(String type, String date) async {
    Utility.showLoadingDialog();
    Map<String, dynamic> response = await getRequest("choose/$type/$date");
    Utility.closeDialog();
    if (response["error"] != 0) {
      Get.rawSnackbar(message: response["message"]);
    } else {
      meals = List<Meal>.from(
          response["details"].map((e) => Meal.fromJson(e)).toList());
      Get.to(() => const ChooseMeal());
      update();
    }
  }

  void calculateMealPrice(String carbPerUnit, String proteinPerUnit) async {
    price =
        (((int.tryParse(carbValue) ?? 0) * (int.tryParse(carbPerUnit) ?? 0)) +
                ((int.tryParse(proteinValue) ?? 0) *
                    (int.tryParse(proteinPerUnit) ?? 0)))
            .toString();
    update();
  }
}
