import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:health_studio_user/core/controllers/bottom_navigation_bar_controller.dart';
import 'package:health_studio_user/core/models/bottom_nav_item.dart';
import 'package:health_studio_user/utils/colors.dart';

Widget bottomNavigationBar() {
  return GetBuilder<BottomNavigationController>(
    init: BottomNavigationController(),
    builder: (controller) => BottomNavigationBar(
        showSelectedLabels: false,
        backgroundColor: Colors.red,
        selectedItemColor: activeIconColor,
        currentIndex: controller.currentIndex,
        items: [
          BottomNavItem(
            label: "Home",
            iconPath: "assets/images/bottom_bar_home.svg",
          ),
          BottomNavItem(
            label: "Cart",
            iconPath: "assets/images/bottom_bar_shopping_bag.svg",
          ),
          BottomNavItem(
            label: "Search",
            iconPath: "assets/images/bottom_bar_search.svg",
          ),
          BottomNavItem(
            label: "Profile",
            iconPath: "assets/images/bottom_bar_profile.svg",
          ),
        ]
            .map(
              (e) => BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  e.iconPath,
                  color: activeIconColor,
                ),
                icon: SvgPicture.asset(
                  e.iconPath,
                  color: Colors.black,
                ),
                label: e.label,
              ),
            )
            .toList(),
        onTap: (index) {
          controller.currentIndex = index;
          controller.update();
        }),
  );
}
