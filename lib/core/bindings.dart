import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/auth_controller.dart';
import 'package:health_studio_user/core/controllers/language_controller.dart';
import 'package:health_studio_user/core/controllers/order_controller.dart';
import 'package:health_studio_user/core/controllers/plan_controller.dart';
import 'package:health_studio_user/core/controllers/setting_controller.dart';

class AllBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.put(LanguageTogglerController(), permanent: true);
    Get.put(SettingsController(), permanent: true);
    Get.put(OrderController(), permanent: true);
    Get.put(PlanController(), permanent: true);
  }
}
