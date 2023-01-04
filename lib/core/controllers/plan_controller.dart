import 'package:get/get.dart';
import 'package:health_studio_user/core/models/plan.dart';
import 'package:health_studio_user/core/request.dart';
import 'package:health_studio_user/ui/screens/plan_screen.dart';
import 'package:health_studio_user/ui/widgets/loader.dart';

class PlanController extends GetxController {
  Plan? selectedPlan;
  List<Package> packages = <Package>[];

  void getPackages(Plan plan) async {
    selectedPlan = plan;
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
      Get.to(() => const PlanScreen());
    }
  }

  void selectVariant(String id, int value) {
    print("ONTAP");
    int index = packages.indexWhere((element) => element.id == id);
    packages[index == -1 ? 0 : index].selected = value;
    update();
  }
}
