import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/constants.dart';

abstract class Utility {
  static void showLoadingDialog() {
    log("SHOW LOADER");
    showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (ctx) => SizedBox(
              width: double.infinity,
              height: Get.mediaQuery.size.height,
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.1,
                    child: ModalBarrier(
                      dismissible: false,
                      color: splashthemeColor,
                    ),
                  ),
                  Center(
                    child: CircularProgressIndicator(
                      color: splashthemeColor,
                    ),
                  )
                ],
              ),
            ));
  }

  static void closeDialog() {
    log("HIDE LOADER");
    if (Navigator.canPop(navigatorKey.currentContext!)) {
      Navigator.pop(navigatorKey.currentContext!);
    }
  }

  static void showSnackbar(String message) {
    Get.rawSnackbar(message: message);
  }
}
