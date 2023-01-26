import 'package:get/get.dart';
import 'package:health_studio_user/core/models/order.dart';
import 'package:health_studio_user/core/models/order_details.dart';
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

  String meal = "1";
  String breakfast = "1";
  String snack = "1";

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
    Utility.showLoadingDialog();
    Map<String, dynamic> response =
        await getRequest("order/check/$orderReference");
    Utility.closeDialog();
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
