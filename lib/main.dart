import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/bindings.dart';
import 'package:health_studio_user/ui/screens/logged_in_home_screen.dart';
import 'package:health_studio_user/ui/screens/splash_screen.dart';
import 'package:health_studio_user/utils/constants.dart';
import 'package:health_studio_user/utils/theme.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return const MyApp();
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      theme: themeData(),
      useInheritedMediaQuery: true,
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Health Studio',
      home: const SplashScreen(),
      initialBinding: AllBinder(),
    );
  }
}
