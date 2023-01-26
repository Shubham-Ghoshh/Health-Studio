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
    getPlanDetail(plan.id);
  }

  void getPlanDetail(String id, {bool navigate = true}) async {
    Utility.showLoadingDialog();
    Map<String, dynamic> response = await getRequest("plan/$id");
    Utility.closeDialog();
    if (response["error"] != 0) {
      planDetail = null;
      update();
      Get.rawSnackbar(message: response["message"] ?? "");
    } else {
      planDetail = PlanDetail.fromJson(response["details"][0]);
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
    OrderController controller = Get.find<OrderController>();

    switch (days) {
      case 7:
        String val = (((int.tryParse(meal) ?? 1) *
                    int.parse(planDetail!.mealSevenDays!)) +
                ((int.tryParse(breakfast) ?? 1) *
                    int.parse(planDetail!.breakfastSevenDays!)) +
                (int.tryParse(snack) ?? 1) *
                    int.parse(planDetail!.snackSevenDays!))
            .toString();
        sevenDays = val;
        update();
        return val;

      case 15:
        String val = (((int.tryParse(meal) ?? 1) *
                    int.parse(planDetail!.mealFifteenDays!)) +
                ((int.tryParse(breakfast) ?? 1) *
                    int.parse(planDetail!.breakfastFifteenDays!)) +
                (int.tryParse(snack) ?? 1) *
                    int.parse(planDetail!.snackFifteenDays!))
            .toString();
        fifteenDays = val;
        return val;

      case 30:
        String val = (((int.tryParse(meal) ?? 1) *
                    int.parse(planDetail!.mealThirtyDays!)) +
                ((int.tryParse(breakfast) ?? 1) *
                    int.parse(planDetail!.breakfastThirtyDays!)) +
                (int.tryParse(snack) ?? 1) *
                    int.parse(planDetail!.snackThirtyDays!))
            .toString();
        thirtyDays = val;
        return val;
      default:
        return "";
    }
  }
}
