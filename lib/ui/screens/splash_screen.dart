import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/language_controller.dart';
import 'package:health_studio_user/ui/screens/authentication/login_screen.dart';
import 'package:health_studio_user/ui/screens/home_screen.dart';
import 'package:health_studio_user/ui/screens/setting_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:health_studio_user/utils/buttons.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void chnageLanguage(bool isEnglish) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('language', isEnglish);
    Get.find<LanguageTogglerController>().isEnglish = isEnglish;
    Get.find<LanguageTogglerController>().update();
    Get.to(() => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/splashimg.png",
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fitWidth,
            width: MediaQuery.of(context).size.width,
          ),
          Container(height: Get.height, color: splashthemeColor),
          Padding(
            padding: edgeInsets8,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/apptitle.png'),
                  Column(
                    children: [
                      Padding(
                        padding: edgeInsets16,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                                child: SplashButton(
                                    onTap: () {
                                      chnageLanguage(true);
                                      Get.updateLocale(const Locale('en'));
                                    },
                                    buttontitle: 'English',
                                    imagepath:
                                        'assets/images/englishbuttonlogo.png',
                                    buttonColor: splashbuttonColor1)),
                            sizedBoxWidth12,
                            Expanded(
                                child: SplashButton(
                              onTap: () {
                                chnageLanguage(false);
                                Get.updateLocale(const Locale('ar'));
                              },
                              buttontitle: 'عربي',
                              imagepath: 'assets/images/arabicbtnlogo.png',
                              buttonColor: splashbuttonColor2,
                            )),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppLocalizations.of(context)!.already_user,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: whiteColor)),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const LoginPage());
                            },
                            child: Text(
                              AppLocalizations.of(context)!.login_now,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    decoration: TextDecoration.underline,
                                    color: whiteColor,
                                  ),
                            ),
                          )
                        ],
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
  }
}
