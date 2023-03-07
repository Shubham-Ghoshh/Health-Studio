import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:health_studio_user/core/controllers/language_controller.dart';
import 'package:health_studio_user/core/controllers/menu_controller.dart';
import 'package:health_studio_user/core/models/menu.dart';
import 'package:health_studio_user/ui/screens/food_detail_screen.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:get/get.dart';

class FoodMenuItem extends StatefulWidget {
  const FoodMenuItem({
    required this.menu,
    required this.height,
    Key? key,
  }) : super(key: key);

  final Menu menu;
  final double height;

  @override
  State<FoodMenuItem> createState() => _FoodMenuItemState();
}

class _FoodMenuItemState extends State<FoodMenuItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Get.put(CustomMenuController()).getMenuDetail(widget.menu.id);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SizedBox(
              // height: 280,
              // width: 180,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Hero(
                    tag: "food-image-${widget.menu.image}",
                    child: CachedNetworkImage(
                      imageUrl: widget.menu.image,
                      height: widget.height,
                      width: 150,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                          color: activeDateBgColor,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 280,
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(Icons.error),
                      ),
                    ),
                  )),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.5),
          child: SizedBox(
            width: 150,
            height: 20,
            child: GetBuilder<LanguageTogglerController>(
              builder: (languageController) => Text(
                languageController.isEnglish
                    ? widget.menu.titleEn
                    : widget.menu.titleAr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xffFFFDFD),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class CalenderDayDate extends StatefulWidget {
  CalenderDayDate({
    required this.date,
    required this.day,
    Key? key,
  }) : super(key: key);

  String day;
  String date;
  @override
  State<CalenderDayDate> createState() => _CalenderDayDateState();
}

class _CalenderDayDateState extends State<CalenderDayDate> {
  bool click = false;

  Color inactiveBgColor = Colors.white;
  Color inactiveDateFontColor = const Color(0xff00732F);
  Color inactiveDayFontColor = const Color(0xffE11F3C);

  Color activeBgColor = const Color(0xffF1773E);
  Color activeDateFontColor = Colors.white;
  Color activeDayFontColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            click = !click;
          });
        },
        child: Container(
          height: 75,
          width: 85,
          decoration: BoxDecoration(
            color: click == true ? activeBgColor : inactiveBgColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.day,
                style: TextStyle(
                  color:
                      click == true ? activeDayFontColor : inactiveDayFontColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 17.5,
                ),
              ),
              Text(
                widget.date.toString(),
                style: TextStyle(
                  color: click == true
                      ? activeDateFontColor
                      : inactiveDateFontColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 17.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
