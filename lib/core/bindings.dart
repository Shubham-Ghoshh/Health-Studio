import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/auth_controller.dart';

class AllBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
  }
}
