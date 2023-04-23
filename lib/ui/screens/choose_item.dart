import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:health_studio_user/core/controllers/userDashboardController.dart';
import 'package:health_studio_user/core/models/user_dashboard.dart';
import 'package:health_studio_user/ui/screens/meal_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';

class ChooseMeal extends StatelessWidget {
  final int itemIndex;
  final DashboardItem? item;
  final String type;
  const ChooseMeal(
      {Key? key, required this.item, required this.type, this.itemIndex = 0})
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
          height: 1.sh,
          width: 1.sw,
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
                  : SingleChildScrollView(
                      child: Center(
                        child: SizedBox(
                          width: 1.sw,
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: userDashboardController.meals.map((meal) {
                              return MealItem(
                                meal: meal,
                                item: item,
                                type: type,
                                itemIndex: itemIndex,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    )),
        );
      }),
    );
  }
}
