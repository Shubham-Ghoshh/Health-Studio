import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_studio_user/utils/colors.dart';

ThemeData themeData() {
  return ThemeData(
    textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 13.sp, color: whiteColor, fontWeight: FontWeight.w700),
    ),
  );
}
