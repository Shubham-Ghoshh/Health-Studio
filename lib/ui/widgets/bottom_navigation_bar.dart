import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:health_studio_user/core/controllers/bottom_navigation_bar_controller.dart';
import 'package:health_studio_user/core/models/bottom_nav_item.dart';
import 'package:health_studio_user/utils/colors.dart';

Widget bottomNavigationBar() {
  return GetBuilder<BottomNavigationController>(
    init: BottomNavigationController(),
    builder: (controller) => SizedBox(
      height: 64,
      child: BottomNavigationBar(
          showSelectedLabels: false,
          backgroundColor: Colors.red,
          selectedItemColor: activeIconColor,
          currentIndex: controller.currentIndex,
          items: [
            BottomNavItem(
                label: "Home",
                iconPath: "assets/images/bottom_bar_home.svg",
                iconData: Icons.home),
            BottomNavItem(
                label: "Cart",
                iconPath: "assets/images/bottom_bar_shopping_bag.svg",
                iconData: Icons.shopping_bag_outlined),
            BottomNavItem(
                label: "Search",
                iconPath: "assets/images/bottom_bar_search.svg",
                iconData: Icons.search),
            BottomNavItem(
              label: "Profile",
              iconPath: "assets/images/bottom_bar_profile.svg",
              iconData: Icons.person_outline_outlined,
            ),
          ]
              .map(
                (e) => BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    e.iconPath,
                    color: activeIconColor,
                  ),
                  // activeIcon: Icon(
                  //   e.iconData,
                  //   color: activeIconColor,
                  // ),
                  icon: SvgPicture.asset(
                    e.iconPath,
                    color: Colors.black,
                  ),
                  // icon: Icon(
                  //   e.iconData,
                  //   color: Colors.black,
                  // ),
                  label: e.label,
                ),
              )
              .toList(),
          onTap: (index) {
            controller.currentIndex = index;
            controller.update();
          }),
    ),
  );
}
