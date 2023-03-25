import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/language_controller.dart';
import 'package:health_studio_user/core/controllers/setting_controller.dart';
import 'package:health_studio_user/core/controllers/splash_controller.dart';
import 'package:health_studio_user/ui/screens/authentication/login_screen.dart';
import 'package:health_studio_user/ui/screens/home_screen.dart';
import 'package:health_studio_user/ui/screens/setting_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:health_studio_user/utils/buttons.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (splashController) {
          return Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: [
                splashController.controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio:
                            splashController.controller.value.aspectRatio,
                        child: VideoPlayer(splashController.controller),
                      )
                    : Image.asset(
                        "assets/images/splashimg.png",
                        height: MediaQuery.of(context).size.height,
                        fit: BoxFit.fitWidth,
                        width: MediaQuery.of(context).size.width,
                      ),
                splashController.controller.value.isInitialized
                    ? const SizedBox()
                    : Container(height: Get.height, color: splashthemeColor),
                Padding(
                  padding: edgeInsets8,
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/images/apptitle.png'),
                        Column(
                          children: [
                            Visibility(
                              visible: !splashController.languageSelected,
                              child: Padding(
                                padding: edgeInsets16,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                        child: SplashButton(
                                            onTap: () {
                                              splashController
                                                  .changeLanguage(true);
                                            },
                                            buttontitle: 'English',
                                            imagepath:
                                                'assets/images/englishbuttonlogo.png',
                                            buttonColor: splashbuttonColor1)),
                                    sizedBoxWidth12,
                                    Expanded(
                                        child: SplashButton(
                                      onTap: () {
                                        splashController.changeLanguage(false);
                                      },
                                      buttontitle: 'عربي',
                                      imagepath:
                                          'assets/images/kuwait_icon.png',
                                      buttonColor: splashbuttonColor2,
                                    )),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: !splashController.loggedIn,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      "${AppLocalizations.of(context)!.already_user} ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: whiteColor)),
                                  GestureDetector(
                                    onTap: () {
                                      splashController.timer.cancel();
                                      Get.to(() => const LoginPage());
                                      Get.put(SettingsController(),
                                              permanent: true)
                                          .getAppVersion();
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.login_now,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            decoration:
                                                TextDecoration.underline,
                                            color: whiteColor,
                                          ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            sizedBoxHeight10,
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
