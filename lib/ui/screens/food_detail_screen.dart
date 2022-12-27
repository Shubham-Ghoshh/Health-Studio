import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_studio_user/utils/spacing.dart';

class FoodDetailPage extends StatefulWidget {
  const FoodDetailPage({super.key});

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

int _currentIndex = 0;

class _FoodDetailPageState extends State<FoodDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/images/bottom_bar_home.svg",
                color:
                    _currentIndex == 0 ? const Color(0xffE84C4F) : Colors.black,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/images/bottom_bar_shopping_bag.svg",
                color:
                    _currentIndex == 1 ? const Color(0xffE84C4F) : Colors.black,
              ),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/images/bottom_bar_search.svg",
                color:
                    _currentIndex == 2 ? const Color(0xffE84C4F) : Colors.black,
              ),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/images/bottom_bar_profile.svg",
                color:
                    _currentIndex == 3 ? const Color(0xffE84C4F) : Colors.black,
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
            child:
                Image.asset("assets/images/food_detail_bottom_background.png"),
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
                          child: Image.asset(
                            "assets/images/health_studio_logo.png",
                          ),
                        ),
                      ),
                    ],
                  ),
                  sizedBoxHeight25,
                  const Center(
                    child: FoodDetailCard(
                      nutritionContent: [
                        NutritionContent(
                            image: "calorie_icon",
                            nutritionContent: "250",
                            nutritionName: "Calorie"),
                        NutritionContent(
                            image: "protein_icon",
                            nutritionContent: "24",
                            nutritionName: "Protein"),
                        NutritionContent(
                            image: "fat_icon",
                            nutritionContent: "10",
                            nutritionName: "Fat"),
                        NutritionContent(
                            image: "carbs_icon",
                            nutritionContent: "29",
                            nutritionName: "Carbs"),
                      ],
                      foodName: "Cheese Omelette - Breakfast",
                      foodDescription: "Creamy And Cheesy Omelette",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FoodDetailCard extends StatelessWidget {
  const FoodDetailCard({
    required this.nutritionContent,
    required this.foodName,
    required this.foodDescription,
    Key? key,
  }) : super(key: key);

  final List<Widget> nutritionContent;
  final String foodName;
  final String foodDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBoxHeight10,
                Text(
                  foodName,
                  style: const TextStyle(
                    color: Color(0xffFAAF4A),
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                    fontSize: 21,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0, bottom: 14),
                  child: Text(
                    foodDescription,
                    style: const TextStyle(
                      color: Color(0xff0A0909),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                      fontSize: 17,
                    ),
                  ),
                ),
                const Text(
                  "Diet Refrence",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color(0xff2A7891),
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: nutritionContent,
                ),
                sizedBoxHeight10
              ],
            ),
          )
        ],
      ),
    );
  }
}

class NutritionContent extends StatelessWidget {
  const NutritionContent({
    required this.image,
    required this.nutritionContent,
    required this.nutritionName,
    Key? key,
  }) : super(key: key);

  final String image;
  final String nutritionContent;
  final String nutritionName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0, right: 19, left: 18),
          child: SizedBox(
            height: 45,
            width: 45,
            child: SvgPicture.asset("assets/images/$image.svg"),
          ),
        ),
        Text(
          nutritionContent,
          style: const TextStyle(
            color: Color(0xff2A7891),
            fontWeight: FontWeight.w700,
            fontFamily: "Poppins",
            fontSize: 27,
          ),
        ),
        Text(
          nutritionName,
          style: const TextStyle(
            color: Color(0xff2A7891),
            fontWeight: FontWeight.w400,
            fontFamily: "Poppins",
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
