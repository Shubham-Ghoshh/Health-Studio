import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/auth_controller.dart';
import 'package:health_studio_user/core/controllers/language_controller.dart';
import 'package:health_studio_user/core/controllers/order_controller.dart';
import 'package:health_studio_user/core/controllers/plan_controller.dart';
import 'package:health_studio_user/core/controllers/setting_controller.dart';
import 'package:health_studio_user/core/models/plan.dart';
import 'package:health_studio_user/ui/screens/address_screen.dart';
import 'package:health_studio_user/ui/screens/authentication/login_screen.dart';
import 'package:health_studio_user/ui/screens/termsandconditions.dart';
import 'package:health_studio_user/ui/widgets/fridayalert.dart';
import 'package:health_studio_user/utils/buttons.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/formatters.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  String selectedItem = '1';
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlanController>(builder: (planController) {
      return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            // bottomNavigationBar: bottomNavigationBar(),
            body: Container(
              height: double.infinity,
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
                            IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                            // sizedBoxWidth25,
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
                          child: GetBuilder<LanguageTogglerController>(
                            builder: (languageController) => Text(
                              languageController.isEnglish
                                  ? planController.selectedPlan!.titleEn
                                  : planController.selectedPlan!.titleAr,
                              style: const TextStyle(
                                color: Color(0xffFFFDFD),
                                fontWeight: FontWeight.w600,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                        ...planController.packages
                            .map(
                              (e) => planItem(e),
                            )
                            .toList(),
                        !planController.customPlanCreated
                            ? customplan(
                                AppLocalizations.of(context)!.custom_plan)
                            : const SizedBox(),
                      ]),
                ),
              ),
            )),
      );
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
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          Container(
            height: 255.h,
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
                    children: [
                      sizedBoxHeight8,
                      Padding(
                        padding: edgeInsetsleft16,
                        child: GetBuilder<LanguageTogglerController>(
                          builder: (languageController) => Text(
                            languageController.isEnglish
                                ? package.titleEn
                                : package.titleAr,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                              color: plantextColor,
                            ),
                          ),
                        ),
                      ),
                      sizedBoxHeight6,
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
                                      "${package.meal} ${AppLocalizations.of(context)!.meals}",
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
                                      "${package.snack} ${AppLocalizations.of(context)!.snacks}",
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
                                  "${package.breakfast} ${AppLocalizations.of(context)!.breakfast}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    color: blackColor,
                                  ),
                                ),
                              ],
                            ),
                            sizedBoxHeight10,
                          ],
                        ),
                      ),
                      const Divider(
                        height: 1,
                        color: dividercolor,
                      ),
                      sizedBoxHeight8,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GetBuilder<PlanController>(builder: (planController) {
                            return GestureDetector(
                              onTap: () {
                                Get.find<OrderController>().duration = 7;
                                Get.find<OrderController>().price =
                                    package.sevenDays;
                                Get.find<OrderController>().order.amount =
                                    package.sevenDays;

                                Get.find<PlanController>().selectVariant(
                                  package,
                                  7,
                                  planController.meal,
                                  planController.breakfast,
                                  planController.snack,
                                );
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
                                        '1',
                                        style: TextStyle(
                                            color: pureblackColor,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18.sp),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.week,
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
                            );
                          }),
                          GetBuilder<PlanController>(builder: (planController) {
                            return GestureDetector(
                              onTap: () {
                                Get.find<OrderController>().duration = 14;
                                Get.find<OrderController>().price =
                                    package.fifteenDays;

                                Get.find<OrderController>().order.amount =
                                    package.fifteenDays;
                                Get.find<PlanController>().selectVariant(
                                  package,
                                  15,
                                  planController.meal,
                                  planController.breakfast,
                                  planController.snack,
                                );
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
                                        '2',
                                        style: TextStyle(
                                            color: pureblackColor,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18.sp),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.weeks,
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
                            );
                          }),
                          GetBuilder<PlanController>(builder: (planController) {
                            return GestureDetector(
                              onTap: () {
                                Get.find<OrderController>().duration = 30;
                                Get.find<OrderController>().price =
                                    package.thirtyDays;

                                Get.find<OrderController>().order.amount =
                                    package.thirtyDays;
                                Get.find<PlanController>().selectVariant(
                                  package,
                                  30,
                                  planController.meal,
                                  planController.breakfast,
                                  planController.snack,
                                );
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
                                        '1',
                                        style: TextStyle(
                                            color: pureblackColor,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18.sp),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.month,
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
                            );
                          })
                        ],
                      )
                    ],
                  ),
                ),
                package.isCustom
                    ? Padding(
                        padding:
                            const EdgeInsets.only(left: 0, right: 9, top: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            sizedBoxHeight10,
                            Image.asset("assets/images/Frame.png"),
                            IconButton(
                              onPressed: () {
                                Get.find<PlanController>()
                                    .packages
                                    .removeLast();
                                Get.find<PlanController>().customPlanCreated =
                                    false;
                                Get.find<PlanController>().update();
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: loginButtonColor,
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(
                        width: 80,
                        height: 240.h,
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
                                SvgPicture.asset(
                                  'assets/images/calorie.svg',
                                  height: 24,
                                ),
                                Text(
                                  package.attributes
                                          ?.firstWhere(
                                            (element) =>
                                                element.titleEn == "Calorie",
                                            orElse: () => null,
                                          )
                                          ?.value ??
                                      "-",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w900,
                                      color: whiteColor),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.approx,
                                  style: TextStyle(
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w300,
                                    color: whiteColor,
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.calorie,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w300,
                                    color: whiteColor,
                                  ),
                                ),
                              ],
                            ),
                            sizedBoxHeight4,
                            Column(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/protein.svg',
                                  height: 24,
                                ),
                                Text(
                                  package.attributes
                                          ?.firstWhere(
                                              (element) =>
                                                  element.titleEn == "Protein",
                                              orElse: () => null)
                                          ?.value ??
                                      "-",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w900,
                                      color: whiteColor),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.approx,
                                  style: TextStyle(
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w300,
                                    color: whiteColor,
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.protein,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w300,
                                    color: whiteColor,
                                  ),
                                )
                              ],
                            ),
                            sizedBoxHeight4,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/carbs.svg',
                                  color: Colors.white,
                                  height: 24,
                                ),
                                Text(
                                  package.attributes
                                          ?.firstWhere(
                                              (element) =>
                                                  element.titleEn == "Carbs",
                                              orElse: () => null)
                                          ?.value ??
                                      "-",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w900,
                                      color: whiteColor),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.approx,
                                  style: TextStyle(
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w300,
                                    color: whiteColor,
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.carbs,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w300,
                                    color: whiteColor,
                                  ),
                                ),
                                sizedBoxHeight25,
                              ],
                            ),
                          ],
                        ),
                      )
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: edgeInsets8.copyWith(
                  left: 16.w,
                  right: 16.w,
                ),
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
                        if (Get.find<AuthController>().isLoggedIn) {
                          OrderController orderController =
                              Get.find<OrderController>();
                          SettingsController settingsController =
                              Get.find<SettingsController>();
                          PlanController planController =
                              Get.find<PlanController>();
                          planController.selectVariant(
                            package,
                            planController.days,
                            planController.meal,
                            planController.breakfast,
                            planController.snack,
                          );

                          if (settingsController.userDetails != null) {
                            if (settingsController.userDetails!.orderTo !=
                                    null &&
                                settingsController.userDetails!.orderTo != "") {
                              orderController.order.startDate =
                                  DateFormat("dd-MM-yyyy").format(getDateFormat(
                                          settingsController
                                              .userDetails!.orderTo,
                                          split: false)
                                      .add(const Duration(days: 1)));
                              orderController.firstDate = getDateFormat(
                                  settingsController.userDetails!.orderTo,
                                  split: false);
                            } else {
                              orderController.order.startDate =
                                  DateFormat("dd-MM-yyyy").format(
                                DateTime.now().add(
                                  const Duration(days: 3),
                                ),
                              );
                              orderController.firstDate = DateTime.now().add(
                                const Duration(days: 3),
                              );
                            }
                          } else {
                            orderController.order.startDate =
                                DateFormat("dd-MM-yyyy").format(
                              DateTime.now().add(
                                const Duration(days: 3),
                              ),
                            );
                            orderController.firstDate = DateTime.now().add(
                              const Duration(days: 3),
                            );
                          }
                          orderController.price =
                              orderController.order.amount ?? package.sevenDays;

                          orderController.order.amount =
                              orderController.order.amount ?? package.sevenDays;
                          if (package.selected == 7) {
                            orderController.order.amount = package.sevenDays;
                            orderController.price = package.sevenDays;
                          } else if (package.selected == 15) {
                            orderController.order.amount = package.fifteenDays;
                            orderController.price = package.fifteenDays;
                          } else if (package.selected == 30) {
                            orderController.price = package.thirtyDays;

                            orderController.order.amount = package.thirtyDays;
                          }
                          orderController.order.packageId = package.id;

                          orderController.order.endDate =
                              DateFormat("dd-MM-yyyy").format(
                            getDateFormat(orderController.order.startDate!).add(
                              Duration(
                                days: (orderController.duration - 1),
                              ),
                            ),
                          );
                          orderController.order.meal = orderController.meal;
                          orderController.order.breakfast =
                              orderController.breakfast;
                          orderController.order.snack = orderController.snack;
                          orderController.order.isCustom =
                              Get.find<PlanController>()
                                      .selectedPackage
                                      ?.isCustom ??
                                  false;

                          Get.to(() => const TermsandConditions(
                                showAddress: true,
                              ));
                          fridayAlertDialog();
                        } else {
                          Get.to(() => LoginPage(
                                onSuccess: () {
                                  Get.back();
                                  Get.to(() => const TermsandConditions(
                                        showAddress: true,
                                      ));
                                  fridayAlertDialog();
                                },
                              ));
                        }
                      },
                      child: Container(
                        padding: edgeInsets16.copyWith(top: 10, bottom: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: whiteColor)),
                        child: Text(
                          Get.find<AuthController>().isLoggedIn
                              ? AppLocalizations.of(context)!.order_now
                              : AppLocalizations.of(context)!.login_to_order,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  String getText(Package package) {
    switch (package.selected) {
      case 7:
        return "KD ${package.sevenDays} / 1 ${AppLocalizations.of(context)!.week}";
      case 15:
        return "KD ${package.fifteenDays} / 2 ${AppLocalizations.of(context)!.weeks}";
      case 30:
        return "KD ${package.thirtyDays} / 1 ${AppLocalizations.of(context)!.month}";
      default:
        return "KD ${package.sevenDays} / 1 ${AppLocalizations.of(context)!.week}";
    }
  }

  Widget customplan(String plantitle) {
    return GetBuilder<PlanController>(builder: (planController) {
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
                        padding:
                            const EdgeInsets.only(left: 0, right: 9, top: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            sizedBoxHeight10,
                            Image.asset("assets/images/Frame.png"),
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
            GestureDetector(
              onTap: () {
                planController.packages.add(
                  Package(
                    titleAr: "خطة مخصصة",
                    titleEn: "Custom Plan",
                    descriptionAr: "",
                    descriptionEn: "",
                    breakfast: planController.breakfast,
                    fifteenDays: planController.fifteenDays,
                    meal: planController.meal,
                    sevenDays: planController.sevenDays,
                    snack: planController.snack,
                    thirtyDays: planController.thirtyDays,
                    isCustom: true,
                  ),
                );
                planController.customPlanCreated = true;
                planController.update();
              },
              child: Container(
                height: 42.h,
                width: 207.w,
                decoration: BoxDecoration(
                  color: loginButtonColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.create,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                        color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

class MealWidget extends StatefulWidget {
  const MealWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MealWidget> createState() => _MealWidgetState();
}

class _MealWidgetState extends State<MealWidget> {
  List<String> meals = ['1', '2', '3', '4', '5'];
  List<String> snacks = ['0', '1', '2', '3', '4', '5'];
  List<String> breakfast = ['0', '1', '2', '3', '4', '5'];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      return GetBuilder<PlanController>(builder: (planController) {
        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Image.asset(
                      //   'assets/images/planimage.png',
                      //   height: 20.h,
                      // ),
                      sizedBoxwidth8,
                      Row(
                        children: [
                          Container(
                            height: 26.h,
                            width: 50,
                            color: customcolor.withOpacity(0.1),
                            child: Center(
                              child: DropdownButton<String>(
                                underline: Container(),
                                value: planController.meal,
                                items: meals
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Center(
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (val) {
                                  orderController.meal = val.toString();
                                  planController.meal = val.toString();
                                  planController.calculatePrice(7);
                                  planController.calculatePrice(15);
                                  planController.calculatePrice(30);
                                  planController.update();
                                  orderController.update();
                                },
                              ),
                            ),
                          ),
                          sizedBoxwidth8,
                          Text(
                            AppLocalizations.of(context)!.meals,
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
                  Row(
                    children: [
                      sizedBoxwidth8,
                      Container(
                        height: 26.h,
                        width: 50,
                        color: customcolor.withOpacity(0.1),
                        child: Center(
                          child: DropdownButton<String>(
                            underline: Container(),
                            value: planController.snack,
                            items: snacks
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Center(
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              orderController.snack = val.toString();
                              planController.snack = val.toString();
                              planController.calculatePrice(7);
                              planController.calculatePrice(15);
                              planController.calculatePrice(30);
                              planController.update();
                              orderController.update();
                            },
                          ),
                        ),
                      ),
                      sizedBoxwidth8,
                      Text(AppLocalizations.of(context)!.snacks,
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
                  sizedBoxwidth8,
                  Container(
                    height: 26.h,
                    width: 50,
                    color: customcolor.withOpacity(0.1),
                    child: Center(
                      child: DropdownButton<String>(
                        underline: Container(),
                        value: planController.breakfast,
                        items: breakfast
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Center(
                                    child: Text(
                                      item,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (val) {
                          orderController.breakfast = val.toString();
                          planController.breakfast = val.toString();
                          planController.calculatePrice(7);
                          planController.calculatePrice(15);
                          planController.calculatePrice(30);
                          planController.update();
                          orderController.update();
                        },
                      ),
                    ),
                  ),
                  sizedBoxwidth8,
                  Text(AppLocalizations.of(context)!.breakfast,
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
      });
    });
  }
}

class PricingRow extends StatelessWidget {
  const PricingRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlanController>(builder: (planController) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: edgeInsets8,
              child: Column(
                children: [
                  Text(
                    "1",
                    style: TextStyle(
                        color: pureblackColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 18.sp),
                  ),
                  Text(
                    AppLocalizations.of(context)!.week,
                    style: TextStyle(
                        color: pureblackColor,
                        fontWeight: FontWeight.w300,
                        fontSize: 12.sp),
                  ),
                  Text(
                    "KD: ${planController.sevenDays}",
                    style: TextStyle(
                      color: loginButtonColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.sp,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: edgeInsets8,
            child: Column(
              children: [
                Text(
                  '2',
                  style: TextStyle(
                      color: pureblackColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 18.sp),
                ),
                Text(
                  AppLocalizations.of(context)!.weeks,
                  style: TextStyle(
                      color: pureblackColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 12.sp),
                ),
                Text(
                  "KD: ${planController.fifteenDays}",
                  style: TextStyle(
                    color: loginButtonColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.sp,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: edgeInsets8,
            child: Column(
              children: [
                Text(
                  '1',
                  style: TextStyle(
                      color: pureblackColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 18.sp),
                ),
                Text(
                  AppLocalizations.of(context)!.month,
                  style: TextStyle(
                      color: pureblackColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 12.sp),
                ),
                Text(
                  "KD: ${planController.thirtyDays}",
                  style: TextStyle(
                    color: loginButtonColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.sp,
                  ),
                )
              ],
            ),
          ),
        ],
      );
    });
  }
}
