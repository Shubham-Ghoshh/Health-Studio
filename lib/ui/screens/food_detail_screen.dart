import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_studio_user/core/controllers/menu_controller.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:health_studio_user/ui/widgets/food_detail_card.dart';

class FoodDetailPage extends StatefulWidget {
  const FoodDetailPage({super.key});

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

int _currentIndex = 0;

class _FoodDetailPageState extends State<FoodDetailPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuController>(builder: (menuController) {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/bottom_bar_home.svg",
                  color: _currentIndex == 0
                      ? const Color(0xffE84C4F)
                      : Colors.black,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/bottom_bar_shopping_bag.svg",
                  color: _currentIndex == 1
                      ? const Color(0xffE84C4F)
                      : Colors.black,
                ),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/bottom_bar_search.svg",
                  color: _currentIndex == 2
                      ? const Color(0xffE84C4F)
                      : Colors.black,
                ),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/bottom_bar_profile.svg",
                  color: _currentIndex == 3
                      ? const Color(0xffE84C4F)
                      : Colors.black,
                ),
                label: "Profile",
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            }),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
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
                            height: 75,
                            child: Hero(
                              tag: "food-image",
                              child: Image.asset(
                                "assets/images/health_studio_logo.png",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
