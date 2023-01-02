import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_studio_user/core/models/bottom_nav_item.dart';
import 'package:health_studio_user/ui/widgets/customBottomNavBar.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const CustomBottomAppBar(),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(children: [
              sizedBoxHeight25,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 270.w,
                    height: 75.h,
                    child: Image.asset("assets/images/health_studio_logo.png"),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 22.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: settingsBackground,
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Padding(
                              padding: const EdgeInsets.all(0.25),
                              child: SizedBox(
                                height: 24.h,
                                width: 25.w,
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
                padding: edgeInsets22,
                child: const Text(
                  'Active Training Weight Gain Meal Plan',
                  style: TextStyle(
                    color: Color(0xffFFFDFD),
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                ),
              ),
              planItem('Plan 01', "3 Meals", "1 Snacks", "1 Breakfast"),
              planItem('Plan 02', "3 Meals", "1 Snacks", "1 Breakfast"),
              customplan('Custom Plan', "3", "1", "1"),
            ]),
          ),
        ));
  }

  Widget planItem(
      String plantitle, String meals, String snacks, String breakfast) {
    return Column(
      children: [
        Padding(
          padding: edgeInsets16,
          child: Container(
            height: 228.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: edgeInsetsleft16,
                        child: Text(
                          plantitle,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            color: plantextColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/planimage.png',
                                      height: 20.h,
                                    ),
                                    sizedBoxwidth8,
                                    Text(
                                      meals,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        color: blackColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/planimage.png',
                                      height: 20.h,
                                    ),
                                    sizedBoxwidth8,
                                    Text(
                                      snacks,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        color: blackColor,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            sizedBoxHeight14,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/planimage.png',
                                  height: 20.h,
                                ),
                                sizedBoxwidth8,
                                Text(
                                  breakfast,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    color: blackColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 1,
                        color: dividercolor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: loginButtonColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: edgeInsets8,
                              child: Column(
                                children: [
                                  Text(
                                    '07',
                                    style: TextStyle(
                                        color: pureblackColor,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18.sp),
                                  ),
                                  Text(
                                    'Days',
                                    style: TextStyle(
                                        color: pureblackColor,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12.sp),
                                  ),
                                  Text(
                                    'KD : 140',
                                    style: TextStyle(
                                        color: whiteColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: edgeInsets8,
                            child: Column(
                              children: [
                                Text(
                                  '07',
                                  style: TextStyle(
                                      color: pureblackColor,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18.sp),
                                ),
                                Text(
                                  'Days',
                                  style: TextStyle(
                                      color: pureblackColor,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12.sp),
                                ),
                                Text(
                                  'KD : 140',
                                  style: TextStyle(
                                      color: loginButtonColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.sp),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: edgeInsets8,
                            child: Column(
                              children: [
                                Text(
                                  '07',
                                  style: TextStyle(
                                      color: pureblackColor,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18.sp),
                                ),
                                Text(
                                  'Days',
                                  style: TextStyle(
                                      color: pureblackColor,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12.sp),
                                ),
                                Text(
                                  'KD : 140',
                                  style: TextStyle(
                                      color: loginButtonColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.sp),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Container(
                    width: 56.w,
                    height: 224.h,
                    decoration: const BoxDecoration(
                      color: itemsbackground,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(6),
                          bottomRight: Radius.circular(6)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            SvgPicture.asset('assets/images/calorie.svg'),
                            sizedBoxHeight6,
                            Text(
                              '250',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w900,
                                  color: whiteColor),
                            ),
                            Text(
                              'Calorie',
                              style: TextStyle(
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w300,
                                  color: whiteColor),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            SvgPicture.asset('assets/images/protein.svg'),
                            sizedBoxHeight6,
                            Text(
                              '250',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w900,
                                  color: whiteColor),
                            ),
                            Text(
                              'Protein',
                              style: TextStyle(
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w300,
                                  color: whiteColor),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            SvgPicture.asset('assets/images/fat.svg'),
                            sizedBoxHeight6,
                            Text(
                              '250',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w900,
                                  color: whiteColor),
                            ),
                            Text(
                              'Fat',
                              style: TextStyle(
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w300,
                                  color: whiteColor),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget customplan(
      String plantitle, String meals, String snacks, String breakfast) {
    return Padding(
      padding: edgeInsets16,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 20,
            left: 0,
            top: 0,
            right: 0,
            child: Container(
              height: 1000,
              width: 1000,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          Container(
            height: 235.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          sizedBoxHeight6,
                          Padding(
                            padding: edgeInsetsleft16,
                            child: Text(
                              plantitle,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                                color: plantextColor,
                              ),
                            ),
                          ),
                          sizedBoxHeight10,
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/planimage.png',
                                          height: 20.h,
                                        ),
                                        sizedBoxwidth8,
                                        Row(
                                          children: [
                                            Container(
                                              height: 26.h,
                                              width: 26.w,
                                              color:
                                                  customcolor.withOpacity(0.1),
                                              child: Center(
                                                child: Text(
                                                  meals,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.sp,
                                                    color: blackColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            sizedBoxwidth8,
                                            Text('Meals',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.sp,
                                                  color: blackColor,
                                                ))
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/planimage.png',
                                          height: 20.h,
                                        ),
                                        sizedBoxwidth8,
                                        Container(
                                          height: 26.h,
                                          width: 26.w,
                                          color: customcolor.withOpacity(0.1),
                                          child: Center(
                                            child: Text(
                                              meals,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.sp,
                                                color: blackColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        sizedBoxwidth8,
                                        Text('Snacks',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.sp,
                                              color: blackColor,
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                                sizedBoxHeight14,
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/planimage.png',
                                      height: 20.h,
                                    ),
                                    sizedBoxwidth8,
                                    Container(
                                      height: 26.h,
                                      width: 26.w,
                                      color: customcolor.withOpacity(0.1),
                                      child: Center(
                                        child: Text(
                                          meals,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp,
                                            color: blackColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    sizedBoxwidth8,
                                    Text('Breakfast',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.sp,
                                          color: blackColor,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 0, right: 15, top: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          sizedBoxHeight10,
                          Image.asset("assets/images/Frame.png")
                        ],
                      ),
                    )
                  ],
                ),
                const Divider(
                  height: 1,
                  color: dividercolor,
                  thickness: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: loginButtonColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: edgeInsets8,
                        child: Column(
                          children: [
                            Text(
                              '07',
                              style: TextStyle(
                                  color: pureblackColor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18.sp),
                            ),
                            Text(
                              'Days',
                              style: TextStyle(
                                  color: pureblackColor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: edgeInsets8,
                      child: Column(
                        children: [
                          Text(
                            '15',
                            style: TextStyle(
                                color: pureblackColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 18.sp),
                          ),
                          Text(
                            'Days',
                            style: TextStyle(
                                color: pureblackColor,
                                fontWeight: FontWeight.w300,
                                fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: edgeInsets8,
                      child: Column(
                        children: [
                          Text(
                            '30',
                            style: TextStyle(
                                color: pureblackColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 18.sp),
                          ),
                          Text(
                            'Days',
                            style: TextStyle(
                                color: pureblackColor,
                                fontWeight: FontWeight.w300,
                                fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                sizedBoxHeight6,
                sizedBoxHeight10,
                sizedBoxHeight16,
              ],
            ),
          ),
          Container(
            height: 42.h,
            width: 207.w,
            decoration: BoxDecoration(
              color: const Color(0xffF1773E),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                'CREATE',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                    color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
