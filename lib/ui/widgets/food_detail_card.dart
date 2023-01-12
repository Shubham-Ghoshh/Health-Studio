import 'package:flutter/material.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FoodDetailCard extends StatelessWidget {
  const FoodDetailCard({
    required this.nutritionContent,
    required this.foodName,
    required this.foodDescription,
    Key? key,
  }) : super(key: key);

  final List<Widget> nutritionContent;
  final String foodName;
  final String foodDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: edgeInsets16,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                foodName,
                style: const TextStyle(
                  color: Color(0xffFAAF4A),
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              Text(
                foodDescription,
                style: const TextStyle(
                  color: Color(0xff0A0909),
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.diet_reference,
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  color: Color(0xff2A7891),
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const Divider(
            color: Color(0xFFD9D9D9),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: nutritionContent,
              ),
              sizedBoxHeight10
            ],
          )
        ],
      ),
    );
  }
}

class NutritionContent extends StatelessWidget {
  const NutritionContent({
    required this.image,
    required this.nutritionContent,
    required this.nutritionName,
    Key? key,
  }) : super(key: key);

  final Widget image;
  final String nutritionContent;
  final String nutritionName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12, right: 8, left: 8),
          child: SizedBox(
            height: 45,
            width: 45,
            child: image,
          ),
        ),
        Text(
          nutritionContent,
          style: TextStyle(
            color: const Color(0xff2A7891),
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
          ),
        ),
        Text(
          nutritionName,
          style: TextStyle(
            color: const Color(0xff2A7891),
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
