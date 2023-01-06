import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_studio_user/utils/colors.dart';

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
