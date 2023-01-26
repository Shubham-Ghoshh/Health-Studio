import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:health_studio_user/core/controllers/plan_controller.dart';
import 'package:health_studio_user/core/models/item.dart';
import 'package:health_studio_user/core/models/meal.dart';
import 'package:health_studio_user/core/models/meal_item.dart';
import 'package:health_studio_user/core/models/package.dart';
import 'package:health_studio_user/core/models/user_dashboard.dart';
import 'package:health_studio_user/core/request.dart';
import 'package:health_studio_user/ui/screens/choose_item.dart';
import 'package:health_studio_user/ui/screens/payment_screen.dart';
import 'package:health_studio_user/ui/screens/select_menu.dart';
import 'package:health_studio_user/ui/widgets/loader.dart';

class UserDashboardController extends GetxController {
  UserDashboard? userDashboard;
  PackageDetail? packageDetail;
  List<Meal> meals = [];
  String price = "";
  String note = "";
  DashboardItem? selectedDashboardItem;
  String carbValue = "0";
  String proteinValue = "0";
  List<MealItem> mealItems = [];

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
      await getMealsByDate(date);
      selectedDashboardItem = item;
      update();
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
      Get.to(() => ChooseMeal(
            item: item,
            type: type,
          ));
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

  void saveMeal(
    Meal meal,
    DashboardItem item,
    String mealType,
  ) {
    int index = mealItems.indexWhere((m) => m.key == mealType);
    if (index != -1) {
      mealItems[index].items.add(
            Item(
              id: meal.id,
              price: price,
              note: note,
              meal: meal,
              carb: carbValue,
              protein: proteinValue,
            ),
          );

      carbValue = "0";
      proteinValue = "0";
      price = "0";

      update();

      Get.back();
      Get.back();
    }
  }

  void getMealPaymentLink(
    // Meal meal,
    DashboardItem item,
    // String mealType,
  ) async {
    Utility.showLoadingDialog();
    int tempPrice = 0;
    int tempCarbValue = 0;
    int tempProteinValue = 0;

    for (int i = 0; i < mealItems.length; i++) {
      for (int j = 0; j < mealItems[i].items.length; j++) {
        tempPrice += int.tryParse(mealItems[i].items[j].price) ?? 0;
        tempCarbValue += int.tryParse(mealItems[i].items[j].carb) ?? 0;
        tempProteinValue += int.tryParse(mealItems[i].items[j].protein) ?? 0;
      }
    }

    Map<String, dynamic> body = {
      "amount": tempPrice.toString(),
      "date": item.dateRequested,
      "carbs": tempCarbValue.toString(),
      "proteins": tempProteinValue.toString(),
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
            amount: tempPrice,
            isMeal: true,
            onFinish: () {
              submitMeals();
            },
          ));
    }
  }

  Future<void> getMealsByDate(String date) async {
    Utility.showLoadingDialog();
    Map<String, dynamic> response = await getRequest("meals/$date");
    Utility.closeDialog();
    if (response["error"] != 0) {
      Get.rawSnackbar(message: response["message"]);
    } else {
      mealItems = List<MealItem>.from(
        response["details"].map(
          (e) => MealItem.fromJson(e),
        ),
      );
      update();
      Get.to(() => SelectMenuPage(
            date: date,
            item: selectedDashboardItem!,
            showSaveButton: mealItems[0].items.isEmpty ||
                mealItems[1].items.isEmpty ||
                mealItems[2].items.isEmpty,
          ));
    }
    return;
  }

  void submitMeals() async {
    print("SUBMIT MEALS");
    // {"meal":"77,109","note_109":"None","note_91":"None","note_77":"None","note_109_1":"None","note_77_0":"None","snack":"91","note_91_2":"None"}
    Utility.showLoadingDialog();
    Map<String, dynamic> body = {};
    for (int i = 0; i < mealItems.length; i++) {
      body.addAll(
          {mealItems[i].key: mealItems[i].items.map((e) => e.id).join(",")});
      for (int j = 0; j < mealItems[i].items.length; j++) {
        body.addAll(
            {"note_${mealItems[i].items[j].id}": mealItems[i].items[j].note});
      }
    }
    mealItems.map((e) => body.addAll({
          e.key: e.items.map((e) => e.id).join(","),
        }));
    print(body);
    Map<String, dynamic> response = await postRequest(
        "meals/${selectedDashboardItem!.dateRequested}", body);
    Utility.closeDialog();
    if (response["error"] != 0) {
      Get.rawSnackbar(message: response["message"]);
    } else {
      Get.back();
    }
  }
}
