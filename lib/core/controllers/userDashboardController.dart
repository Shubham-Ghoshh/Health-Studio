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
  int tempPrice = 0;
  int tempCarbValue = 0;
  int tempProteinValue = 0;
  bool allMealsAdded = false;

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
      }
      update();
    }
  }

  void getPackageDetails(
      String planId, String? packageId, String date, DashboardItem item,
      {bool allowEdit = true}) async {
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

  void getMenuByTypeAndDate(String type, String date, DashboardItem item,
      {int itemIndex = 0}) async {
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
            itemIndex: itemIndex,
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

  void saveMeal(Meal meal, DashboardItem item, String mealType,
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
        tempPrice += (int.tryParse(mealItems[i]?.items[j]?.price ?? "") ?? 0);
        tempCarbValue +=
            (int.tryParse(mealItems[i]?.items[j]?.carb ?? "") ?? 0);
        tempProteinValue +=
            (int.tryParse(mealItems[i]?.items[j]?.protein ?? "") ?? 0);
      }
    }
    allMealsAdded = tempAdded;
    update();
  }

  void getMealPaymentLink(
    // Meal meal,
    DashboardItem item,
    // String mealType,
  ) async {
    Utility.showLoadingDialog();

    if (tempPrice.toString() == "0") {
      submitMeals();
    } else {
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
  }

  Future<void> getMealsByDate(String date, {bool allowEdit = true}) async {
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
      bool isUpdate = false;
      if (allowEdit) {
        if (mealItems[0]!.items.isEmpty) {
          allMealsAdded = false;
          mealItems.firstWhere((e) => e?.key == "meal")?.items = List.generate(
              int.tryParse(packageDetail!.meal) ?? 0, (idx) => null);
        } else {
          allMealsAdded = true;
          isUpdate = true;
        }
        if (mealItems[1]!.items.isEmpty) {
          allMealsAdded = false;
          mealItems.firstWhere((e) => e?.key == "snack")?.items = List.generate(
              int.tryParse(packageDetail!.snack) ?? 0, (idx) => null);
        } else {
          allMealsAdded = true;
          isUpdate = true;
        }
        if (mealItems[2]!.items.isEmpty) {
          allMealsAdded = false;
          mealItems.firstWhere((e) => e?.key == "breakfast")?.items =
              List.generate(
                  int.tryParse(packageDetail!.breakfast) ?? 0, (idx) => null);
        } else {
          allMealsAdded = true;
          isUpdate = true;
        }
      }
      update();
      Get.to(() => SelectMenuPage(
            allowEdit: allowEdit,
            date: date,
            item: selectedDashboardItem!,
            showSaveButton: allowEdit,
            isUpdate: isUpdate,
          ));
    }
    return;
  }

  void submitMeals() async {
    print("SUBMIT MEALS");
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
    print(body);
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
