import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/language_controller.dart';
import 'package:health_studio_user/core/models/menu.dart';
import 'package:health_studio_user/core/request.dart';
import 'package:health_studio_user/ui/screens/food_detail_screen.dart';
import 'package:health_studio_user/ui/widgets/loader.dart';

class MenuController extends GetxController {
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
}
