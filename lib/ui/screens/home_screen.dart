import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:health_studio_user/ui/widgets/home_page_widgets';

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

  int _currentIndex = 0;

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
              padding: EdgeInsets.symmetric(horizontal: 0.01.sw),
              child: Column(
                children: [
                  sizedBoxHeight6,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 270,
                        height: 75,
                        child:
                            Image.asset("assets/images/health_studio_logo.png"),
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
                            fontFamily: "Poppins",
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
                      children: [
                        featuresPlanItem("feature1",
                            "Active Training Weight Gain Meal Plan"),
                        featuresPlanItem("feature2", "Lifestyle / Weight Loss"),
                        featuresPlanItem("feature1",
                            "Active Training Weight Gain Meal Plan"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Our Delicious Menu",
                              style: TextStyle(
                                color: Color(0xffFFFDFD),
                                fontWeight: FontWeight.w700,
                                fontFamily: "Poppins",
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
                                  fontFamily: "Poppins",
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
                              fontFamily: "Poppins",
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
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 6),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: days.length,
                        itemBuilder: (context, index) {
                          return CalenderDayDate(
                            day: days[index],
                            date: dates[index].toString(),
                          );
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
                        itemCount: foodMenu.length,
                        itemBuilder: (context, index) {
                          return FoodMenuItem(
                            foodName: foodMenu[index],
                            foodImage: foodImagesName[index],
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
  }

  Column featuresPlanItem(String imageName, String featureDescription) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: (() {}),
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
                child: Image.asset("assets/images/$imageName.png"),
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
              featureDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xffFFFDFD),
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
