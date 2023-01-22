import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/home_controller.dart';
import 'package:health_studio_user/core/controllers/language_controller.dart';
import 'package:health_studio_user/ui/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class SplashController extends GetxController {
  bool languageSelected = true;
  bool loggedIn = false;
  VideoPlayerController controller =
      VideoPlayerController.asset("assets/videos/intro_video.mp4");
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        controller.initialize().then((value) async {
          await controller.play();
          await controller.setLooping(true);
          checkIsLanguageSelected();
        });
      },
    );
  }

  void checkIsLanguageSelected() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    languageSelected = prefs.getBool("languageSelected") ?? false;
    update();
    Get.put(HomeController(), permanent: true);
    checkIsUserLoggedIn();
    Timer(const Duration(seconds: 3), goHome);
  }

  void checkIsUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("auth_key");
    if (value != null) {
      loggedIn = true;
      update();
    }
  }

  void goHome() async {
    Get.off(
      () => const HomePage(),
      transition: Transition.rightToLeftWithFade,
      duration: const Duration(milliseconds: 800),
    );
  }

  void changeLanguage(bool isEnglish) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('language', isEnglish);
    prefs.setBool("languageSelected", true);
    languageSelected = true;
    Get.find<LanguageTogglerController>().isEnglish = isEnglish;
    Get.find<LanguageTogglerController>().update();
    Get.off(() => const HomePage());
    Get.updateLocale(Locale(isEnglish ? 'en' : 'ar'));
  }
}
