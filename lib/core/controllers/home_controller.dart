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
  DateTime selectedDate = DateTime.now();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getPlans();
      getMenuForDate();
    });
  }

  void getPlans() async {
    Utility.showLoadingDialog();
    Map<String, dynamic> response = await getRequest("plans");
    Utility.closeDialog();

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

  void getMenuForDate() async {
    Utility.showLoadingDialog();
    Map<String, dynamic> response = await getRequest(
        "menu/random/${DateFormat('dd-MM-yyyy').format(selectedDate)}");
    Utility.closeDialog();
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
