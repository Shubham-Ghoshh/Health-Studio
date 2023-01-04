// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/date_controller.dart';
import 'package:health_studio_user/ui/widgets/bottom_navigation_bar.dart';
import 'package:health_studio_user/utils/buttons.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl/intl.dart';

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({super.key});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  DateController dateController = DateController();

  @override
  Widget build(BuildContext context) {
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
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
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
                  sizedBoxHeight16,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Confirmation",
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
                          "Please check below details to open the payment gateway. Make sure everything is correct.",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 15.sp,
                          ),
                        ),
                        sizedBoxHeight16,
                        Text(
                          "Subscription",
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
                        Container(
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
                                SizedBox(
                                  width: 140,
                                  height: 125,
                                  child: Image.asset(
                                    "assets/images/feature0.png",
                                  ),
                                ),
                                SizedBox(
                                  child: Text(
                                    "Active Training\nWeight Gain\nMeal Plan",
                                    style: TextStyle(
                                      color: splashthemeColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        sizedBoxHeight16,
                        Text(
                          "Subscription Start Date",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                        ),
                        sizedBoxHeight6,
                        subscriptionDate("29/12/2022",
                            dateController.subsciptionStartDateController),
                        sizedBoxHeight10,
                        Text(
                          "Subscription End Date",
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
                          decoration: const InputDecoration(
                            hintText: "01/01/2023",
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 16),
                          ),
                        ),
                        sizedBoxHeight10,
                        Text(
                          "Add Promo Code",
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
                                onChanged: (value) {},
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
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                decoration: const BoxDecoration(
                                    color: Color(0xffFAAF4A),
                                    shape: BoxShape.rectangle),
                                child: Text(
                                  "Apply",
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
                        sizedBoxHeight40,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "TOTAL",
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
                                "KWD 130",
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
                  payNowButton(),
                ],
              ),
            ),
          ),
        ],
      ),
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
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
                builder: (context, child) => Theme(
                    data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                            primary: Color(0xffFAAF4A))),
                    child: child!),
              );
              if (pickedDate != null) {
                String formattedDate =
                    DateFormat("dd/MM/yyyy").format(pickedDate);
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
