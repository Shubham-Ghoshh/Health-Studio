// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/order_controller.dart';
import 'package:health_studio_user/utils/formatters.dart';
import 'package:intl/intl.dart';
import 'package:health_studio_user/core/controllers/date_controller.dart';
import 'package:health_studio_user/core/controllers/language_controller.dart';
import 'package:health_studio_user/core/controllers/plan_controller.dart';
import 'package:health_studio_user/core/models/plan.dart';
import 'package:health_studio_user/ui/widgets/app_bar.dart';
import 'package:health_studio_user/ui/widgets/bottom_navigation_bar.dart';
import 'package:health_studio_user/utils/buttons.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({super.key});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  DateController dateController = DateController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlanController>(
      builder: (planController) =>
          GetBuilder<OrderController>(builder: (orderController) {
        return Scaffold(
          appBar: customAppBar(),
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  // appBar(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.confirmation,
                          style: TextStyle(
                            shadows: <Shadow>[
                              const Shadow(
                                offset: Offset(2.0, 5.0),
                                blurRadius: 5.0,
                                color: Color.fromARGB(61, 0, 0, 0),
                              ),
                            ],
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 30.sp,
                          ),
                        ),
                        sizedBoxHeight6,
                        Text(
                          AppLocalizations.of(context)!.payment_gateway_deatils,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 15.sp,
                          ),
                        ),
                        sizedBoxHeight16,
                        Text(
                          AppLocalizations.of(context)!.subscription,
                          style: TextStyle(
                            shadows: <Shadow>[
                              const Shadow(
                                offset: Offset(2.0, 5.0),
                                blurRadius: 5.0,
                                color: Color.fromARGB(88, 0, 0, 0),
                              ),
                            ],
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 24.sp,
                          ),
                        ),
                        sizedBoxHeight10,
                        // PlanWidget(
                        //   widget: widget,
                        //   plan: planController.packages,
                        // ),
                        Container(
                          width: 1.sw,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 15, left: 10.w, bottom: 15, right: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        planController.selectedPlan!.image,
                                    height: 125,
                                    width: 140,
                                    fit: BoxFit.fitWidth,
                                    placeholder: (context, url) => Image.asset(
                                        "assets/images/feature1.png"),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                            "assets/images/feature1.png"),
                                  ),
                                ),
                                sizedBoxWidth12,
                                Flexible(
                                  child: GetBuilder<LanguageTogglerController>(
                                    builder: (languageController) => Text(
                                      languageController.isEnglish
                                          ? planController.selectedPlan!.titleEn
                                          : planController
                                              .selectedPlan!.titleAr,
                                      style: TextStyle(
                                        color: splashthemeColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                sizedBoxWidth12,
                              ],
                            ),
                          ),
                        ),
                        sizedBoxHeight16,
                        Text(
                          AppLocalizations.of(context)!.subscription_start_date,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                        ),
                        sizedBoxHeight6,
                        subscriptionDate(orderController.order.startDate!,
                            dateController.subsciptionStartDateController),
                        sizedBoxHeight10,
                        Text(
                          AppLocalizations.of(context)!.subscription_end_date,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                        ),
                        sizedBoxHeight6,
                        TextFormField(
                          readOnly: true,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                            color: Color(0xff0A0909),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            hintText: DateFormat("dd-MM-yyyy").format(
                              getDateFormat(orderController.order.startDate)
                                  .add(
                                Duration(days: orderController.duration),
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 16),
                          ),
                        ),
                        sizedBoxHeight10,
                        Text(
                          AppLocalizations.of(context)!.add_promo_code,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                        ),
                        sizedBoxHeight6,
                        Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                textInputAction: TextInputAction.done,
                                onChanged: (value) {
                                  orderController.code = value;
                                  orderController.update();
                                },
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.black,
                                style: const TextStyle(
                                  color: Color(0xff0A0909),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 14, right: 8),
                                    child: SizedBox(
                                      height: 40,
                                      width: 30,
                                      child: Image.asset(
                                          "assets/images/promo_code_icon.png"),
                                    ),
                                  ),
                                  hintText: "ABCDDY50",
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 16),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                orderController.checkVoucherAPI();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                decoration: const BoxDecoration(
                                    color: Color(0xffFAAF4A),
                                    shape: BoxShape.rectangle),
                                child: Text(
                                  AppLocalizations.of(context)!.apply,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.5.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        sizedBoxHeight12,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.total,
                              style: TextStyle(
                                shadows: <Shadow>[
                                  const Shadow(
                                    offset: Offset(2.0, 5.0),
                                    blurRadius: 5.0,
                                    color: Color.fromARGB(61, 0, 0, 0),
                                  ),
                                ],
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18.sp,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Text(
                                "KD ${orderController.order.amount}",
                                style: TextStyle(
                                  shadows: <Shadow>[
                                    const Shadow(
                                      offset: Offset(2.0, 5.0),
                                      blurRadius: 5.0,
                                      color: Color.fromARGB(61, 0, 0, 0),
                                    ),
                                  ],
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  sizedBoxHeight16,
                  payNowButton(context),
                  sizedBoxHeight16,
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  GetBuilder<DateController> subscriptionDate(
      String hintText, TextEditingController dateController) {
    return GetBuilder<DateController>(
        init: DateController(),
        builder: (controller) {
          return TextFormField(
            readOnly: true,
            controller: dateController,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: getDateFormat(hintText),
                firstDate: Get.find<OrderController>().firstDate!,
                lastDate: DateTime.now().add(const Duration(days: 365)),
                builder: (context, child) => Theme(
                    data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                            primary: Color(0xffFAAF4A))),
                    child: child!),
              );
              if (pickedDate != null) {
                String formattedDate =
                    DateFormat("dd-MM-yyyy").format(pickedDate);
                Get.find<OrderController>().order.startDate =
                    DateFormat("dd-MM-yyyy").format(pickedDate);
                Get.find<OrderController>().order.endDate =
                    DateFormat("dd-MM-yyyy").format(
                  pickedDate.add(
                    Duration(days: Get.find<OrderController>().duration),
                  ),
                );
                setState(() {
                  dateController.text = formattedDate.toString();
                });
              }
            },
            keyboardType: TextInputType.datetime,
            cursorColor: Colors.black,
            style: const TextStyle(
              color: Color(0xff0A0909),
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SizedBox(
                  child: SvgPicture.asset("assets/images/calender_icon.svg"),
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            ),
          );
        });
  }
}

class PlanWidget extends StatelessWidget {
  const PlanWidget({
    Key? key,
    required this.widget,
    required this.plan,
  }) : super(key: key);

  final ConfirmationPage widget;
  final List<Plan> plan;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 15, left: 10.w, bottom: 15, right: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 140,
              height: 125,
              child: Image.asset(
                "assets/images/feature0.png",
              ),
            ),
            SizedBox(
              child: Container(
                width: 0.25.sw,
                child: Text(
                  "",
                  style: TextStyle(
                    color: splashthemeColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
