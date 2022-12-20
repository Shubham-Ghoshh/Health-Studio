import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';

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
    return Container(
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
        ));
  }
}
