import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/language_controller.dart';
import 'package:health_studio_user/core/controllers/setting_controller.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(builder: (settingsController) {
      return Scaffold(
          body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
            child: Column(
          children: [
            Row(
              children: [
                // sizedBoxWidth12,
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                sizedBoxWidth25,
                Text(
                  'Notifications',
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: whiteColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            settingsController.notifications.isEmpty
                ? Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        Center(
                          child: Text(
                            'No Notifications to show',
                            style: TextStyle(color: whiteColor),
                          ),
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: settingsController.notifications.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GetBuilder<LanguageTogglerController>(
                            builder: (languageController) {
                          return languageController.isEnglish
                              ? textcontainer(settingsController
                                  .notifications[index].messageEn
                                  .toString())
                              : textcontainer(settingsController
                                  .notifications[index].messageAr
                                  .toString());
                        });
                      },
                    ),
                  ),
          ],
        )),
      ));
    });
  }

  Widget textcontainer(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 40.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: edgeInsetsleft16,
              child: Text(
                text,
                style: const TextStyle(color: blackColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
