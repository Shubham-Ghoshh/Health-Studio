import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';

Widget dateWidget(BuildContext context, String weekday, String day,
    bool selected, Function() onTap) {
  return Padding(
    padding: const EdgeInsets.only(right: 11.0),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: 63,
        width: 63,
        decoration: BoxDecoration(
          color: selected == true ? activeDateBgColor : whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weekday,
              style: TextStyle(
                color: selected ? Colors.white : inactiveDayFontColor,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
            Text(
              day,
              style: TextStyle(
                color: selected ? whiteColor : inactiveDateFontColor,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget calenderWidget(BuildContext context, String month, String day,
    bool notSelected, Function() onTap) {
  return Padding(
    padding: const EdgeInsets.only(right: 10.0),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        width: 115.w,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(50, 0, 0, 0),
              spreadRadius: 2.5,
              blurRadius: 1,
              offset: Offset(2, 10),
            )
          ],
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  width: 29,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffE84C4F),
                  ),
                  child: IconButton(
                    onPressed: onTap,
                    icon: notSelected
                        ? const Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 15,
                            ),
                          )
                        : const Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                sizedBoxHeight12,
                SvgPicture.asset(
                  "assets/images/calender_icon_choose.svg",
                  color: loginButtonColor,
                ),
                sizedBoxHeight8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "$month/$day",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
