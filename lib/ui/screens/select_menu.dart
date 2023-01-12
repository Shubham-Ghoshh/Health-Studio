import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_studio_user/ui/widgets/app_bar.dart';
import 'package:health_studio_user/ui/widgets/bottom_navigation_bar.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';

class SelectMenuPage extends StatefulWidget {
  const SelectMenuPage({Key? key}) : super(key: key);

  @override
  State<SelectMenuPage> createState() => _SelectMenuPageState();
}

class _SelectMenuPageState extends State<SelectMenuPage> {
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
                    sizedBoxHeight6,
                    appbarWithSetting(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sizedBoxHeight6,
                          Text(
                            "Chose a meal",
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w600,
                              shadows: textShadow,
                            ),
                          ),
                          sizedBoxHeight12,
                          selectMealBox(
                            loginButtonColor,
                            "Meal",
                            "2",
                            [
                              selectMealBoxText(
                                "Meal 1",
                                "Turkey Omelette - Breakfast",
                              ),
                              const Divider(
                                color: Color.fromARGB(96, 0, 0, 0),
                              ),
                              selectMealBoxText(
                                "Meal 2",
                                "Turkey Omelette - Breakfast",
                              ),
                            ],
                          ),
                          sizedBoxHeight25,
                          selectMealBox(
                            activeIconColor,
                            "Snack",
                            "1",
                            [
                              selectMealBoxText(
                                "Snack 1",
                                "Carrot - Cake",
                              ),
                            ],
                          ),
                          sizedBoxHeight25,
                          selectMealBox(
                            itemsbackground,
                            "Breakfast",
                            "1",
                            [
                              selectMealBoxText(
                                "Breakfast 1",
                                "Carrot - Cake",
                              ),
                            ],
                          ),
                          sizedBoxHeight35,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Stack selectMealBox(Color topBoxColor, String foodType, String foodCount,
      List<Widget> selectTextWidgets) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              sizedBoxHeight25,
              Container(
                padding: edgeInsets16,
                decoration: BoxDecoration(
                  boxShadow: defaultBoxShadow,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedBoxHeight30,
                    Column(
                      children: selectTextWidgets,
                    ),
                    sizedBoxHeight8,
                  ],
                ),
              ),
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
              height: 52.h,
              decoration: BoxDecoration(
                color: topBoxColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                        left: 14,
                      ),
                      child: Text(
                        foodType,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: whiteColor,
                        boxShadow: defaultBoxShadow,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          foodCount,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: blackColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row selectMealBoxText(String mealNumber, String mealName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0, bottom: 14),
          child: Text(
            mealNumber,
            style: TextStyle(
              color: inactiveDayFontColor,
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
            ),
          ),
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  mealName,
                  style: TextStyle(
                    color: const Color(0xff0A0909),
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Set Random By System",
                      style: TextStyle(
                        color: const Color(0xffC19C7D),
                        fontWeight: FontWeight.w400,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(Icons.arrow_forward_ios_sharp),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
