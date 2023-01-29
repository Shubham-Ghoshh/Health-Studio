import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/plan_controller.dart';
import 'package:health_studio_user/core/models/order.dart';
import 'package:health_studio_user/core/models/order_details.dart';
import 'package:health_studio_user/core/models/promocode.dart';
import 'package:health_studio_user/core/request.dart';
import 'package:health_studio_user/ui/screens/payment_confirmation.dart';
import 'package:health_studio_user/ui/screens/payment_screen.dart';
import 'package:health_studio_user/ui/widgets/loader.dart';
import 'package:intl/intl.dart';

class OrderController extends GetxController {
  int duration = 7;
  String? url;
  String? orderReference;
  OrderDetails? orderDetails;
  Order order = Order();
  DateTime? firstDate;
  String code = "";
  String meal = "1";
  String breakfast = "1";
  String snack = "1";
  String? price;

  PromoCode? promoCode;

  void checkVoucherAPI() async {
    if (code == "") {
      order.amount = price;
      update();
    } else {
      Utility.showLoadingDialog();
      Map<String, dynamic> body = {
        "coupon_code": code,
        "package_id": Get.find<PlanController>().selectedPackage!.id,
        "order_amount": order.amount,
      };
      Map<String, dynamic> response = await postRequest("vourcher/check", body);
      Utility.closeDialog();

      if (response["error"] != 0) {
        order.amount = price;
        update();
        Get.rawSnackbar(message: response["message"]);
      } else {
        promoCode = PromoCode.fromJson(response["details"][0]);
        if (promoCode?.orderFinalAmount != null &&
            promoCode?.orderFinalAmount != "") {
          order.amount = promoCode?.orderFinalAmount;
        }
        update();
      }
    }
  }

  void getPaymentURL() async {
    Utility.showLoadingDialog();
    Map<String, dynamic> body = order.toJson();
    Map<String, dynamic> response = await postRequest("order/pay", body);
    Utility.closeDialog();
    if (response["error"] != 0) {
      Get.rawSnackbar(message: response["message"]);
    } else {
      print("REFERENCE ${response["details"]["order_reference"]}");
      url = response["details"]["url"];
      orderReference = response["details"]["order_reference"];
      update();
      print("URL $url");
      Get.to(() => PaymentScreen(
            url: url,
            amount: int.parse(order.amount!),
          ));
    }
  }

  Future<void> getOrderDetails(
      {String status = "", bool navigate = true}) async {
    if (navigate) {
      Utility.showLoadingDialog();
    }
    Map<String, dynamic> response =
        await getRequest("order/check/$orderReference");
    if (navigate) {
      Utility.closeDialog();
    }
    if (response["error"] != 0) {
      if (navigate) {
        Get.back();
      }
      Get.rawSnackbar(message: response["message"]);
    } else {
      orderDetails = OrderDetails.fromJson(response["details"][0]);
      update();
      if (navigate) {
        Get.to(() => PaymentConfirmationPage(
              status: status,
            ));
      }
    }
  }
}
