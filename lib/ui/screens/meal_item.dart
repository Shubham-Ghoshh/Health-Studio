import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_studio_user/core/controllers/language_controller.dart';
import 'package:health_studio_user/core/controllers/menu_controller.dart';
import 'package:health_studio_user/core/controllers/plan_controller.dart';
import 'package:health_studio_user/core/controllers/userDashboardController.dart';
import 'package:health_studio_user/core/models/meal.dart';
import 'package:health_studio_user/utils/buttons.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/utils/spacing.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    required this.meal,
    required this.height,
    Key? key,
  }) : super(key: key);

  final Meal meal;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            // Get.put(MenuController()).getMenuDetail(menu);
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
                      print("CHOOSE ITEM");
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
                                      maxLines: 4,
                                      cursorColor: Colors.black,
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                      decoration: InputDecoration(
                                        contentPadding: edgeInsets16,
                                        hintText:
                                            "Write additional instructions",
                                        filled: true,
                                      ),
                                      onChanged: (val) {},
                                    ),
                                    sizedBoxHeight12,
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text("Extra Carbs: "),
                                        Text(Get.find<PlanController>()
                                            .planDetail!
                                            .grams),
                                        Text(
                                            "g/KD ${Get.find<PlanController>().planDetail!.carbPrice}   "),
                                        const Spacer(),
                                        Expanded(
                                          child: TextFormField(
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  1),
                                            ],
                                            keyboardType: TextInputType.number,
                                            cursorColor: Colors.black,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1,
                                            decoration: InputDecoration(
                                              contentPadding: edgeInsets16,
                                              hintText: "1 to 5",
                                              filled: true,
                                            ),
                                            onChanged: (val) {
                                              userDashboardController
                                                  .carbValue = val;
                                              userDashboardController.update();
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
                                      ],
                                    ),
                                    sizedBoxHeight16,
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text("Extra Protein: "),
                                        Text(Get.find<PlanController>()
                                            .planDetail!
                                            .grams),
                                        Text(
                                            "g/KD ${Get.find<PlanController>().planDetail!.proteinPrice}"),
                                        const Spacer(),
                                        Expanded(
                                          child: TextFormField(
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  1),
                                            ],
                                            keyboardType: TextInputType.number,
                                            cursorColor: Colors.black,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1,
                                            decoration: InputDecoration(
                                              contentPadding: edgeInsets16,
                                              hintText: "1 to 5",
                                              filled: true,
                                            ),
                                            onChanged: (val) {
                                              userDashboardController
                                                  .proteinValue = val;
                                              userDashboardController.update();
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
                                      ],
                                    ),
                                    const Spacer(),
                                    Text(
                                        "Price: KD ${userDashboardController.price}"),
                                    LoginButton(
                                      onTap: () {},
                                      enabled: true,
                                      title: "Pay Now",
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
