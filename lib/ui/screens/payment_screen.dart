import 'dart:collection';
import 'dart:convert';
import 'dart:core';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/order_controller.dart';
import 'package:health_studio_user/utils/colors.dart';

class PaymentScreen extends StatefulWidget {
  final Function? onFinish;
  final String? url;
  final num? amount;
  final bool isMeal;

  const PaymentScreen(
      {Key? key, this.onFinish, this.url, this.isMeal = false, this.amount})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PaymentScreenState();
  }
}

class PaymentScreenState extends State<PaymentScreen> {
  String successUrl = 'https://padel-kwt.com/success';
  String failedUrl = 'https://padel-kwt.com/failure';
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  Widget build(BuildContext context) {
    print("ONFINISH ${widget.onFinish}");

    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
                color: Colors.white,
              ),
            ),
            elevation: 0,
            centerTitle: true,
            backgroundColor: plantextColor,
            title: Text(
              AppLocalizations.of(context)!.payment,
              style: TextStyle(
                  fontSize: 20.sp,
                  color: whiteColor,
                  fontWeight: FontWeight.bold),
            )),
        body: webView());
  }

  bool firstTimeLoad = true;
  Widget webView() {
    return Stack(
      children: [
        InAppWebView(
          key: webViewKey,
          initialUrlRequest:
              URLRequest(url: Uri.parse(widget.url?.trim() ?? '')),
          initialUserScripts: UnmodifiableListView<UserScript>([]),
          initialOptions: options,
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            var uri = navigationAction.request.url!;
            print("URI ===${uri.toString()}");
            print(uri.queryParameters);

            return NavigationActionPolicy.ALLOW;
          },
          onLoadStop: (controller, uri) async {
            if (uri.toString() ==
                "http://148.66.142.197/~healthstudioking/api/index.php?path=/knet") {
              var html = await controller.evaluateJavascript(
                  source: "window.document.body.innerText;");
              switch (html) {
                case "captured":
                  {
                    if (widget.isMeal) {
                      Get.back();
                      Get.back();
                      print(widget.onFinish != null);
                      widget.onFinish != null ? widget.onFinish!() : null;
                      Get.rawSnackbar(message: "Payment Successful");
                    } else {
                      Get.find<OrderController>().getOrderDetails(status: html);
                    }
                    break;
                  }
                case "not captured":
                  {
                    if (widget.isMeal) {
                      Get.back();
                      Get.back();
                      Get.rawSnackbar(message: "Payment Failed");
                    } else {
                      Get.find<OrderController>().getOrderDetails(status: html);
                      break;
                    }
                  }
              }
            }
          },
          onLoadError: (controller, url, code, message) {
            Get.back();
            Get.rawSnackbar(message: "Unable to make payment at this time");
          },
          onProgressChanged: (controller, progress) {
            if (progress == 100 && firstTimeLoad) {
              setState(() {
                firstTimeLoad = false;
              });
            }
          },
        ),
        firstTimeLoad
            ? const Center(
                child: CircularProgressIndicator(
                  color: activeDateBgColor,
                ),
              )
            : Container()
      ],
    );
  }

  // updatePayment(String txId, String tranID) async {
  //   NetworkExe networkExe = Get.find();
  //   var map = {'OrderID': txId, 'PaymentID': tranID};

  //   var method = APIs.paymentUpdate;
  //   if (widget.isPrivate) {
  //     method = APIs.paymentUpdatePrivate;
  //   }
  //   var response = await networkExe.putData(method, map);
  //   var parseResponse = stringToJson(response.bodyString);
  //   var model = BaseResponse.fromJson(parseResponse);
  //   if (model.code == 200) {
  //     showSuccessDialog(txId, widget.amount ?? 0.0);
  //   } else {
  //     showFailedDialog('Your Order Id $txId \n Please connect with our team');
  //   }
  // }

  stringToJson(String? data) {
    if (data == null) throw ('Internal Error');
    if (data.contains('Forbidden')) throw ('Internal Error');
    return jsonDecode(data);
  }

  // showFailedDialog(String message) {
  //   SmartDialog.show(
  //       isLoadingTemp: false,
  //       widget: AppDialog(
  //         title: 'Payment Failed',
  //         subTitle: message,
  //         leftButtonTitle: 'Cancel',
  //         isShowCancel: false,
  //         rightButtonTitle: "Ok",
  //         rightButtonColor: ColorRes.bg,
  //         callBack: (bool isOk) {
  //           SmartDialog.dismiss();
  //           if (isOk) {
  //             Get.back();
  //           }
  //         },
  //       ));
  // }

  // showSuccessDialog(String txId, num amount) {
  //   SmartDialog.show(
  //       isLoadingTemp: false,
  //       widget: AppDialog(
  //         title: 'Payment Successful',
  //         subTitle:
  //             'Your Payment KWD $amount was successful completed \n OrderId - $txId',
  //         leftButtonTitle: 'Cancel',
  //         isShowCancel: false,
  //         rightButtonTitle: "Thanks!",
  //         rightButtonColor: ColorRes.bg,
  //         callBack: (bool isOk) {
  //           SmartDialog.dismiss();
  //           if (isOk) {
  //             Get.offAll(const TabScreen());
  //           }
  //         },
  //       ));
  // }
}
