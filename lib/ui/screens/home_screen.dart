import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/language_controller.dart';
import 'package:health_studio_user/core/controllers/order_controller.dart';
import 'package:health_studio_user/core/controllers/setting_controller.dart';
import 'package:health_studio_user/ui/screens/logged_in_home_screen.dart';
import 'package:health_studio_user/ui/screens/setting_screen.dart';
import 'package:health_studio_user/core/controllers/home_controller.dart';
import 'package:health_studio_user/core/controllers/plan_controller.dart';
import 'package:health_studio_user/core/models/plan.dart';
import 'package:health_studio_user/ui/widgets/date.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/formatters.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:health_studio_user/ui/widgets/home_page_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // @override
  // void initState() {
  //   super.initState();
  //   checkLoopBack();
  // }

  // void checkLoopBack() async {
  //   SettingsController settingController = SettingsController();
  //   bool loopBack = await settingController.getVersion();
  //   if (loopBack) {
  //     settingController.rateApp();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homeController) {
      return Scaffold(
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
              child: Padding(
                padding: edgeInsets16.copyWith(
                  top: 0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedBoxHeight6,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 225,
                          // height: 57,
                          child: Image.asset(
                              "assets/images/health_studio_logo.png"),
                        ),
                        Row(
                          children: [
                            GetBuilder<OrderController>(
                                builder: (orderController) {
                              return Visibility(
                                visible: orderController.orderDetails != null,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: activeIconColor,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      Get.to(() => const LoggedInHomePage());
                                    },
                                    icon: const Icon(
                                      Icons.dining_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            }),
                            sizedBoxwidth8,
                            Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: activeIconColor,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Get.to(() => const SettingPage());
                                },
                                icon: Padding(
                                  padding: const EdgeInsets.all(0.25),
                                  child: SizedBox(
                                    height: 24,
                                    child: Image.asset(
                                        "assets/images/settings_icon.png"),
                                  ),
                                ),
                              ),
                            ),
                            sizedBoxwidth8,
                          ],
                        ),
                      ],
                    ),
                    // sizedBoxHeight20,
                    Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.select_meal,
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        sizedBoxHeight14,
                      ],
                    ),
                    Column(
                      children: [
                        CarouselSlider.builder(
                            itemCount: homeController.plans.length,
                            itemBuilder: ((context, index, realIndex) {
                              final plan = homeController.plans[index];
                              return featuresPlanItem(plan, index);
                            }),
                            options: CarouselOptions(
                                // height: 400,
                                // height: 315,
                                height: 270,
                                // autoPlay: true,
                                enableInfiniteScroll: false,
                                viewportFraction: 0.6,
                                enlargeCenterPage: true,
                                onPageChanged: (index, reason) {
                                  homeController.scrollPlans(index);
                                },
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.height)),
                        buildIndicator(homeController),
                        sizedBoxHeight12,
                      ],
                    ),

                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.delicious_menu,
                              style: const TextStyle(
                                color: Color(0xffFFFDFD),
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                        sizedBoxHeight14,
                        Text(
                          AppLocalizations.of(context)!.menu_list_preview,
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        sizedBoxHeight14,
                      ],
                    ),
                    Padding(
                      padding: edgeInsets0.copyWith(right: 8),
                      child: SizedBox(
                        height: 65,
                        // width: 0.7.sw,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            28,
                            (index) {
                              DateTime date =
                                  DateTime.now().add(Duration(days: index));
                              return date.weekday == 5
                                  ? const SizedBox()
                                  : dateWidget(
                                      context,
                                      getWeekday(date.weekday),
                                      date.day.toString(),
                                      homeController.selectedDate.day ==
                                          date.day, () {
                                      homeController.selectDate(date);
                                    });
                            },
                          ),
                        ),
                      ),
                    ),
                    sizedBoxHeight14,
                    Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: SizedBox(
                        height: 365,
                        child: homeController.menu.isEmpty
                            ? Center(
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .no_items_available,
                                  style: const TextStyle(
                                    color: Color(0xffFFFDFD),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                              )
                            : ListView.builder(
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

  Widget featuresPlanItem(
    Plan plan,
    int index,
  ) {
    return SizedBox(
      height: 234,
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (() {
              Get.put(OrderController()).order.planId = plan.id;
              Get.put(PlanController()).getPackages(plan);
            }),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                height: 184.8,
                width: 184.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
                  child: SizedBox(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        plan.image,
                        height: 35,
                        width: 36,
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return const SizedBox(
                            height: 35,
                            width: 36,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: activeIconColor,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox(
                            height: 35,
                            width: 36,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: SizedBox(
              width: 130,
              // height: 90,
              child: GetBuilder<LanguageTogglerController>(
                builder: (languageController) => Text(
                  languageController.isEnglish ? plan.titleEn : plan.titleAr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xffFFFDFD),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator(HomeController homeController) =>
      AnimatedSmoothIndicator(
        activeIndex: homeController.activeIndex,
        count: homeController.plans.length,
        effect: const SlideEffect(
            activeDotColor: activeDateBgColor,
            dotColor: whiteColor,
            dotHeight: 10,
            dotWidth: 10),
      );
}
