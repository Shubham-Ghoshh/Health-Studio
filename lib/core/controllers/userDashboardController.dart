import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:health_studio_user/core/controllers/order_controller.dart';
import 'package:health_studio_user/core/controllers/plan_controller.dart';
import 'package:health_studio_user/core/models/item.dart';
import 'package:health_studio_user/core/models/meal.dart';
import 'package:health_studio_user/core/models/meal_item.dart';
import 'package:health_studio_user/core/models/package.dart';
import 'package:health_studio_user/core/models/plan.dart';
import 'package:health_studio_user/core/models/user_dashboard.dart';
import 'package:health_studio_user/core/request.dart';
import 'package:health_studio_user/ui/screens/address_screen.dart';
import 'package:health_studio_user/ui/screens/choose_item.dart';
import 'package:health_studio_user/ui/screens/payment_screen.dart';
import 'package:health_studio_user/ui/screens/select_menu.dart';
import 'package:health_studio_user/ui/screens/termsandconditions.dart';
import 'package:health_studio_user/ui/widgets/fridayalert.dart';
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
  List<MealItem?> mealItems = [];
  num tempPrice = 0;
  num tempCarbValue = 0;
  num tempProteinValue = 0;
  bool allMealsAdded = false;
  bool isUpdate = false;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getUserDashboard();
    });
  }

  void getUserDashboard() async {
    Utility.showLoadingDialog();
    Map<String, dynamic> response = await getRequest("home");
    Utility.closeDialog();
    if (response["error"] != 0) {
      Get.rawSnackbar(message: response["message"]);
    } else {
      userDashboard = UserDashboard.fromJson(response["details"]);
      update();
    }
  }

  void getPackageData(
    String planId,
    String? packageId,
  ) async {
    Utility.showLoadingDialog();
    Map<String, dynamic> response = await getRequest(
        "package-detail/$planId/${(packageId == "" || packageId == null) ? "custom_${Get.find<OrderController>().orderReference}" : packageId}");
    Utility.closeDialog();
    if (response["error"] != 0) {
      Get.rawSnackbar(message: response["message"]);
    } else {
      packageDetail =
          PackageDetail.fromJson(response["details"]["package"].first);

      update();

      if (packageDetail != null) {
        Get.find<PlanController>().selectedPackage = Package(
          id: packageId,
          titleAr: packageDetail!.titleAr,
          titleEn: packageDetail!.titleEn,
          descriptionAr: packageDetail!.descriptionAr,
          descriptionEn: packageDetail!.descriptionEn,
          image: packageDetail!.image,
          breakfast: packageDetail!.breakfast,
          categoryId: planId,
          fifteenDays: "0",
          sevenDays: "0",
          thirtyDays: "0",
          meal: packageDetail!.meal,
          snack: packageDetail!.snack,
          isCustom: packageDetail == null || packageId == "",
        );
        Get.find<PlanController>().update();
        // Get.to(
        //   () => const Address(
        //     check: true,
        //   ),
        // );

        Get.to(() => const TermsandConditions(
              showAddress: true,
            ));
        fridayAlertDialog();
      }
      update();
    }
  }

  void getPackageDetails(
      {required String planId,
      required String? packageId,
      required String date,
      required DashboardItem item,
      required readableDate,
      bool allowEdit = true}) async {
    Get.to(() => SelectMenuPage(
          allowEdit: allowEdit,
          date: date,
          showSaveButton: allowEdit,
          isUpdate: isUpdate,
          readableDate: readableDate,
        ));
    Utility.showLoadingDialog();
    Map<String, dynamic> response = await getRequest(
        "package-detail/$planId/${(packageId == "" || packageId == null) ? "custom_${Get.find<OrderController>().orderReference}" : packageId}");
    if (response["error"] != 0) {
      Get.back();
      Get.rawSnackbar(message: response["message"]);
      Utility.closeDialog();
    } else {
      packageDetail =
          PackageDetail.fromJson(response["details"]["package"].first);

      update();
      await getMealsByDate(date, allowEdit: allowEdit);
      selectedDashboardItem = item;
      tempPrice = 0;
      tempCarbValue = 0;
      tempProteinValue = 0;
      if (packageDetail != null) {
        Get.find<PlanController>().selectedPackage = Package(
          id: packageId,
          titleAr: packageDetail!.titleAr,
          titleEn: packageDetail!.titleEn,
          descriptionAr: packageDetail!.descriptionAr,
          descriptionEn: packageDetail!.descriptionEn,
          image: packageDetail!.image,
          breakfast: packageDetail!.breakfast,
          categoryId: planId,
          fifteenDays: "0",
          sevenDays: "0",
          thirtyDays: "0",
          meal: packageDetail!.meal,
          snack: packageDetail!.snack,
          isCustom: packageDetail == null || packageId == "",
        );
      }
      update();
    }
  }

  void getMenuByTypeAndDate(String type, String date, DashboardItem? item,
      {int itemIndex = 0}) async {
    meals = [];
    update();
    Get.to(() => ChooseMeal(
          item: item,
          type: type,
          itemIndex: itemIndex,
        ));
    Utility.showLoadingDialog();
    Map<String, dynamic> response = await getRequest("choose/$type/$date");
    Utility.closeDialog();
    if (response["error"] != 0) {
      Get.back();
      Get.rawSnackbar(message: response["message"]);
    } else {
      meals = List<Meal>.from(
          response["details"].map((e) => Meal.fromJson(e)).toList());

      update();
    }
  }

  void calculateMealPrice(String carbPerUnit, String proteinPerUnit) async {
    price =
        (((num.tryParse(carbValue) ?? 0) * (num.tryParse(carbPerUnit) ?? 0)) +
                ((num.tryParse(proteinValue) ?? 0) *
                    (num.tryParse(proteinPerUnit) ?? 0)))
            .toString();
    update();
  }

  void saveMeal(Meal meal, DashboardItem? item, String mealType,
      {int itemIndex = 0}) {
    int index = mealItems.indexWhere((m) => m?.key == mealType);
    if (index != -1) {
      if (meal.menuType != "No Special" &&
          mealItems[index]?.items.indexWhere((i) =>
                  i == null ? false : i.meal.menuType == meal.menuType) !=
              -1) {
        Get.rawSnackbar(
          message:
              "Two meals with same Special Category cannot be added, please try adding another meal.",
          duration: const Duration(
            seconds: 5,
          ),
        );
      } else {
        mealItems[index]?.items[itemIndex] = Item(
          id: meal.id,
          price: price,
          note: note,
          meal: meal,
          carb: carbValue,
          protein: proteinValue,
        );

        carbValue = "0";
        proteinValue = "0";
        price = "0";

        update();
        calculateTotal();
        Get.back();
        Get.back();
      }
    }
  }

  void calculateTotal() async {
    bool tempAdded = true;
    tempPrice = 0;
    tempCarbValue = 0;
    tempProteinValue = 0;
    for (int i = 0; i < mealItems.length; i++) {
      for (int j = 0; j < (mealItems[i]?.items.length ?? 0); j++) {
        if (mealItems[i]?.items[j] == null) {
          tempAdded = false;
        }
        tempPrice += (num.tryParse(mealItems[i]?.items[j]?.price ?? "") ?? 0);
        tempCarbValue +=
            (num.tryParse(mealItems[i]?.items[j]?.carb ?? "") ?? 0);
        tempProteinValue +=
            (num.tryParse(mealItems[i]?.items[j]?.protein ?? "") ?? 0);
      }
    }
    allMealsAdded = tempAdded;
    update();
  }

  void getMealPaymentLink(
    // Meal meal,
    DashboardItem? item,
    // String mealType,
  ) async {
    Utility.showLoadingDialog();

    if (tempPrice.toString() == "0" || tempPrice.toString() == "0.0") {
      submitMeals();
    } else {
      Map<String, dynamic> body = {
        "amount": tempPrice.toString(),
        "date": item?.dateRequested,
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
        String? responseURL = response["details"]["url"]
            ?.split("responseURL=")[1]
            .split("&errorURL")[0];

        Get.to(() => PaymentScreen(
              url: response["details"]["url"],
              amount: tempPrice,
              isMeal: true,
              onFinish: () {
                submitMeals();
              },
              responseURL: responseURL,
            ));
      }
    }
  }

  Future<void> getMealsByDate(String date, {bool allowEdit = true}) async {
    Map<String, dynamic> response = await getRequest("meals/$date");
    Utility.closeDialog();
    if (response["error"] != 0) {
      Get.back();
      Get.rawSnackbar(message: response["message"]);
    } else {
      mealItems = List<MealItem>.from(
        response["details"].map(
          (e) => MealItem.fromJson(e),
        ),
      );
      isUpdate = false;
      update();
      if (allowEdit) {
        if (mealItems[0]!.items.isEmpty) {
          int mealIndex = mealItems.indexWhere((e) => e?.key == "meal");
          int mealLength = mealIndex == -1
              ? 0
              : int.parse(mealItems[mealIndex]?.number ?? "0");
          allMealsAdded = false;
          mealItems.firstWhere((e) => e?.key == "meal")?.items =
              List.generate(mealLength, (idx) => null);
        } else {
          allMealsAdded = true;
          isUpdate = true;
        }
        if (mealItems.length > 1 ? mealItems[1]!.items.isEmpty : true) {
          int snackIndex = mealItems.indexWhere((e) => e?.key == "snack");
          int snackLength = snackIndex == -1
              ? 0
              : int.parse(mealItems[snackIndex]?.number ?? "0");
          allMealsAdded = false;
          int idx = mealItems.indexWhere((e) => e?.key == "snack");
          if (idx != -1) {
            mealItems[idx]?.items = List.generate(snackLength, (idx) => null);
          }
        } else {
          allMealsAdded = true;
          isUpdate = true;
        }
        if (mealItems.length > 2 ? mealItems[2]!.items.isEmpty : true) {
          int breakfastIndex =
              mealItems.indexWhere((e) => e?.key == "breakfast");
          int breakfastLength = breakfastIndex == -1
              ? 0
              : int.parse(mealItems[breakfastIndex]?.number ?? "0");

          allMealsAdded = false;
          int idx = mealItems.indexWhere((e) => e?.key == "breakfast");
          if (idx != -1) {
            mealItems[idx]?.items =
                List.generate(breakfastLength, (idx) => null);
          }
        } else {
          allMealsAdded = true;
          isUpdate = true;
        }
      }
      update();
    }
    return;
  }

  void submitMeals() async {
    Utility.showLoadingDialog();
    Map<String, dynamic> body = {};
    for (int i = 0; i < mealItems.length; i++) {
      body.addAll({
        mealItems[i]?.key ?? "": mealItems[i]?.items.map((e) => e.id).join(",")
      });
      for (int j = 0; j < (mealItems[i]?.items.length ?? 0); j++) {
        body.addAll(
            {"note_${mealItems[i]?.items[j].id}": mealItems[i]?.items[j].note});
        body.addAll(
            {"carb_${mealItems[i]?.items[j].id}": mealItems[i]?.items[j].carb});
        body.addAll({
          "protein_${mealItems[i]?.items[j].id}": mealItems[i]?.items[j].protein
        });
      }
    }
    mealItems.map((e) => body.addAll({
          e?.key ?? "": e?.items.map((e) => e.id).join(","),
        }));
    Map<String, dynamic> response = await postRequest(
        "meals/${selectedDashboardItem!.dateRequested}", body);
    Utility.closeDialog();
    if (response["error"] != 0) {
      Get.rawSnackbar(message: response["message"]);
    } else {
      Get.back();
      Get.back();
      Get.rawSnackbar(message: "Meals saved successfully");
      getUserDashboard();
    }
  }
}
