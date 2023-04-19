import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/order_controller.dart';
import 'package:health_studio_user/core/models/plan.dart';
import 'package:health_studio_user/core/models/plan_detail.dart';
import 'package:health_studio_user/core/request.dart';
import 'package:health_studio_user/ui/screens/plan_screen.dart';
import 'package:health_studio_user/ui/widgets/loader.dart';

class PlanController extends GetxController {
  Plan? selectedPlan;
  List<Package> packages = <Package>[];
  PlanDetail? planDetail;
  String price = "-";
  String meal = "1";
  String breakfast = "1";
  String snack = "1";
  int days = 7;
  String sevenDays = "0";
  String fifteenDays = "0";
  String thirtyDays = "0";
  Package? selectedPackage;
  bool customPlanCreated = false;

  void getPackages(Plan plan) async {
    selectedPlan = plan;
    customPlanCreated = false;
    update();
    Get.to(() => const PlanScreen());
    Utility.showLoadingDialog();
    Map<String, dynamic> response = await getRequest("package/${plan.id}");
    Utility.closeDialog();

    if (response["error"] != 0) {
      packages = [];
      update();
      Get.rawSnackbar(message: response["message"] ?? "");
    } else {
      packages = response["details"] == null
          ? <Package>[]
          : List<Package>.from(
              response["details"].map((e) => Package.fromJson(e)).toList());
      update();
    }
    getPlanDetail(plan.id, navigate: false);
  }

  void getPlanDetail(String id,
      {bool navigate = true, bool setSelectedPlan = false}) async {
    if (navigate) {
      Utility.showLoadingDialog();
    }
    Map<String, dynamic> response = await getRequest("plan/$id");
    if (navigate) {
      Utility.closeDialog();
    }
    if (response["error"] != 0) {
      planDetail = null;
      update();
      Get.rawSnackbar(message: response["message"] ?? "");
    } else {
      planDetail = PlanDetail.fromJson(response["details"][0]);
      if (setSelectedPlan) {
        selectedPlan = Plan.fromJson(response["details"][0]);
      }
      calculatePrice(7);
      calculatePrice(15);
      calculatePrice(30);
      update();
      if (navigate) {
        Get.to(() => const PlanScreen());
      }
    }
  }

  void selectVariant(Package? package, int value, String nMeal,
      String nBreakfast, String nSnack) {
    int index = packages.indexWhere((element) => element == package);
    if (index != -1) {
      packages[index].selected = value;
      meal = nMeal;
      breakfast = nBreakfast;
      snack = nSnack;
      days = value;
      selectedPackage = packages[index];
      update();
    }
  }

  String calculatePrice(int days) {
    int mealCount = (int.tryParse(meal) ?? 1);

    switch (days) {
      case 7:
        num mealPrice = mealCount > 1
            ? ((1 * num.parse(planDetail!.mealSevenDays!)) +
                ((num.tryParse(meal) ?? 1) - 1) *
                    num.parse(planDetail!.mealSevenDaysTwo!))
            : ((num.tryParse(meal) ?? 1) *
                num.parse(planDetail!.mealSevenDays!));
        String val = (mealPrice +
                ((num.tryParse(breakfast) ?? 1) *
                    num.parse(planDetail!.breakfastSevenDays!)) +
                (num.tryParse(snack) ?? 1) *
                    num.parse(planDetail!.snackSevenDays!))
            .toString();
        sevenDays = val;
        update();
        return val;

      case 15:
        num mealPrice = mealCount > 1
            ? ((1 * num.parse(planDetail!.mealFifteenDays!)) +
                ((num.tryParse(meal) ?? 1) - 1) *
                    num.parse(planDetail!.mealFifteenDaysTwo!))
            : ((num.tryParse(meal) ?? 1) *
                num.parse(planDetail!.mealFifteenDays!));
        String val = (mealPrice +
                ((num.tryParse(breakfast) ?? 1) *
                    num.parse(planDetail!.breakfastFifteenDays!)) +
                (num.tryParse(snack) ?? 1) *
                    num.parse(planDetail!.snackFifteenDays!))
            .toString();
        fifteenDays = val;
        return val;

      case 30:
        num mealPrice = mealCount > 1
            ? ((1 * num.parse(planDetail!.mealThirtyDays!)) +
                ((num.tryParse(meal) ?? 1) - 1) *
                    num.parse(planDetail!.mealThirtyDaysTwo!))
            : ((num.tryParse(meal) ?? 1) *
                num.parse(planDetail!.mealThirtyDays!));
        String val = (mealPrice +
                ((num.tryParse(breakfast) ?? 1) *
                    num.parse(planDetail!.breakfastThirtyDays!)) +
                (num.tryParse(snack) ?? 1) *
                    num.parse(planDetail!.snackThirtyDays!))
            .toString();
        thirtyDays = val;
        return val;
      default:
        return "";
    }
  }
}
