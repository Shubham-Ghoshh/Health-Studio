import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/utils/colors.dart';

class SettingOptionItem extends StatefulWidget {
  const SettingOptionItem({
    required this.settingIconImage,
    required this.settingName,
    this.optionalText = "",
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final String settingIconImage;
  final String settingName;
  final String optionalText;
  final VoidCallback onTap;

  @override
  State<SettingOptionItem> createState() => _SettingOptionItemState();
}

class _SettingOptionItemState extends State<SettingOptionItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 28,
                        width: 28,
                        child: Image.asset(
                          "assets/images/${widget.settingIconImage}.png",
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 28,
                      ),
                      Text(
                        widget.settingName,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.optionalText,
                    style: TextStyle(
                      color: const Color(0xff9E9E9E),
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Padding settingHeading(String headingText) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Text(
      headingText,
      style: TextStyle(
        shadows: const <Shadow>[
          Shadow(
            offset: Offset(2.0, 5.0),
            blurRadius: 5.0,
            color: Color.fromARGB(41, 0, 0, 0),
          ),
        ],
        color: loginButtonColor,
        fontWeight: FontWeight.w500,
        fontSize: 18.sp,
      ),
    ),
  );
}
