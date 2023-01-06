import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_studio_user/ui/widgets/app_bar.dart';
import 'package:health_studio_user/ui/widgets/bottom_navigation_bar.dart';
import 'package:health_studio_user/core/controllers/menu_controller.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:health_studio_user/ui/widgets/food_detail_card.dart';

class FoodDetailPage extends StatefulWidget {
  const FoodDetailPage({super.key});

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuController>(builder: (menuController) {
      return Scaffold(
        bottomNavigationBar: bottomNavigationBar(),
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                  "assets/images/food_detail_bottom_background.png"),
            ),
            SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    sizedBoxHeight6,
                    appBar(),
                    sizedBoxHeight25,
                    Center(
                      child: FoodDetailCard(
                        nutritionContent: menuController.menuDetail!.attribute
                            .map(
                              (e) => NutritionContent(
                                image: SvgPicture.asset(
                                    "assets/images/menu/${e.titleEn}_icon.svg"),
                                nutritionContent: e.value,
                                nutritionName: e.titleEn,
                              ),
                            )
                            .toList(),
                        //  const [
                        //   NutritionContent(
                        //       image: "calorie_icon",
                        //       nutritionContent: "250",
                        //       nutritionName: "Calorie"),
                        //   NutritionContent(
                        //       image: "protein_icon",
                        //       nutritionContent: "24",
                        //       nutritionName: "Protein"),
                        //   NutritionContent(
                        //       image: "fat_icon",
                        //       nutritionContent: "10",
                        //       nutritionName: "Fat"),
                        //   NutritionContent(
                        //       image: "carbs_icon",
                        //       nutritionContent: "29",
                        //       nutritionName: "Carbs"),
                        // ],
                        foodName: menuController.menuDetail!.menu.titleEn,
                        foodDescription:
                            menuController.menuDetail!.menu.descriptionEn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
