import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.onTap,
    required this.enabled,
  }) : super(key: key);

  final Function() onTap;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    print(enabled);
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Padding(
        padding: EdgeInsets.only(
          top: .03.sh,
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
            height: 70,
            child: const Center(
              child: Text(
                "LOGIN",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xffFFFEFE),
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                  fontSize: 19,
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
          height: 55,
          width: 60,
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
          height: 55,
          width: 60,
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
          height: 55,
          width: 60,
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
          height: 52.h,
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
