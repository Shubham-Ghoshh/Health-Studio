import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_studio_user/core/controllers/home_controller.dart';
import 'package:health_studio_user/core/controllers/order_controller.dart';
import 'package:health_studio_user/core/controllers/plan_controller.dart';
import 'package:health_studio_user/core/controllers/setting_controller.dart';
import 'package:health_studio_user/core/controllers/userDashboardController.dart';
import 'package:health_studio_user/core/models/order.dart';
import 'package:health_studio_user/ui/screens/address_screen.dart';
import 'package:health_studio_user/ui/screens/confirmation_screen.dart';
import 'package:health_studio_user/ui/widgets/app_bar.dart';
import 'package:health_studio_user/ui/widgets/date.dart';
import 'package:health_studio_user/ui/widgets/food_detail_card.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/formatters.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:intl/intl.dart';

class LoggedInHomePage extends StatefulWidget {
  const LoggedInHomePage({Key? key}) : super(key: key);

  @override
  State<LoggedInHomePage> createState() => _LoggedInHomePageState();
}

class _LoggedInHomePageState extends State<LoggedInHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // bottomNavigationBar: bottomNavigationBar(),
        body: GetBuilder<UserDashboardController>(
            init: UserDashboardController(),
            builder: (userDashboardController) {
              return GetBuilder<OrderController>(builder: (orderController) {
                return GetBuilder<PlanController>(builder: (planController) {
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  sizedBoxHeight6,
                                  appbarWithSetting(),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    sizedBoxHeight6,
                                    Text(
                                      Get.find<SettingsController>()
                                              .userDetails
                                              ?.firstName ??
                                          "",
                                      style: TextStyle(
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w600,
                                        shadows: textShadow,
                                      ),
                                    ),
                                    sizedBoxHeight12,
                                    Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: edgeInsets16,
                                                decoration: BoxDecoration(
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Color.fromARGB(
                                                          50, 0, 0, 0),
                                                      spreadRadius: 0.5,
                                                      blurRadius: 1,
                                                      offset: Offset(0, 8),
                                                    )
                                                  ],
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          (planController
                                                                      .planDetail
                                                                      ?.descriptionEn ??
                                                                  "")
                                                              .trimRight(),
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xff0A0909),
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14.4,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Divider(
                                                      color: Color.fromARGB(
                                                          96, 0, 0, 0),
                                                    ),
                                                    const Text(
                                                      "Every Meal:",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff0A0909),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14.4,
                                                      ),
                                                    ),
                                                    // sizedBoxHeight6,x
                                                    Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            // NutritionContent(
                                                            //     image:
                                                            //         SvgPicture.asset(
                                                            //       'assets/images/calorie.svg',
                                                            //       color:
                                                            //           plantextColor,
                                                            //     ),
                                                            //     nutritionContent:
                                                            //         "250",
                                                            //     nutritionName:
                                                            //         "Calorie"),
                                                            NutritionContent(
                                                                image:
                                                                    SvgPicture
                                                                        .asset(
                                                                  'assets/images/protein.svg',
                                                                  color:
                                                                      plantextColor,
                                                                ),
                                                                nutritionContent:
                                                                    planController
                                                                            .planDetail
                                                                            ?.fat ??
                                                                        "0",
                                                                nutritionName:
                                                                    "Fat"),
                                                            sizedBoxWidth12,
                                                            // NutritionContent(
                                                            //     image:
                                                            //         SvgPicture.asset(
                                                            //       'assets/images/fat.svg',
                                                            //       color:
                                                            //           plantextColor,
                                                            //     ),
                                                            //     nutritionContent:
                                                            //         "10",
                                                            //     nutritionName: "Fat"),
                                                            NutritionContent(
                                                                image:
                                                                    SvgPicture
                                                                        .asset(
                                                                  'assets/images/carbs.svg',
                                                                  color:
                                                                      plantextColor,
                                                                ),
                                                                nutritionContent:
                                                                    planController
                                                                            .planDetail
                                                                            ?.calorie ??
                                                                        "0",
                                                                nutritionName:
                                                                    "Calorie"),
                                                          ],
                                                        ),
                                                        sizedBoxHeight30,
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              sizedBoxHeight20,
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
                                              height: 50.h,
                                              decoration: BoxDecoration(
                                                color: loginButtonColor,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Center(
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 8,
                                                        bottom: 8,
                                                      ),
                                                      child: Text(
                                                        "Your subscription will last\n until ${DateFormat("MMM dd, yyyy").format(getDateFormat(Get.find<SettingsController>().userDetails?.orderTo, split: false))}",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  OutlinedButton(
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                            side: const BorderSide(
                                                                width: 2.0,
                                                                color: Colors
                                                                    .white)),
                                                    onPressed: () {
                                                      print(
                                                          "FROM ${Get.find<SettingsController>().userDetails?.orderFrom} TO ${Get.find<SettingsController>().userDetails?.orderTo}");
                                                      int duration = getDateFormat(
                                                              Get.find<
                                                                      SettingsController>()
                                                                  .userDetails
                                                                  ?.orderTo,
                                                              split: false)
                                                          .difference(getDateFormat(
                                                              Get.find<
                                                                      SettingsController>()
                                                                  .userDetails
                                                                  ?.orderFrom,
                                                              split: false))
                                                          .inDays;
                                                      print(
                                                          "DURATION ${duration + 1}");

                                                      DateTime startDate =
                                                          getDateFormat(
                                                                  Get.find<
                                                                          SettingsController>()
                                                                      .userDetails
                                                                      ?.orderTo,
                                                                  split: false)
                                                              .add(
                                                        const Duration(
                                                          days: 1,
                                                        ),
                                                      );

                                                      DateTime endDate =
                                                          startDate.add(
                                                        Duration(
                                                          days: (duration + 1),
                                                        ),
                                                      );

                                                      orderController.order =
                                                          Order(
                                                        planId: orderController
                                                            .orderDetails!
                                                            .categoryId,
                                                        packageId:
                                                            orderController
                                                                .orderDetails!
                                                                .packageId,
                                                        amount: orderController
                                                            .orderDetails!
                                                            .amount,
                                                        startDate: DateFormat(
                                                                "dd-MM-yyyy")
                                                            .format(startDate),
                                                        endDate: DateFormat(
                                                                "dd-MM-yyyy")
                                                            .format(endDate),
                                                      );
                                                      orderController.duration =
                                                          duration + 1;
                                                      orderController.update();

                                                      Get.put(PlanController())
                                                          .selectedPlan = Get.find<
                                                              HomeController>()
                                                          .plans
                                                          .firstWhere((plan) =>
                                                              plan.id ==
                                                              orderController
                                                                  .orderDetails!
                                                                  .categoryId);
                                                      Get.to(
                                                        () => const Address(
                                                          check: true,
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      "Extend",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    sizedBoxHeight20,
                                    Text(
                                      "Current Week",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        shadows: textShadow,
                                        color: Colors.white,
                                        fontSize: 21.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "All your chosen meal this week.",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    sizedBoxHeight12,
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: GetBuilder<HomeController>(
                                  init: HomeController(),
                                  builder: (homeController) => Padding(
                                    padding: edgeInsets0.copyWith(right: 0),
                                    child: SizedBox(
                                      height: 132.h,
                                      child: (userDashboardController
                                                  .userDashboard
                                                  ?.thisweek
                                                  .isEmpty ??
                                              true)
                                          ? const Center(
                                              child: Text(
                                                "No Meals for these dates",
                                              ),
                                            )
                                          : ListView(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              children: List.generate(
                                                userDashboardController
                                                        .userDashboard
                                                        ?.thisweek
                                                        .length ??
                                                    0,
                                                (index) {
                                                  return DateTime.parse(userDashboardController
                                                                  .userDashboard!
                                                                  .thisweek[
                                                                      index]
                                                                  .dateRequested)
                                                              .weekday ==
                                                          5
                                                      ? const SizedBox()
                                                      : calenderWidget(
                                                          context,
                                                          userDashboardController
                                                              .userDashboard!
                                                              .thisweek[index]
                                                              .dateText,
                                                          userDashboardController
                                                                  .userDashboard!
                                                                  .thisweek[
                                                                      index]
                                                                  .status ==
                                                              "0", () {
                                                          userDashboardController.getPackageDetails(
                                                              orderController
                                                                  .orderDetails!
                                                                  .categoryId,
                                                              orderController
                                                                  .orderDetails!
                                                                  .packageId,
                                                              userDashboardController
                                                                  .userDashboard!
                                                                  .thisweek[
                                                                      index]
                                                                  .dateRequested,
                                                              userDashboardController
                                                                      .userDashboard!
                                                                      .thisweek[
                                                                  index],
                                                              allowEdit: userDashboardController
                                                                      .userDashboard!
                                                                      .thisweek[
                                                                          index]
                                                                      .allowEdit ==
                                                                  "1");
                                                        });
                                                },
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    sizedBoxHeight20,
                                    Text(
                                      "Next Week",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        shadows: textShadow,
                                        color: Colors.white,
                                        fontSize: 21.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "Chose your meal now for next week",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    sizedBoxHeight16,
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, bottom: 16),
                                child: GetBuilder<HomeController>(
                                  init: HomeController(),
                                  builder: (homeController) => Padding(
                                    padding: edgeInsets0.copyWith(right: 0),
                                    child: SizedBox(
                                      height: 132.h,
                                      child: (userDashboardController
                                                  .userDashboard
                                                  ?.nextweek
                                                  .isEmpty ??
                                              true)
                                          ? const Center(
                                              child: Text(
                                                "No Meals for these dates",
                                              ),
                                            )
                                          : ListView(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              children: List.generate(
                                                userDashboardController
                                                        .userDashboard
                                                        ?.nextweek
                                                        .length ??
                                                    0,
                                                (index) {
                                                  return DateTime.parse(userDashboardController
                                                                  .userDashboard!
                                                                  .nextweek[
                                                                      index]
                                                                  .dateRequested)
                                                              .weekday ==
                                                          5
                                                      ? const SizedBox()
                                                      : calenderWidget(
                                                          context,
                                                          userDashboardController
                                                              .userDashboard!
                                                              .nextweek[index]
                                                              .dateText,
                                                          userDashboardController
                                                                  .userDashboard!
                                                                  .nextweek[
                                                                      index]
                                                                  .status ==
                                                              "0", () {
                                                          userDashboardController.getPackageDetails(
                                                              orderController
                                                                  .orderDetails!
                                                                  .categoryId,
                                                              orderController
                                                                  .orderDetails!
                                                                  .packageId,
                                                              userDashboardController
                                                                  .userDashboard!
                                                                  .nextweek[
                                                                      index]
                                                                  .dateRequested,
                                                              userDashboardController
                                                                      .userDashboard!
                                                                      .nextweek[
                                                                  index],
                                                              allowEdit: userDashboardController
                                                                      .userDashboard!
                                                                      .nextweek[
                                                                          index]
                                                                      .allowEdit ==
                                                                  "1");
                                                        });
                                                },
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                });
              });
            }));
  }
}
