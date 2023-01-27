import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/userDashboardController.dart';
import 'package:health_studio_user/core/models/user_dashboard.dart';
import 'package:health_studio_user/ui/widgets/app_bar.dart';
import 'package:health_studio_user/utils/buttons.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:health_studio_user/utils/spacing.dart';

class SelectMenuPage extends StatelessWidget {
  final bool showSaveButton;
  final String date;
  final DashboardItem item;
  const SelectMenuPage({
    super.key,
    required this.date,
    required this.item,
    this.showSaveButton = true,
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
                        Text(
                          AppLocalizations.of(context)!.choose_meal,
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600,
                            shadows: textShadow,
                          ),
                        ),
                        sizedBoxHeight12,
                        selectMealBox(
                          loginButtonColor,
                          AppLocalizations.of(context)!.meal,
                          userDashboardController.packageDetail!.meal,
                          List.generate(
                            int.tryParse(userDashboardController
                                    .packageDetail!.meal) ??
                                0,
                            (index) {
                              int mealIndex = userDashboardController.mealItems
                                  .indexWhere((e) => e.key == "meal");
                              int length = userDashboardController
                                  .mealItems[mealIndex].items.length;

                              String title = length > index
                                  ? userDashboardController.mealItems[mealIndex]
                                      .items[index].meal.nameEn
                                  : AppLocalizations.of(context)!.choose_meal;

                              return Column(
                                key: Key(index.toString()),
                                children: [
                                  selectMealBoxText(
                                    "${AppLocalizations.of(context)!.meal} ${index + 1}",
                                    title,
                                    AppLocalizations.of(context)!.meal,
                                    date,
                                    context,
                                    item,
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
                          activeIconColor,
                          AppLocalizations.of(context)!.snack,
                          userDashboardController.packageDetail!.snack,
                          List.generate(
                              int.tryParse(userDashboardController
                                      .packageDetail!.snack) ??
                                  0, (index) {
                            int snackIndex = userDashboardController.mealItems
                                .indexWhere((e) =>
                                    e.key ==
                                    AppLocalizations.of(context)!.snack);
                            int length = userDashboardController
                                .mealItems[snackIndex].items.length;

                            String title = length > index
                                ? userDashboardController.mealItems[snackIndex]
                                    .items[index].meal.nameEn
                                : AppLocalizations.of(context)!.choose_meal;
                            return Column(
                              children: [
                                selectMealBoxText(
                                    "${AppLocalizations.of(context)!.snack} ${index + 1}",
                                    title,
                                    AppLocalizations.of(context)!.snack,
                                    date,
                                    context,
                                    item),
                                const Divider(
                                  color: Color.fromARGB(95, 0, 0, 0),
                                ),
                              ],
                            );
                          }),
                        ),
                        sizedBoxHeight25,
                        selectMealBox(
                          itemsbackground,
                          AppLocalizations.of(context)!.breakfast,
                          userDashboardController.packageDetail!.breakfast,
                          List.generate(
                            int.tryParse(userDashboardController
                                    .packageDetail!.breakfast) ??
                                0,
                            (index) {
                              int breakfastIndex = userDashboardController
                                  .mealItems
                                  .indexWhere((e) =>
                                      e.key ==
                                      AppLocalizations.of(context)!.breakfast);
                              int length = userDashboardController
                                  .mealItems[breakfastIndex].items.length;

                              String title = length > index
                                  ? userDashboardController
                                      .mealItems[breakfastIndex]
                                      .items[index]
                                      .meal
                                      .nameEn
                                  : AppLocalizations.of(context)!.choose_meal;
                              return Column(
                                children: [
                                  selectMealBoxText(
                                    "${AppLocalizations.of(context)!.breakfast} ${index + 1}",
                                    title,
                                    AppLocalizations.of(context)!.breakfast,
                                    date,
                                    context,
                                    item,
                                  ),
                                  const Divider(
                                    color: Color.fromARGB(95, 0, 0, 0),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        // sizedBoxHeight8,
                        Visibility(
                          visible: showSaveButton,
                          child: LoginButton(
                            onTap: () {
                              userDashboardController.getMealPaymentLink(item);
                            },
                            enabled: !(userDashboardController
                                    .mealItems[0].items.isEmpty ||
                                userDashboardController
                                    .mealItems[1].items.isEmpty ||
                                userDashboardController
                                    .mealItems[2].items.isEmpty),
                            title: AppLocalizations.of(context)!.save_all,
                            height: 50,
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

  Widget selectMealBoxText(
    String mealNumber,
    String mealName,
    String type,
    String date,
    BuildContext context,
    DashboardItem item,
  ) {
    return GestureDetector(
      onTap: () {
        Get.find<UserDashboardController>()
            .getMenuByTypeAndDate(type, date, item);
      },
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
                  Visibility(
                    visible: item.menuEn == "RANDOM MENU",
                    child: Text(
                      AppLocalizations.of(context)!.set_random,
                      style: TextStyle(
                        color: const Color(0xffC19C7D),
                        fontWeight: FontWeight.w400,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: GestureDetector(
                  onTap: () {
                    Get.find<UserDashboardController>()
                        .getMenuByTypeAndDate(type, date, item);
                  },
                  child: const Icon(Icons.arrow_forward_ios_sharp),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
