import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/auth_controller.dart';
import 'package:health_studio_user/core/controllers/plan_controller.dart';
import 'package:health_studio_user/core/models/plan.dart';
import 'package:health_studio_user/ui/screens/address_screen.dart';
import 'package:health_studio_user/ui/screens/authentication/login_screen.dart';
import 'package:health_studio_user/ui/widgets/bottom_navigation_bar.dart';
import 'package:health_studio_user/utils/buttons.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlanController>(builder: (planController) {
      return Scaffold(
          bottomNavigationBar: bottomNavigationBar(),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 242,
                            // height: 57,
                            child: Image.asset(
                                "assets/images/health_studio_logo.png"),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 22.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: settingsBackground,
                                  ),
                                  child: SettingButton(),
                                ),
                              ),
                              sizedBoxwidth8,
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: edgeInsets22.copyWith(left: 16.w),
                        child: Text(
                          planController.selectedPlan!.titleEn,
                          style: const TextStyle(
                            color: Color(0xffFFFDFD),
                            fontWeight: FontWeight.w600,
                            fontSize: 28,
                          ),
                        ),
                      ),
                      ...planController.packages
                          .map(
                            (e) => planItem(e),
                          )
                          .toList(),
                      customplan('Custom Plan', "3", "1", "1"),
                    ]),
              ),
            ),
          ));
    });
  }

  Widget planItem(
    Package package,
  ) {
    return Padding(
      padding: edgeInsets16,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 20,
            left: 0,
            top: 0,
            right: 0,
            child: Container(
              height: 1000,
              width: 1000,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          Container(
            height: 220.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      sizedBoxHeight8,
                      Padding(
                        padding: edgeInsetsleft16,
                        child: Text(
                          package.titleEn,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            color: plantextColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/planimage.png',
                                      height: 20.h,
                                    ),
                                    sizedBoxwidth8,
                                    Text(
                                      "${package.meal} Meals",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        color: blackColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/planimage.png',
                                      height: 20.h,
                                    ),
                                    sizedBoxwidth8,
                                    Text(
                                      "${package.snack} Snacks",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        color: blackColor,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            sizedBoxHeight14,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/planimage.png',
                                  height: 20.h,
                                ),
                                sizedBoxwidth8,
                                Text(
                                  "${package.breakfast} Breakfast",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    color: blackColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 1,
                        color: dividercolor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.find<PlanController>()
                                  .selectVariant(package.id, 7);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: package.selected == 7
                                      ? loginButtonColor
                                      : whiteColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: edgeInsets8,
                                child: Column(
                                  children: [
                                    Text(
                                      '07',
                                      style: TextStyle(
                                          color: pureblackColor,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18.sp),
                                    ),
                                    Text(
                                      'Days',
                                      style: TextStyle(
                                          color: pureblackColor,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12.sp),
                                    ),
                                    Text(
                                      'KD : ${package.sevenDays}',
                                      style: TextStyle(
                                          color: package.selected == 7
                                              ? whiteColor
                                              : loginButtonColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.find<PlanController>()
                                  .selectVariant(package.id, 15);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: package.selected == 15
                                    ? loginButtonColor
                                    : whiteColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: edgeInsets8,
                                child: Column(
                                  children: [
                                    Text(
                                      '15',
                                      style: TextStyle(
                                          color: pureblackColor,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18.sp),
                                    ),
                                    Text(
                                      'Days',
                                      style: TextStyle(
                                          color: pureblackColor,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12.sp),
                                    ),
                                    Text(
                                      'KD : ${package.fifteenDays}',
                                      style: TextStyle(
                                          color: package.selected == 15
                                              ? whiteColor
                                              : loginButtonColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.find<PlanController>()
                                  .selectVariant(package.id, 30);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: package.selected == 30
                                      ? loginButtonColor
                                      : whiteColor),
                              child: Padding(
                                padding: edgeInsets8,
                                child: Column(
                                  children: [
                                    Text(
                                      '30',
                                      style: TextStyle(
                                          color: pureblackColor,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18.sp),
                                    ),
                                    Text(
                                      'Days',
                                      style: TextStyle(
                                          color: pureblackColor,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12.sp),
                                    ),
                                    Text(
                                      'KD : ${package.thirtyDays}',
                                      style: TextStyle(
                                          color: package.selected == 30
                                              ? whiteColor
                                              : loginButtonColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: 56.w,
                  height: 210.h,
                  decoration: const BoxDecoration(
                    color: itemsbackground,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(6),
                        bottomRight: Radius.circular(6)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      sizedBoxHeight6,
                      Column(
                        children: [
                          SvgPicture.asset('assets/images/calorie.svg'),
                          sizedBoxHeight6,
                          Text(
                            '250',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w900,
                                color: whiteColor),
                          ),
                          Text(
                            'Calorie',
                            style: TextStyle(
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w300,
                                color: whiteColor),
                          )
                        ],
                      ),
                      sizedBoxHeight6,
                      Column(
                        children: [
                          SvgPicture.asset('assets/images/protein.svg'),
                          sizedBoxHeight6,
                          Text(
                            '250',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w900,
                                color: whiteColor),
                          ),
                          Text(
                            'Protein',
                            style: TextStyle(
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w300,
                                color: whiteColor),
                          )
                        ],
                      ),
                      sizedBoxHeight6,
                      Column(
                        children: [
                          SvgPicture.asset('assets/images/fat.svg'),
                          sizedBoxHeight6,
                          Text(
                            '250',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w900,
                                color: whiteColor),
                          ),
                          Text(
                            'Fat',
                            style: TextStyle(
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w300,
                                color: whiteColor),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: edgeInsets8.copyWith(left: 16.w, right: 16.w),
            margin: edgeInsets16.copyWith(top: 0, bottom: 0),
            // height: 42.h,
            // width: 207.w,
            decoration: BoxDecoration(
              color: loginButtonColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Text(
                    getText(package),
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                        color: Colors.white),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.find<AuthController>().isLoggedIn
                        ? Get.to(() => const Address())
                        : Get.to(() => LoginPage(
                              onSuccess: () {
                                Get.back();
                                Get.to(
                                  () => const Address(),
                                );
                              },
                            ));
                  },
                  child: Container(
                    padding: edgeInsets16.copyWith(top: 8, bottom: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: whiteColor)),
                    child: Text(
                      Get.find<AuthController>().isLoggedIn
                          ? "Order Now"
                          : "Login to Order",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String getText(Package package) {
    switch (package.selected) {
      case 7:
        return "KD ${package.sevenDays} / 07 Days";
      case 15:
        return "KD ${package.fifteenDays} / 15 Days";
      case 30:
        return "KD ${package.thirtyDays} / 30 Days";
      default:
        return "KD ${package.sevenDays} / 07 Days";
    }
  }

  Widget customplan(
      String plantitle, String meals, String snacks, String breakfast) {
    return Padding(
      padding: edgeInsets16,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 20,
            left: 0,
            top: 0,
            right: 0,
            child: Container(
              height: 1000,
              width: 1000,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          Container(
            height: 235.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          sizedBoxHeight6,
                          Padding(
                            padding: edgeInsetsleft16,
                            child: Text(
                              plantitle,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                                color: plantextColor,
                              ),
                            ),
                          ),
                          sizedBoxHeight10,
                          const MealWidget(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 9, top: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          sizedBoxHeight10,
                          Image.asset("assets/images/Frame.png")
                        ],
                      ),
                    )
                  ],
                ),
                const Divider(
                  height: 1,
                  color: dividercolor,
                  thickness: 1,
                ),
                const PricingRow(),
                sizedBoxHeight6,
                sizedBoxHeight10,
                sizedBoxHeight16,
              ],
            ),
          ),
          Container(
            height: 42.h,
            width: 207.w,
            decoration: BoxDecoration(
              color: const Color(0xffF1773E),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                'CREATE',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                    color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MealWidget extends StatelessWidget {
  const MealWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/planimage.png',
                    height: 20.h,
                  ),
                  sizedBoxwidth8,
                  Row(
                    children: [
                      Container(
                        height: 26.h,
                        width: 26.w,
                        color: customcolor.withOpacity(0.1),
                        child: Center(
                          child: Text(
                            "3",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              color: blackColor,
                            ),
                          ),
                        ),
                      ),
                      sizedBoxwidth8,
                      Text('Meals',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: blackColor,
                          ))
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/planimage.png',
                    height: 20.h,
                  ),
                  sizedBoxwidth8,
                  Container(
                    height: 26.h,
                    width: 26.w,
                    color: customcolor.withOpacity(0.1),
                    child: Center(
                      child: Text(
                        "3",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: blackColor,
                        ),
                      ),
                    ),
                  ),
                  sizedBoxwidth8,
                  Text('Snacks',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: blackColor,
                      ))
                ],
              ),
            ],
          ),
          sizedBoxHeight14,
          Row(
            children: [
              Image.asset(
                'assets/images/planimage.png',
                height: 20.h,
              ),
              sizedBoxwidth8,
              Container(
                height: 26.h,
                width: 26.w,
                color: customcolor.withOpacity(0.1),
                child: Center(
                  child: Text(
                    "3",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: blackColor,
                    ),
                  ),
                ),
              ),
              sizedBoxwidth8,
              Text('Breakfast',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: blackColor,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

class PricingRow extends StatelessWidget {
  const PricingRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          decoration: BoxDecoration(
              color: loginButtonColor, borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: edgeInsets8,
            child: Column(
              children: [
                Text(
                  '07',
                  style: TextStyle(
                      color: pureblackColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 18.sp),
                ),
                Text(
                  'Days',
                  style: TextStyle(
                      color: pureblackColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: edgeInsets8,
          child: Column(
            children: [
              Text(
                '15',
                style: TextStyle(
                    color: pureblackColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 18.sp),
              ),
              Text(
                'Days',
                style: TextStyle(
                    color: pureblackColor,
                    fontWeight: FontWeight.w300,
                    fontSize: 12.sp),
              ),
            ],
          ),
        ),
        Padding(
          padding: edgeInsets8,
          child: Column(
            children: [
              Text(
                '30',
                style: TextStyle(
                    color: pureblackColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 18.sp),
              ),
              Text(
                'Days',
                style: TextStyle(
                    color: pureblackColor,
                    fontWeight: FontWeight.w300,
                    fontSize: 12.sp),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
