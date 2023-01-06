// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/language_controller.dart';
import 'package:health_studio_user/ui/widgets/setting_option_item.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
                  sizedBoxHeight6,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
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
                          height: 75,
                          child: Image.asset(
                            "assets/images/health_studio_logo.png",
                          ),
                        ),
                      ),
                    ],
                  ),
                  sizedBoxHeight35,
                  settingHeading("Language Preferance"),
                  sizedBoxHeight16,
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
                                    value: controller.englishPicker,
                                    onChanged: (value) {
                                      controller.englishPicker = value;
                                      controller.arabicPicker = !value;
                                      controller.update();
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
                                    value: controller.arabicPicker,
                                    onChanged: (value) {
                                      controller.englishPicker = !value;
                                      controller.arabicPicker = value;
                                      controller.update();
                                    }),
                              ),
                            ],
                          );
                        }),
                  ),
                  sizedBoxHeight25,
                  settingHeading("Your Account"),
                  sizedBoxHeight16,
                  SettingOptionItem(
                    settingIconImage: "default_address_icon",
                    settingName: "Default Address",
                    onTap: () {},
                  ),
                  divider(),
                  SettingOptionItem(
                    settingIconImage: "notification_icon",
                    settingName: "Notification",
                    onTap: () {},
                  ),
                  divider(),
                  SettingOptionItem(
                    optionalText: "December 22, 2022",
                    settingIconImage: "account_start_icon",
                    settingName: "Account Start",
                    onTap: () {},
                  ),
                  divider(),
                  SettingOptionItem(
                    optionalText: "January 22, 2023",
                    settingIconImage: "account_expiry_icon",
                    settingName: "Account Expiry",
                    onTap: () {},
                  ),
                  divider(),
                  SettingOptionItem(
                    settingIconImage: "change_password_icon",
                    settingName: "Change Password",
                    onTap: () {},
                  ),
                  divider(),
                  SettingOptionItem(
                    settingIconImage: "logout_icon",
                    settingName: "Logout",
                    onTap: () {},
                  ),
                  sizedBoxHeight25,
                  settingHeading("Share the Love"),
                  sizedBoxHeight16,
                  SettingOptionItem(
                    settingIconImage: "share_icon",
                    settingName: "Share this app to your friends",
                    onTap: () {},
                  ),
                  divider(),
                  SettingOptionItem(
                    settingIconImage: "instagram_icon",
                    settingName: "Follow us on Instagram",
                    onTap: () {},
                  ),
                  divider(),
                  SettingOptionItem(
                    settingIconImage: "facebook_icon",
                    settingName: "Look at our Facebook Page",
                    onTap: () {},
                  ),
                  sizedBoxHeight25,
                  settingHeading("Support"),
                  sizedBoxHeight16,
                  SettingOptionItem(
                    settingIconImage: "contact_icon",
                    settingName: "Contact us",
                    onTap: () {},
                  ),
                  divider(),
                  SettingOptionItem(
                    settingIconImage: "terms_and_conditions_icon",
                    settingName: "Terms & conditions",
                    onTap: () {},
                  ),
                  divider(),
                  SettingOptionItem(
                    settingIconImage: "survey_icon",
                    settingName: "Survey",
                    onTap: () {},
                  ),
                  sizedBoxHeight25,
                  settingHeading("Health Studio"),
                  sizedBoxHeight16,
                  SettingOptionItem(
                    settingIconImage: "ratings_icon",
                    settingName: "Rate the app",
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 108,
                  ),
                  Center(
                    child: Text(
                      "Health Studio 2.6",
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
