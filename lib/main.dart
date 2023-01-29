import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:health_studio_user/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:health_studio_user/core/bindings.dart';
import 'package:health_studio_user/ui/screens/splash_screen.dart';
import 'package:health_studio_user/utils/constants.dart';
import 'package:health_studio_user/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var lang = prefs.getBool("language") ?? true;
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    if (!Platform.isIOS) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  }
  runApp(
    ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MyApp(
          lang: lang,
        );
      },
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
      locale: lang ? const Locale('en', '') : const Locale('ar', ''),
      debugShowCheckedModeBanner: false,
      title: 'Health Studio',
      home: const SplashScreen(),
      initialBinding: AllBinder(),
    );
  }
}
