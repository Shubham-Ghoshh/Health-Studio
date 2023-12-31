import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/utils/buttons.dart';
import 'package:health_studio_user/utils/spacing.dart';

Widget appBar({bool canGoBack = true}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      sizedBoxWidth12,
      canGoBack
          ? IconButton(
              onPressed: () {
                canGoBack ? Get.back() : null;
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
                color: Colors.white,
              ),
            )
          : const SizedBox(),
      sizedBoxWidth25,
      Center(
        child: SizedBox(
          width: 242,
          // height: 57,
          child: Image.asset("assets/images/health_studio_logo.png"),
        ),
      ),
    ],
  );
}

Row appbarWithSetting() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      Center(
        child: SizedBox(
          width: 240,
          child: Image.asset("assets/images/health_studio_logo.png"),
        ),
      ),
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12, bottom: 10),
            child: SettingButton(),
          ),
        ],
      ),
    ],
  );
}

AppBar customAppBar() {
  return AppBar(
    elevation: 0,
    title: SizedBox(
      width: 242,
      // height: 57,
      child: Image.asset("assets/images/health_studio_logo.png"),
    ),
  );
}
