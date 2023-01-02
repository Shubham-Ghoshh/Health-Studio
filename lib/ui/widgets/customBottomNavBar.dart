import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/models/bottom_nav_item.dart';
import 'package:health_studio_user/utils/colors.dart';

class CustomBottomAppBar extends StatefulWidget {
  const CustomBottomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomAppBar> createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        showSelectedLabels: false,
        backgroundColor: Colors.red,
        selectedItemColor: activeIconColor,
        currentIndex: _currentIndex,
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
          setState(() {
            _currentIndex = index;
          });
        });
  }
}
