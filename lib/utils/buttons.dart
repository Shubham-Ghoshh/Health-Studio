import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/auth_controller.dart';
import 'package:health_studio_user/core/controllers/order_controller.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../ui/screens/setting_screen.dart';

class LoginButton extends StatelessWidget {
  LoginButton({
    Key? key,
    required this.onTap,
    required this.enabled,
    required this.title,
    required this.height,
    this.width = double.infinity,
  }) : super(key: key);

  final Function() onTap;
  final bool enabled;
  final String title;
  double height;
  double width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 18,
          right: 18,
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: enabled
                  ? loginButtonColor
                  : loginButtonColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(6),
            ),
            height: height,
            width: width,
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xffFFFEFE),
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppleLoginButton extends StatelessWidget {
  const AppleLoginButton({
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          height: 45,
          width: 45,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SvgPicture.asset(
              "assets/images/apple_login.svg",
              color: const Color(0xff2A7891),
            ),
          ),
        ),
      ),
    );
  }
}

class FacebookLoginButton extends StatelessWidget {
  const FacebookLoginButton({
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          height: 45,
          width: 45,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SvgPicture.asset(
              "assets/images/facebook_login.svg",
              color: const Color(0xff2A7891),
            ),
          ),
        ),
      ),
    );
  }
}

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          height: 45,
          width: 45,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SvgPicture.asset(
              "assets/images/google_login.svg",
              color: const Color(0xff2A7891),
            ),
          ),
        ),
      ),
    );
  }
}

class SplashButton extends StatelessWidget {
  const SplashButton(
      {Key? key,
      required this.onTap,
      required this.buttontitle,
      required this.imagepath,
      required this.buttonColor})
      : super(key: key);
  final void Function() onTap;
  final String buttontitle;
  final String imagepath;
  final Color buttonColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            color: buttonColor,
            border: Border.all(
              width: 2.w,
              color: whiteColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          height: 52,
          child: Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Row(
              children: [
                Image.asset(imagepath),
                sizedBoxWidth12,
                Text(
                  buttontitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: whiteColor),
                )
              ],
            ),
          )),
    );
  }
}

GestureDetector payNowButton(dynamic context) {
  return GestureDetector(
    onTap: () {
      Get.find<OrderController>().getPaymentURL();
    },
    child: Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8, bottom: 18),
      child: Container(
        width: 380.w,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xffFAAF4A),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.pay_now,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18.sp,
            ),
          ),
        ),
      ),
    ),
  );
}

// ignore: non_constant_identifier_names
Widget SettingButton() {
  return Container(
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: Color(0xffE84C4F),
    ),
    child: IconButton(
      onPressed: () {
        Get.to(() => const SettingPage());
      },
      icon: Padding(
        padding: const EdgeInsets.all(0.25),
        child: SizedBox(
          height: 24,
          child: Image.asset("assets/images/settings_icon.png"),
        ),
      ),
    ),
  );
}
