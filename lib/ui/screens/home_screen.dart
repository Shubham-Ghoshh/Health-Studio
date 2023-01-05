import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/home_controller.dart';
import 'package:health_studio_user/core/controllers/plan_controller.dart';
import 'package:health_studio_user/core/models/plan.dart';
import 'package:health_studio_user/ui/widgets/bottom_navigation_bar.dart';
import 'package:health_studio_user/ui/widgets/date.dart';
import 'package:health_studio_user/utils/formatters.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:health_studio_user/ui/widgets/home_page_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> days = [
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thus",
    "Fri",
    "Sat",
  ];
  List<int> dates = [1, 2, 3, 4, 5, 6, 7];

  List<String> foodMenu = [
    "Fruit Salad Mix",
    "Chicken Biryani",
    "Fruit Salad Mix"
  ];
  List<String> foodImagesName = [
    "food1",
    "food2",
    "food1",
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (homeController) {
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
                  child: Padding(
                    padding: edgeInsets8,
                    child: Column(
                      children: [
                        sizedBoxHeight6,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 270,
                              height: 75,
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
                                      color: Color(0xffE84C4F),
                                    ),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Padding(
                                        padding: const EdgeInsets.all(0.25),
                                        child: SizedBox(
                                          height: 24,
                                          width: 25,
                                          child: Image.asset(
                                              "assets/images/settings_icon.png"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                sizedBoxwidth8,
                              ],
                            ),
                          ],
                        ),
                        sizedBoxHeight25,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              const Text(
                                "Select your meal and enjoy our delicious and healthy food.",
                                style: TextStyle(
                                  color: Color(0xffFFFDFD),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                              sizedBoxHeight35,
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: homeController.plans
                                  .asMap()
                                  .map((index, plan) => MapEntry(
                                      featuresPlanItem(plan, index), index))
                                  .keys
                                  .toList()),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Our Delicious Menu",
                                    style: TextStyle(
                                      color: Color(0xffFFFDFD),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 27,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Text(
                                      "See All",
                                      style: TextStyle(
                                        shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(2.0, 5.0),
                                            blurRadius: 5.0,
                                            color: Color.fromARGB(126, 0, 0, 0),
                                          ),
                                        ],
                                        color: Color(0xffF1773E),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sizedBoxHeight20,
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.0),
                                child: Text(
                                  "Here are the list of our preview of the menu we are having",
                                  style: TextStyle(
                                    color: Color(0xffFFFDFD),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              sizedBoxHeight20,
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 77.5,
                          // width: 0.7.sw,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: List.generate(
                              28,
                              (index) {
                                DateTime date =
                                    DateTime.now().add(Duration(days: index));
                                return dateWidget(
                                    context,
                                    getWeekday(date.weekday),
                                    date.day.toString(),
                                    homeController.selectedDate.day == date.day,
                                    () {
                                  homeController.selectDate(date);
                                });
                              },
                            ),
                          ),
                        ),
                        sizedBoxHeight35,
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: SizedBox(
                            height: 350,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: homeController.menu.length,
                              itemBuilder: (context, index) {
                                return FoodMenuItem(
                                  menu: homeController.menu[index],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Column featuresPlanItem(
    Plan plan,
    int index,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: (() {
            Get.put(PlanController()).getPackages(plan);
          }),
          child: Container(
            height: 180,
            width: 195,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: SizedBox(
                height: 35,
                width: 36,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: plan.image,
                    height: 180,
                    width: 195,
                    fit: BoxFit.fitWidth,
                    placeholder: (context, url) =>
                        Image.asset("assets/images/feature$index.png"),
                    errorWidget: (context, url, error) =>
                        Image.asset("assets/images/feature$index.png"),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: SizedBox(
            width: 180,
            height: 90,
            child: Text(
              plan.titleEn,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xffFFFDFD),
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
