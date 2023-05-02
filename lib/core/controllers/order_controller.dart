import 'dart:developer';

import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/plan_controller.dart';
import 'package:health_studio_user/core/models/order.dart';
import 'package:health_studio_user/core/models/order_details.dart';
import 'package:health_studio_user/core/models/plan.dart';
import 'package:health_studio_user/core/models/promocode.dart';
import 'package:health_studio_user/core/request.dart';
import 'package:health_studio_user/ui/screens/authentication/login_screen.dart';
import 'package:health_studio_user/ui/screens/payment_confirmation.dart';
import 'package:health_studio_user/ui/screens/payment_screen.dart';
import 'package:health_studio_user/ui/screens/termsandconditions.dart';
import 'package:health_studio_user/ui/widgets/fridayalert.dart';
import 'package:health_studio_user/ui/widgets/loader.dart';
import 'package:health_studio_user/utils/formatters.dart';
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
      url = response["details"]["url"];
      orderReference = response["details"]["order_reference"];
      update();

      if (order.amount == "0") {
        Get.find<OrderController>().getOrderDetails(status: "captured");
      } else {
        String? responseURL = ((url?.split("responseURL=").length ?? 0) > 1)
            ? url?.split("responseURL=")[1].split("&errorURL")[0]
            : "";
        Get.to(() => PaymentScreen(
              url: url,
              amount: num.parse(order.amount!),
              responseURL: responseURL,
            ));
      }
    }
  }

  Future<void> getOrderDetails({
    String status = "",
    bool navigate = true,
  }) async {
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

  Future<String?> confirmOrder(
      String? planId, String? packageId, bool isLoggedIn,
      {Package? package, bool navigate = true}) async {
    if (!isLoggedIn) {
      Get.to(() => LoginPage(
            onSuccess: () {
              Get.back();
              confirmOrder(planId, packageId, true, package: package);
            },
          ));
      return null;
    } else {
      Utility.showLoadingDialog();
      Map<String, dynamic> response =
          await getRequest("order/confirm/$planId/$packageId");
      Utility.closeDialog();

      log(response.toString());
      if (response["error"] != 0) {
        Get.rawSnackbar(message: response["message"]);
      } else {
        if (navigate) {
          PlanController planController = Get.find<PlanController>();
          planController.selectVariant(
            package,
            planController.days,
            planController.meal,
            planController.breakfast,
            planController.snack,
          );

          order.startDate = DateFormat("dd-MM-yyyy").format(
              getDateFormat(response["details"][0]["start"], split: false));
          firstDate =
              getDateFormat(response["details"][0]["start"], split: false);
          price = order.amount ?? package!.sevenDays;
          order.amount = order.amount ?? package!.sevenDays;
          if (package!.selected == 7) {
            order.amount = package.sevenDays;
            price = package.sevenDays;
          } else if (package.selected == 15) {
            order.amount = package.fifteenDays;
            price = package.fifteenDays;
          } else if (package.selected == 30) {
            price = package.thirtyDays;

            order.amount = package.thirtyDays;
          }

          order.packageId = package.id;
          order.planId = planId;

          order.endDate = DateFormat("dd-MM-yyyy").format(
            getDateFormat(order.startDate!).add(
              Duration(
                days: (duration - 1),
              ),
            ),
          );
          order.meal = meal;
          order.breakfast = breakfast;
          order.snack = snack;
          order.isCustom =
              Get.find<PlanController>().selectedPackage?.isCustom ?? false;

          print("ORDER");
          print(order.toJson());

          Get.to(() => const TermsandConditions(
                showAddress: true,
              ));
          fridayAlertDialog();
        } else {
          return response["details"][0]["start"];
        }
      }
    }
  }
}
