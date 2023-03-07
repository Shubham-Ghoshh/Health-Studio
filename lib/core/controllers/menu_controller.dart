import 'dart:developer';

import 'package:get/get.dart';
import 'package:health_studio_user/core/models/menu.dart';
import 'package:health_studio_user/core/request.dart';
import 'package:health_studio_user/ui/screens/food_detail_screen.dart';
import 'package:health_studio_user/ui/widgets/loader.dart';
import 'package:health_studio_user/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomMenuController extends GetxController {
  Menu? selectedMenu;
  MenuDetail? menuDetail;
  void getMenuDetail(String menuId) async {
    Utility.showLoadingDialog();
    Map<String, dynamic> response = await getRequest("menu/$menuId");
    Utility.closeDialog();
    if (response["error"] != 0) {
      menuDetail = null;
      update();
      Get.rawSnackbar(message: response["message"] ?? "");
    } else {
      menuDetail = MenuDetail.fromJson(response["details"]);
      update();
      Get.to(() => const FoodDetailPage());
    }
  }

  launchDietLink() async {
    try {
      await launchUrl(Uri.parse(dietReferenceLink),
          mode: LaunchMode.platformDefault);
    } catch (e) {
      log(e.toString());
    }
  }

  launchCalorieLink() async {
    try {
      await launchUrl(Uri.parse(calorieReferenceLink),
          mode: LaunchMode.platformDefault);
    } catch (e) {
      log(e.toString());
    }
  }
}
