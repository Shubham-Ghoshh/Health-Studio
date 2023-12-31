import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_studio_user/utils/colors.dart';

ThemeData themeData() {
  return ThemeData(
    appBarTheme: const AppBarTheme(color: plantextColor),
    fontFamily: "Poppins",
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 13.sp,
        color: whiteColor,
        fontWeight: FontWeight.w700,
      ),
      bodyText2: TextStyle(
        fontSize: 14.sp,
        color: whiteColor,
        fontWeight: FontWeight.w500,
      ),
      headline1: TextStyle(
        color: textfieldcolor,
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
      ),
      headline2: TextStyle(
        color: textfieldcolor,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color.fromARGB(150, 255, 255, 255),
      contentPadding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
      hintStyle: const TextStyle(
        color: Color.fromARGB(183, 10, 9, 9),
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      border: InputBorder.none,
      errorStyle: TextStyle(
        color: whiteColor,
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
