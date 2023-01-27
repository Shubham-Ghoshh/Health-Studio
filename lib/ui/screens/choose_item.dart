import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:health_studio_user/core/controllers/userDashboardController.dart';
import 'package:health_studio_user/core/models/user_dashboard.dart';
import 'package:health_studio_user/ui/screens/meal_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';

class ChooseMeal extends StatelessWidget {
  final DashboardItem item;
  final String type;
  const ChooseMeal({Key? key, required this.item, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: plantextColor,
        elevation: 0,
        title: Text(AppLocalizations.of(context)!.choose_item),
      ),
      body: GetBuilder<UserDashboardController>(
          builder: (userDashboardController) {
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: SafeArea(
            child: userDashboardController.meals.isEmpty
                ? Center(
                    child: Text(
                      AppLocalizations.of(context)!.no_items_available,
                      style: const TextStyle(
                        color: Color(0xffFFFDFD),
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  )
                : Padding(
                    padding: edgeInsetsleft16,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: userDashboardController.meals.length,
                      itemBuilder: (BuildContext context, int index) {
                        return MealItem(
                          meal: userDashboardController.meals[index],
                          height: 125,
                          item: item,
                          type: type,
                        );
                      },
                    ),
                  ),
          ),
        );
      }),
    );
  }
}
