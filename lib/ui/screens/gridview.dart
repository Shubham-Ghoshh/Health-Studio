import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/home_controller.dart';
import 'package:health_studio_user/ui/widgets/home_page_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';

class View extends StatelessWidget {
  const View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (homeController) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: whiteColor,
              child: const Icon(
                Icons.add,
                color: loginButtonColor,
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: SafeArea(
                child: homeController.menu.isEmpty
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
                    : Expanded(
                        child: Padding(
                          padding: edgeInsetsleft16,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemCount: homeController.menu.length,
                            itemBuilder: (BuildContext context, int index) {
                              return FoodMenuItem(
                                menu: homeController.menu[index],
                                height: 125,
                              );
                            },
                          ),
                        ),
                      ),
              ),
            ),
          );
        });
  }
}
