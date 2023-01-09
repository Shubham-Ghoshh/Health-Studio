import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:health_studio_user/core/models/bottom_nav_item.dart';
import 'package:health_studio_user/ui/screens/setting_screen.dart';
import 'package:health_studio_user/core/controllers/home_controller.dart';
import 'package:health_studio_user/core/controllers/plan_controller.dart';
import 'package:health_studio_user/core/models/plan.dart';
import 'package:health_studio_user/ui/widgets/app_bar.dart';

import 'package:health_studio_user/ui/widgets/bottom_navigation_bar.dart';
import 'package:health_studio_user/ui/widgets/date.dart';
import 'package:health_studio_user/utils/buttons.dart';
import 'package:health_studio_user/utils/formatters.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:health_studio_user/ui/widgets/home_page_widgets.dart';

class LoggedInHomePage extends StatefulWidget {
  const LoggedInHomePage({Key? key}) : super(key: key);

  @override
  State<LoggedInHomePage> createState() => _LoggedInHomePageState();
}

class _LoggedInHomePageState extends State<LoggedInHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar(),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizedBoxHeight6,
                      Row(
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
                              child: Image.asset(
                                  "assets/images/health_studio_logo.png"),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 12, bottom: 10),
                                child: SettingButton(),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // sizedBoxHeight20,
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sizedBoxHeight6,
                        Text(
                          "Meetab Bhasa",
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        sizedBoxHeight12,
                        Container(
                          padding: edgeInsets16,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  sizedBoxHeight6,
                                  const Text(
                                    "Meal package that contains meals and snacks. Customer has the option to choose brekfast as one of the meals. No delivery every Friday.",
                                    style: TextStyle(
                                      color: Color(0xff0A0909),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Color(0xFFD9D9D9),
                              ),
                              sizedBoxHeight6,
                              const Text(
                                "Every Meal",
                                style: TextStyle(
                                  color: Color(0xff0A0909),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
