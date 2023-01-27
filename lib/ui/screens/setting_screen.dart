// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:io' show Platform;
import 'package:health_studio_user/core/controllers/auth_controller.dart';
import 'package:health_studio_user/core/controllers/setting_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/ui/screens/address_screen.dart';
import 'package:health_studio_user/ui/screens/authentication/login_screen.dart';
import 'package:health_studio_user/ui/screens/termsandconditions.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_studio_user/core/controllers/language_controller.dart';
import 'package:health_studio_user/ui/widgets/app_bar.dart';
import 'package:health_studio_user/ui/widgets/setting_option_item.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
        init: SettingsController(),
        builder: (settingsController) {
          return Scaffold(
            backgroundColor: Colors.blueAccent.shade400,
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        appBar(),
                        sizedBoxHeight10,
                        settingHeading(
                            AppLocalizations.of(context)!.lang_preferance),
                        sizedBoxHeight10,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: GetBuilder<LanguageTogglerController>(
                              init: LanguageTogglerController(),
                              builder: (controller) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const LanguageToggler(
                                      language: "English",
                                      languageImage: "united_kingdom_icon",
                                    ),
                                    Transform.scale(
                                      scale: 1.4,
                                      child: Switch.adaptive(
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.padded,
                                          activeColor: const Color(0xffE84C4F),
                                          activeTrackColor: Colors.white,
                                          inactiveTrackColor: Colors.white,
                                          inactiveThumbColor: Colors.black,
                                          value: controller.isEnglish,
                                          onChanged: (value) async {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();

                                            controller.isEnglish = value;
                                            // controller.arabicPicker = !value;
                                            controller.update();
                                            controller.isEnglish
                                                ? {
                                                    Get.updateLocale(
                                                        const Locale('en')),
                                                    prefs.setBool(
                                                        'language', true),
                                                  }
                                                : {
                                                    Get.updateLocale(
                                                        const Locale('ar')),
                                                    prefs.setBool(
                                                        'language', false),
                                                  };
                                          }),
                                    ),
                                  ],
                                );
                              }),
                        ),
                        divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: GetBuilder<LanguageTogglerController>(
                              init: LanguageTogglerController(),
                              builder: (controller) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const LanguageToggler(
                                      language: "عربي",
                                      languageImage:
                                          "united_arab_emirates_icon",
                                    ),
                                    Transform.scale(
                                      scale: 1.4,
                                      child: Switch.adaptive(
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.padded,
                                          activeColor: const Color(0xffE84C4F),
                                          activeTrackColor: Colors.white,
                                          inactiveTrackColor: Colors.white,
                                          inactiveThumbColor: Colors.black,
                                          value: !controller.isEnglish,
                                          onChanged: (value) async {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();

                                            controller.isEnglish = !value;
                                            // controller.arabicPicker = value;
                                            controller.update();
                                            !controller.isEnglish
                                                ? {
                                                    Get.updateLocale(
                                                        const Locale('ar')),
                                                    prefs.setBool(
                                                        'language', false),
                                                  }
                                                : {
                                                    Get.updateLocale(
                                                        const Locale('en')),
                                                    prefs.setBool(
                                                        'language', true),
                                                  };
                                          }),
                                    ),
                                  ],
                                );
                              }),
                        ),
                        sizedBoxHeight10,
                        settingHeading(
                            AppLocalizations.of(context)!.your_account),
                        sizedBoxHeight10,
                        Get.find<AuthController>().isLoggedIn
                            ? Column(
                                children: [
                                  SettingOptionItem(
                                    settingIconImage: "default_address_icon",
                                    settingName: AppLocalizations.of(context)!
                                        .default_address,
                                    onTap: () {
                                      Get.to(() => const Address(check: false));
                                    },
                                  ),
                                  divider(),
                                  SettingOptionItem(
                                    settingIconImage: "notification_icon",
                                    settingName: AppLocalizations.of(context)!
                                        .notifictaion,
                                    onTap: () {
                                      settingsController.getnotifications();
                                    },
                                  ),
                                  divider(),
                                  SettingOptionItem(
                                    optionalText: settingsController
                                            .userDetails?.orderFrom ??
                                        "No Info",
                                    settingIconImage: "account_start_icon",
                                    settingName: AppLocalizations.of(context)!
                                        .account_start,
                                    onTap: () {},
                                  ),
                                  divider(),
                                  SettingOptionItem(
                                    optionalText: settingsController
                                            .userDetails?.orderTo ??
                                        "No Info",
                                    settingIconImage: "account_expiry_icon",
                                    settingName: AppLocalizations.of(context)!
                                        .account_expiry,
                                    onTap: () {},
                                  ),
                                  divider(),
                                  SettingOptionItem(
                                    settingIconImage: "change_password_icon",
                                    settingName: AppLocalizations.of(context)!
                                        .change_password,
                                    onTap: () {
                                      settingsController
                                          .getChangePasswordLink();
                                    },
                                  ),
                                  divider(),
                                  SettingOptionItem(
                                    settingIconImage: "logout_icon",
                                    settingName:
                                        AppLocalizations.of(context)!.logout,
                                    onTap: () {
                                      settingsController.logout();
                                    },
                                  ),
                                ],
                              )
                            : SettingOptionItem(
                                settingIconImage: "account_expiry_icon",
                                settingName:
                                    AppLocalizations.of(context)!.sign_in,
                                onTap: () {
                                  Get.to(() => const LoginPage());
                                },
                              ),
                        sizedBoxHeight10,
                        settingHeading(
                            AppLocalizations.of(context)!.share_love),
                        sizedBoxHeight10,
                        SettingOptionItem(
                          settingIconImage: "share_icon",
                          settingName:
                              AppLocalizations.of(context)!.share_friends,
                          onTap: () {
                            Share.share(
                                'Health Studio app. Order health food right now. Available both for iOS & Android https://bit.ly/gethelthstudio');
                          },
                        ),
                        divider(),
                        SettingOptionItem(
                          key: const Key("instagram_icon"),
                          settingIconImage: "instagram_icon",
                          settingName:
                              AppLocalizations.of(context)!.follow_instagram,
                          onTap: () {
                            settingsController.launchInstagram();
                          },
                        ),
                        divider(),
                        SettingOptionItem(
                          key: const Key("facebook_icon"),
                          settingIconImage: "facebook_icon",
                          settingName:
                              AppLocalizations.of(context)!.follow_facebook,
                          onTap: () {
                            settingsController.launchFacebook();
                          },
                        ),
                        sizedBoxHeight10,
                        settingHeading(AppLocalizations.of(context)!.support),
                        sizedBoxHeight10,
                        SettingOptionItem(
                          settingIconImage: "contact_icon",
                          settingName: AppLocalizations.of(context)!.contact_us,
                          onTap: () {
                            settingsController.openMailApp();
                          },
                        ),
                        divider(),
                        SettingOptionItem(
                          settingIconImage: "terms_and_conditions_icon",
                          settingName:
                              AppLocalizations.of(context)!.terms_conditions,
                          onTap: () {
                            Get.to(() => const TermsandConditions());
                          },
                        ),
                        divider(),
                        SettingOptionItem(
                          settingIconImage: "survey_icon",
                          settingName: AppLocalizations.of(context)!.survey,
                          onTap: () {
                            settingsController.generatesurveylink();
                          },
                        ),
                        sizedBoxHeight16,
                        settingHeading("Health Studio"),
                        sizedBoxHeight10,
                        SettingOptionItem(
                          settingIconImage: "ratings_icon",
                          settingName: AppLocalizations.of(context)!.rate_app,
                          onTap: () {
                            settingsController.rateApp();
                          },
                        ),
                        sizedBoxHeight10,
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Health Studio ${settingsController.packageInfo?.version}(${settingsController.packageInfo?.buildNumber})",
                                style: TextStyle(
                                  shadows: <Shadow>[
                                    const Shadow(
                                      offset: Offset(2.0, 5.0),
                                      blurRadius: 5.0,
                                      color: Color.fromARGB(41, 0, 0, 0),
                                    ),
                                  ],
                                  color: loginButtonColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        sizedBoxHeight10,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class LanguageToggler extends StatefulWidget {
  const LanguageToggler({
    required this.languageImage,
    required this.language,
    Key? key,
  }) : super(key: key);

  final String languageImage;
  final String language;

  @override
  State<LanguageToggler> createState() => _LanguageTogglerState();
}

class _LanguageTogglerState extends State<LanguageToggler> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageTogglerController>(
        init: LanguageTogglerController(),
        builder: (controller) {
          return Row(
            children: [
              SizedBox(
                height: 33.3,
                width: 33.3,
                child: Image.asset(
                  "assets/images/${widget.languageImage}.png",
                ),
              ),
              const SizedBox(
                width: 28,
              ),
              Text(
                widget.language,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                ),
              ),
            ],
          );
        });
  }
}
