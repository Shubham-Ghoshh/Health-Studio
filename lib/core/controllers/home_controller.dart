import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:health_studio_user/core/models/plan.dart';
import 'package:health_studio_user/core/models/menu.dart';
import 'package:health_studio_user/core/request.dart';
import 'package:health_studio_user/ui/widgets/loader.dart';

class HomeController extends GetxController {
  List<Plan> plans = [];
  List<Menu> menu = [];
  DateTime selectedDate = DateTime.now().weekday == 5
      ? DateTime.now().add(const Duration(days: 1))
      : DateTime.now();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getPlans(showLoader: false);
      getMenuForDate(showLoader: false);
    });
  }

  void getPlans({bool showLoader = true}) async {
    if (showLoader) Utility.showLoadingDialog();
    Map<String, dynamic> response = await getRequest("plans");
    if (showLoader) Utility.closeDialog();

    if (response["error"] != 0) {
      Get.rawSnackbar(message: response["message"] ?? "");
    } else {
      plans = response["details"] == null
          ? <Plan>[]
          : List<Plan>.from(
              response["details"].map((e) => Plan.fromJson(e)).toList());
      update();
    }
  }

  void getMenuForDate({bool showLoader = false}) async {
    if (showLoader) Utility.showLoadingDialog();
    Map<String, dynamic> response = await getRequest(
        "menu/random/${DateFormat('dd-MM-yyyy').format(selectedDate)}");
    if (showLoader) Utility.closeDialog();
    if (response["error"] != 0) {
      Get.rawSnackbar(message: response["message"] ?? "");
    } else {
      menu = response["details"] == null
          ? <Menu>[]
          : List<Menu>.from(
              response["details"].map((e) => Menu.fromJson(e)).toList());
      update();
    }
  }

  void selectDate(DateTime date) {
    selectedDate = date;
    update();
    getMenuForDate();
  }
}
