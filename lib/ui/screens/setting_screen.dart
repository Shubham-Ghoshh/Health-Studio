// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:io' show Platform;
import 'package:app_version/app_version.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/language_controller.dart';
import 'package:health_studio_user/ui/widgets/app_bar.dart';
import 'package:health_studio_user/ui/widgets/setting_option_item.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  _launchInstagram() async {
    var nativeUrl = "instagram://user?username=healthstudiokw";
    var webUrl = "https://www.instagram.com/healthstudiokw";

    try {
      await launchUrlString(nativeUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      // ignore: avoid_print
      print(e);
      await launchUrlString(webUrl, mode: LaunchMode.platformDefault);
    }
  }

  _launchFacebook() async {
    var webUrl = "https://m.facebook.com/healthstudiokw";

    try {
      await launchUrlString(webUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  _rateAppAndroid() async {
    var webUrl =
        "https://play.google.com/store/apps/details?id=com.healthstudio.app&gl=US&pli=1";

    try {
      await launchUrlString(webUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  _rateAppIos() async {
    var webUrl = "https://apps.apple.com/app/id=com.healthstudio.app";

    try {
      await launchUrlString(webUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  String version = "2";
  _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
  }

  @override
  void initState() {
    _getAppVersion();
    print("uuuu" + version);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  sizedBoxHeight30,
                  settingHeading(AppLocalizations.of(context)!.lang_preferance),
                  sizedBoxHeight10,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GetBuilder<LanguageTogglerController>(
                        init: LanguageTogglerController(),
                        builder: (controller) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          await SharedPreferences.getInstance();

                                      controller.isEnglish = value;
                                      // controller.arabicPicker = !value;
                                      controller.update();
                                      controller.isEnglish
                                          ? {
                                              Get.updateLocale(
                                                  const Locale('en')),
                                              prefs.setBool('language', true),
                                            }
                                          : {
                                              Get.updateLocale(
                                                  const Locale('ar')),
                                              prefs.setBool('language', false),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const LanguageToggler(
                                language: "عربي",
                                languageImage: "united_arab_emirates_icon",
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
                                          await SharedPreferences.getInstance();

                                      controller.isEnglish = !value;
                                      // controller.arabicPicker = value;
                                      controller.update();
                                      !controller.isEnglish
                                          ? {
                                              Get.updateLocale(
                                                  const Locale('ar')),
                                              prefs.setBool('language', false),
                                            }
                                          : {
                                              Get.updateLocale(
                                                  const Locale('en')),
                                              prefs.setBool('language', true),
                                            };
                                    }),
                              ),
                            ],
                          );
                        }),
                  ),
                  sizedBoxHeight25,
                  settingHeading(AppLocalizations.of(context)!.your_account),
                  sizedBoxHeight10,
                  SettingOptionItem(
                    settingIconImage: "default_address_icon",
                    settingName: AppLocalizations.of(context)!.default_address,
                    onTap: () {},
                  ),
                  divider(),
                  SettingOptionItem(
                    settingIconImage: "notification_icon",
                    settingName: AppLocalizations.of(context)!.notifictaion,
                    onTap: () {},
                  ),
                  divider(),
                  SettingOptionItem(
                    optionalText: "December 22, 2022",
                    settingIconImage: "account_start_icon",
                    settingName: AppLocalizations.of(context)!.account_start,
                    onTap: () {},
                  ),
                  divider(),
                  SettingOptionItem(
                    optionalText: "January 22, 2023",
                    settingIconImage: "account_expiry_icon",
                    settingName: AppLocalizations.of(context)!.account_expiry,
                    onTap: () {},
                  ),
                  divider(),
                  SettingOptionItem(
                    settingIconImage: "change_password_icon",
                    settingName: AppLocalizations.of(context)!.change_password,
                    onTap: () {},
                  ),
                  divider(),
                  SettingOptionItem(
                    settingIconImage: "logout_icon",
                    settingName: AppLocalizations.of(context)!.logout,
                    onTap: () {},
                  ),
                  sizedBoxHeight16,
                  settingHeading(AppLocalizations.of(context)!.share_love),
                  sizedBoxHeight10,
                  SettingOptionItem(
                    settingIconImage: "share_icon",
                    settingName: AppLocalizations.of(context)!.share_friends,
                    onTap: () {},
                  ),
                  divider(),
                  SettingOptionItem(
                    settingIconImage: "instagram_icon",
                    settingName: AppLocalizations.of(context)!.follow_instagram,
                    onTap: () {
                      _launchInstagram();
                    },
                  ),
                  divider(),
                  SettingOptionItem(
                    settingIconImage: "facebook_icon",
                    settingName: AppLocalizations.of(context)!.follow_facebook,
                    onTap: () {
                      _launchFacebook();
                    },
                  ),
                  sizedBoxHeight16,
                  settingHeading(AppLocalizations.of(context)!.support),
                  sizedBoxHeight10,
                  SettingOptionItem(
                    settingIconImage: "contact_icon",
                    settingName: AppLocalizations.of(context)!.contact_us,
                    onTap: () {},
                  ),
                  divider(),
                  SettingOptionItem(
                    settingIconImage: "terms_and_conditions_icon",
                    settingName: AppLocalizations.of(context)!.terms_conditions,
                    onTap: () {},
                  ),
                  divider(),
                  SettingOptionItem(
                    settingIconImage: "survey_icon",
                    settingName: AppLocalizations.of(context)!.survey,
                    onTap: () {},
                  ),
                  sizedBoxHeight16,
                  settingHeading("Health Studio"),
                  sizedBoxHeight10,
                  SettingOptionItem(
                    settingIconImage: "ratings_icon",
                    settingName: AppLocalizations.of(context)!.rate_app,
                    onTap: () {
                      if (Platform.isAndroid) {
                        _rateAppAndroid();
                      } else if (Platform.isIOS) {
                        _rateAppIos();
                      }
                    },
                  ),
                  sizedBoxHeight90,
                  Center(
                    child: Column(
                      children: [
                        AppVersion(),
                        Text(
                          "Health Studio $version",
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
                  sizedBoxHeight16,
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
