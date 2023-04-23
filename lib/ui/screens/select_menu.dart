import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/userDashboardController.dart';
import 'package:health_studio_user/core/models/user_dashboard.dart';
import 'package:health_studio_user/ui/widgets/app_bar.dart';
import 'package:health_studio_user/utils/buttons.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectMenuPage extends StatelessWidget {
  final bool allowEdit;
  final bool showSaveButton;
  final String date;
  final String readableDate;
  final bool isUpdate;
  const SelectMenuPage({
    super.key,
    required this.date,
    this.showSaveButton = true,
    this.allowEdit = true,
    this.isUpdate = false,
    required this.readableDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // bottomNavigationBar: bottomNavigationBar(),
        body: GetBuilder<UserDashboardController>(
            builder: (userDashboardController) {
      return Stack(
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

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${AppLocalizations.of(context)!.choose_meal} ",
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w600,
                                shadows: textShadow,
                              ),
                            ),
                            Text(
                              readableDate,
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w600,
                                shadows: textShadow,
                              ),
                            ),
                          ],
                        ),

                        sizedBoxHeight12,
                        selectMealBox(
                          activeIconColor,
                          AppLocalizations.of(context)!.breakfast,
                          userDashboardController.packageDetail?.breakfast ??
                              "0",
                          List.generate(
                            // int.tryParse(userDashboardController
                            //             .packageDetail?.breakfast ??
                            //         "0") ??
                            0,
                            (index) {
                              log("INDEX breakfast $index");
                              int breakfastIndex = userDashboardController
                                  .mealItems
                                  .indexWhere((e) => e?.key == "breakfast");
                              int length = breakfastIndex == -1
                                  ? 0
                                  : userDashboardController
                                          .mealItems[breakfastIndex]
                                          ?.items
                                          .length ??
                                      0;

                              String title = length > index
                                  ? (userDashboardController
                                          .mealItems[breakfastIndex]
                                          ?.items[index]
                                          ?.meal
                                          ?.nameEn) ??
                                      (!allowEdit
                                          ? AppLocalizations.of(context)!
                                              .meal_selected
                                          : AppLocalizations.of(context)!
                                              .choose_meal)
                                  : !allowEdit
                                      ? AppLocalizations.of(context)!
                                          .meal_selected
                                      : AppLocalizations.of(context)!
                                          .choose_meal;
                              return Column(
                                children: [
                                  selectMealBoxText(
                                    "${AppLocalizations.of(context)!.breakfast} ${index + 1}",
                                    title,
                                    "breakfast",
                                    date,
                                    userDashboardController
                                        .selectedDashboardItem,
                                    allowEdit: allowEdit,
                                    itemIndex: index,
                                  ),
                                  const Divider(
                                    color: Color.fromARGB(95, 0, 0, 0),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        sizedBoxHeight25,
                        selectMealBox(
                          loginButtonColor,
                          AppLocalizations.of(context)!.meal,
                          userDashboardController.packageDetail?.meal ?? "0",
                          List.generate(
                            int.tryParse(userDashboardController
                                        .packageDetail?.meal ??
                                    "0") ??
                                0,
                            (index) {
                              log("INDEX meal $index");

                              int mealIndex = userDashboardController.mealItems
                                  .indexWhere((e) => e?.key == "meal");
                              int length = mealIndex == -1
                                  ? 0
                                  : userDashboardController
                                          .mealItems[mealIndex]?.items.length ??
                                      0;

                              String title = length > index
                                  ? (userDashboardController
                                          .mealItems[mealIndex]
                                          ?.items[index]
                                          ?.meal
                                          ?.nameEn) ??
                                      (!allowEdit
                                          ? AppLocalizations.of(context)!
                                              .meal_selected
                                          : AppLocalizations.of(context)!
                                              .choose_meal)
                                  : !allowEdit
                                      ? AppLocalizations.of(context)!
                                          .meal_selected
                                      : AppLocalizations.of(context)!
                                          .choose_meal;

                              return Column(
                                key: Key(index.toString()),
                                children: [
                                  selectMealBoxText(
                                    "${AppLocalizations.of(context)!.meal} ${index + 1}",
                                    title,
                                    "meal",
                                    date,
                                    userDashboardController
                                        .selectedDashboardItem,
                                    allowEdit: allowEdit,
                                    itemIndex: index,
                                  ),
                                  const Divider(
                                    color: Color.fromARGB(95, 0, 0, 0),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        sizedBoxHeight25,
                        selectMealBox(
                          itemsbackground,
                          AppLocalizations.of(context)!.snack,
                          userDashboardController.packageDetail?.snack ?? "0",
                          List.generate(
                              int.tryParse(userDashboardController
                                          .packageDetail?.snack ??
                                      "0") ??
                                  0, (index) {
                            log("INDEX snack $index");

                            int snackIndex = userDashboardController.mealItems
                                .indexWhere((e) => e?.key == "snack");
                            int length = snackIndex == -1
                                ? 0
                                : userDashboardController
                                        .mealItems[snackIndex]?.items.length ??
                                    0;

                            String title = length > index
                                ? (userDashboardController.mealItems[snackIndex]
                                        ?.items[index]?.meal?.nameEn) ??
                                    (!allowEdit
                                        ? AppLocalizations.of(context)!
                                            .meal_selected
                                        : AppLocalizations.of(context)!
                                            .choose_meal)
                                : !allowEdit
                                    ? AppLocalizations.of(context)!
                                        .meal_selected
                                    : AppLocalizations.of(context)!.choose_meal;
                            return Column(
                              children: [
                                selectMealBoxText(
                                  "${AppLocalizations.of(context)!.snack} ${index + 1}",
                                  title,
                                  "snack",
                                  date,
                                  userDashboardController.selectedDashboardItem,
                                  allowEdit: allowEdit,
                                  itemIndex: index,
                                ),
                                const Divider(
                                  color: Color.fromARGB(95, 0, 0, 0),
                                ),
                              ],
                            );
                          }),
                        ),
                        // sizedBoxHeight8,
                        Visibility(
                          visible: showSaveButton,
                          child: Column(
                            children: [
                              sizedBoxHeight12,
                              Visibility(
                                visible: userDashboardController
                                        .packageDetail?.categoryId ==
                                    "1",
                                child: Text(
                                    "${AppLocalizations.of(context)!.amount_paid}: ${userDashboardController.tempPrice} KD"),
                              ),
                              sizedBoxHeight12,
                              TextButton(
                                onPressed: () => throw Exception(),
                                child: const Text("Throw Test Exception"),
                              ),
                              LoginButton(
                                onTap: () {
                                  userDashboardController.getMealPaymentLink(
                                    userDashboardController
                                        .selectedDashboardItem,
                                  );
                                },
                                enabled: userDashboardController.allMealsAdded,
                                title: isUpdate
                                    ? AppLocalizations.of(context)!.update_meals
                                    : AppLocalizations.of(context)!.save_all,
                                height: 50,
                              ),
                            ],
                          ),
                        ),
                        sizedBoxHeight12,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }));
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
                      children: selectTextWidgets.isEmpty
                          ? [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, bottom: 14),
                                      child: Text(
                                        "No Items",
                                        style: TextStyle(
                                          color: inactiveDayFontColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                    ),
                                  ])
                            ]
                          : selectTextWidgets,
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

  Widget selectMealBoxText(String mealNumber, String mealName, String type,
      String date, DashboardItem? item,
      {bool allowEdit = true, int itemIndex = 0}) {
    return GestureDetector(
      onTap: allowEdit
          ? () {
              Get.find<UserDashboardController>()
                  .getMenuByTypeAndDate(type, date, item, itemIndex: itemIndex);
            }
          : null,
      child: Row(
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
          const Spacer(),
          Flexible(
            fit: FlexFit.tight,
            child: Text(
              mealName,
              style: TextStyle(
                color: const Color(0xff0A0909),
                fontWeight: FontWeight.w400,
                fontSize: 13.sp,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: GestureDetector(
              onTap: allowEdit
                  ? () {
                      Get.find<UserDashboardController>().getMenuByTypeAndDate(
                          type, date, item,
                          itemIndex: itemIndex);
                    }
                  : null,
              child: const Icon(Icons.arrow_forward_ios_sharp),
            ),
          ),
        ],
      ),
    );
  }
}
