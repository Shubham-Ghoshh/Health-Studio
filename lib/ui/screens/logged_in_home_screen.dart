import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:health_studio_user/core/controllers/home_controller.dart';
import 'package:health_studio_user/ui/widgets/app_bar.dart';
import 'package:health_studio_user/ui/widgets/bottom_navigation_bar.dart';
import 'package:health_studio_user/ui/widgets/date.dart';
import 'package:health_studio_user/ui/widgets/food_detail_card.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';

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
                        appbarWithSetting(),
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
                              shadows: textShadow,
                            ),
                          ),
                          sizedBoxHeight12,
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: edgeInsets16,
                                      decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromARGB(50, 0, 0, 0),
                                            spreadRadius: 0.5,
                                            blurRadius: 1,
                                            offset: Offset(0, 8),
                                          )
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              sizedBoxHeight6,
                                              const Text(
                                                "Meal package that contains meals and snacks. Customer has the option to choose brekfast as one of the meals. No delivery every Friday.",
                                                style: TextStyle(
                                                  color: Color(0xff0A0909),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.4,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            color: Color.fromARGB(96, 0, 0, 0),
                                          ),
                                          sizedBoxHeight6,
                                          const Text(
                                            "Every Meal:",
                                            style: TextStyle(
                                              color: Color(0xff0A0909),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.4,
                                            ),
                                          ),
                                          sizedBoxHeight6,
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  NutritionContent(
                                                      image: SvgPicture.asset(
                                                        'assets/images/calorie.svg',
                                                        color: plantextColor,
                                                      ),
                                                      nutritionContent: "250",
                                                      nutritionName: "Calorie"),
                                                  NutritionContent(
                                                      image: SvgPicture.asset(
                                                        'assets/images/protein.svg',
                                                        color: plantextColor,
                                                      ),
                                                      nutritionContent: "24",
                                                      nutritionName: "Protein"),
                                                  NutritionContent(
                                                      image: SvgPicture.asset(
                                                        'assets/images/fat.svg',
                                                        color: plantextColor,
                                                      ),
                                                      nutritionContent: "10",
                                                      nutritionName: "Fat"),
                                                  NutritionContent(
                                                      image: SvgPicture.asset(
                                                        'assets/images/carbs.svg',
                                                        color: plantextColor,
                                                      ),
                                                      nutritionContent: "150",
                                                      nutritionName: "Carbs"),
                                                ],
                                              ),
                                              sizedBoxHeight30,
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    sizedBoxHeight20,
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                  ),
                                  child: Container(
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      color: loginButtonColor,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Center(
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                              top: 8,
                                              bottom: 8,
                                            ),
                                            child: Text(
                                              "Your subscription will last\n until December 24 , 2023",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                        OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                              side: const BorderSide(
                                                  width: 2.0,
                                                  color: Colors.white)),
                                          onPressed: () {},
                                          child: Text(
                                            "Extend",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          sizedBoxHeight20,
                          Text(
                            "Current Week",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              shadows: textShadow,
                              color: Colors.white,
                              fontSize: 21.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "All your chosen meal this week.",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          sizedBoxHeight12,
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: GetBuilder<HomeController>(
                        init: HomeController(),
                        builder: (homeController) => Padding(
                          padding: edgeInsets0.copyWith(right: 0),
                          child: SizedBox(
                            height: 132.h,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: List.generate(
                                28,
                                (index) {
                                  DateTime date =
                                      DateTime.now().add(Duration(days: index));
                                  return calenderWidget(
                                      context,
                                      date.month.toString(),
                                      date.day.toString(),
                                      homeController.selectedDate.day ==
                                          date.day, () {
                                    () {};
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sizedBoxHeight20,
                          Text(
                            "Next Week",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              shadows: textShadow,
                              color: Colors.white,
                              fontSize: 21.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Chose your meal now for next week",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          sizedBoxHeight16,
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}