import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      //adding margin causes overflow
      // width: 360,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBoxHeight10,
                Text(
                  foodName,
                  style: const TextStyle(
                    color: Color(0xffFAAF4A),
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                    fontSize: 21,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0, bottom: 14),
                  child: Text(
                    foodDescription,
                    style: const TextStyle(
                      color: Color(0xff0A0909),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                      fontSize: 17,
                    ),
                  ),
                ),
                const Text(
                  "Diet Reference",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color(0xff2A7891),
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: nutritionContent,
                ),
                sizedBoxHeight10
              ],
            ),
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

  final String image;
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
            child: SvgPicture.asset("assets/images/$image.svg"),
          ),
        ),
        Text(
          nutritionContent,
          style: TextStyle(
            color: const Color(0xff2A7891),
            fontWeight: FontWeight.w700,
            fontFamily: "Poppins",
            fontSize: 18.sp,
          ),
        ),
        Text(
          nutritionName,
          style: TextStyle(
            color: const Color(0xff2A7891),
            fontWeight: FontWeight.w400,
            fontFamily: "Poppins",
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
