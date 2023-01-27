import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:health_studio_user/core/controllers/language_controller.dart';
import 'package:health_studio_user/core/controllers/menu_controller.dart';
import 'package:health_studio_user/core/controllers/plan_controller.dart';
import 'package:health_studio_user/core/controllers/userDashboardController.dart';
import 'package:health_studio_user/core/models/meal.dart';
import 'package:health_studio_user/core/models/user_dashboard.dart';
import 'package:health_studio_user/utils/buttons.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    required this.meal,
    required this.height,
    required this.item,
    required this.type,
    this.itemIndex = 0,
    Key? key,
  }) : super(key: key);

  final Meal meal;
  final double height;
  final DashboardItem item;
  final String type;
  final int itemIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Get.put(MenuController()).getMenuDetail(meal.id);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SizedBox(
              child: Stack(children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Hero(
                      tag: "food-image-${meal.image}",
                      child: CachedNetworkImage(
                        imageUrl: meal.image,
                        height: height,
                        width: 150,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            color: activeDateBgColor,
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 280,
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: const Icon(Icons.error),
                        ),
                      ),
                    )),
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: plantextColor,
                          context: context,
                          builder: (context) {
                            return GetBuilder<UserDashboardController>(
                                builder: (userDashboardController) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      textInputAction: TextInputAction.done,
                                      maxLines: 4,
                                      cursorColor: Colors.black,
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                      decoration: InputDecoration(
                                        contentPadding: edgeInsets16,
                                        hintText: AppLocalizations.of(context)!
                                            .additional_instructions,
                                        filled: true,
                                      ),
                                      onChanged: (val) {
                                        userDashboardController.note = val;
                                        userDashboardController.update();
                                      },
                                    ),
                                    sizedBoxHeight12,
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text("Extra Carbs: "),
                                        const Text("15"),
                                        Text(
                                            "g/KD ${Get.find<PlanController>().planDetail!.carbPrice}   "),
                                        const Spacer(),
                                        Container(
                                          height: 50,
                                          width: 80,
                                          color: const Color.fromARGB(
                                              150, 255, 255, 255),
                                          child: Center(
                                            child: DropdownButton<String>(
                                              underline: Container(),
                                              value: userDashboardController
                                                  .carbValue,
                                              items: [
                                                "0",
                                                "1",
                                                "2",
                                                "3",
                                                "4",
                                                "5"
                                              ]
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item,
                                                        child: Center(
                                                          child: Text(
                                                            item,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        ),
                                                      ))
                                                  .toList(),
                                              onChanged: (val) {
                                                userDashboardController
                                                    .carbValue = val ?? "0";
                                                userDashboardController
                                                    .update();
                                                userDashboardController
                                                    .calculateMealPrice(
                                                  Get.find<PlanController>()
                                                      .planDetail!
                                                      .carbPrice!,
                                                  Get.find<PlanController>()
                                                      .planDetail!
                                                      .proteinPrice!,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    sizedBoxHeight16,
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text("Extra Protein: "),
                                        const Text("15"),
                                        Text(
                                            "g/KD ${Get.find<PlanController>().planDetail!.proteinPrice}"),
                                        const Spacer(),
                                        Container(
                                          height: 50,
                                          width: 80,
                                          color: const Color.fromARGB(
                                              150, 255, 255, 255),
                                          child: Center(
                                            child: DropdownButton<String>(
                                              underline: Container(),
                                              value: userDashboardController
                                                  .proteinValue,
                                              items: [
                                                "0",
                                                "1",
                                                "2",
                                                "3",
                                                "4",
                                                "5"
                                              ]
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item,
                                                        child: Center(
                                                          child: Text(
                                                            item,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        ),
                                                      ))
                                                  .toList(),
                                              onChanged: (val) {
                                                userDashboardController
                                                    .proteinValue = val ?? "0";
                                                userDashboardController
                                                    .update();
                                                userDashboardController
                                                    .calculateMealPrice(
                                                  Get.find<PlanController>()
                                                      .planDetail!
                                                      .carbPrice!,
                                                  Get.find<PlanController>()
                                                      .planDetail!
                                                      .proteinPrice!,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Text(
                                        "Price: ${userDashboardController.price} KD"),
                                    sizedBoxHeight12,
                                    LoginButton(
                                      onTap: () {
                                        userDashboardController.saveMeal(
                                          meal,
                                          item,
                                          type,
                                          itemIndex: itemIndex,
                                        );
                                      },
                                      enabled: true,
                                      title: AppLocalizations.of(context)!.save,
                                      height: 50,
                                    ),
                                    sizedBoxHeight12,
                                  ],
                                ),
                              );
                            });
                          });
                    },
                    child: Container(
                      padding: edgeInsets4,
                      decoration: const BoxDecoration(
                          color: loginButtonColor, shape: BoxShape.circle),
                      child: const Icon(Icons.add),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.5),
          child: SizedBox(
            width: 150,
            height: 20,
            child: GetBuilder<LanguageTogglerController>(
              builder: (languageController) => Text(
                languageController.isEnglish ? meal.nameEn : meal.nameAr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xffFFFDFD),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
