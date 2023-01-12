import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:health_studio_user/ui/screens/select_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:health_studio_user/core/bindings.dart';
import 'package:health_studio_user/ui/screens/logged_in_home_screen.dart';
import 'package:health_studio_user/ui/screens/splash_screen.dart';
import 'package:health_studio_user/utils/constants.dart';
import 'package:health_studio_user/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var lang = prefs.getBool("language") ?? true;
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MyApp(
            lang: lang,
          );
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.lang});
  final bool lang;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('ar', ''), // Arabic, no country code
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      navigatorKey: navigatorKey,
      theme: themeData(),
      useInheritedMediaQuery: true,
      locale: lang ? const Locale('en', '') : const Locale('ar', ''),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Health Studio',
      home: const SelectMenuPage(),
      initialBinding: AllBinder(),
    );
  }
}
