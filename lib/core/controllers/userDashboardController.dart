import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/plan_controller.dart';
import 'package:health_studio_user/core/models/meal.dart';
import 'package:health_studio_user/core/models/package.dart';
import 'package:health_studio_user/core/models/user_dashboard.dart';
import 'package:health_studio_user/core/request.dart';
import 'package:health_studio_user/ui/screens/gridview.dart';
import 'package:health_studio_user/ui/screens/payment_screen.dart';
import 'package:health_studio_user/ui/screens/select_menu.dart';
import 'package:health_studio_user/ui/widgets/loader.dart';

class UserDashboardController extends GetxController {
  UserDashboard? userDashboard;
  PackageDetail? packageDetail;
  List<Meal> meals = [];
  String price = "";
  DashboardItem? selectedDashboardItem;
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

  void getPackageDetails(
      String planId, String? packageId, String date, DashboardItem item) async {
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
      getMealsByDate(date);
      Get.to(() => SelectMenuPage(
            date: date,
            item: item,
          ));
    }
  }

  void getMenuByTypeAndDate(
      String type, String date, DashboardItem item) async {
    Utility.showLoadingDialog();
    Map<String, dynamic> response = await getRequest("choose/$type/$date");
    Utility.closeDialog();
    if (response["error"] != 0) {
      Get.rawSnackbar(message: response["message"]);
    } else {
      meals = List<Meal>.from(
          response["details"].map((e) => Meal.fromJson(e)).toList());
      Get.to(() => ChooseMeal(item: item));
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

  void getMealPaymentLink(Meal meal, DashboardItem item) async {
    Utility.showLoadingDialog();
    Map<String, dynamic> body = {
      "meal_id": meal.id,
      "amount": price,
      "date": item.dateRequested,
      "carbs": carbValue,
      "proteins": proteinValue,
      "carb_price": Get.find<PlanController>().planDetail!.carbPrice,
      "protein_price": Get.find<PlanController>().planDetail!.proteinPrice
    };
    Map<String, dynamic> response =
        await postRequest("get-meal-payment-link", body);
    Utility.closeDialog();
    if (response["error"] != 0) {
      Get.rawSnackbar(message: response["message"]);
    } else {
      Get.to(() => PaymentScreen(
            url: response["details"]["url"],
            amount: int.parse(price),
            isMeal: true,
          ));
    }
  }

  void getMealsByDate(String date) async {
    Utility.showLoadingDialog();
    Map<String, dynamic> response = await getRequest("meals/$date");
    Utility.closeDialog();
    if (response["error"] != 0) {
      Get.rawSnackbar(message: response["message"]);
    } else {}
  }
}
