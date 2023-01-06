import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/ui/screens/authentication/login_screen.dart';
import 'package:health_studio_user/ui/screens/home_screen.dart';
import 'package:health_studio_user/utils/buttons.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/splashimg.png",
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fitWidth,
            width: MediaQuery.of(context).size.width,
          ),
          Container(height: Get.height, color: splashthemeColor),
          Padding(
            padding: edgeInsets8,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/apptitle.png'),
                  Column(
                    children: [
                      Padding(
                        padding: edgeInsets16,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                                child: SplashButton(
                                    onTap: () {
                                      Get.to(() => const HomePage());
                                    },
                                    buttontitle: 'English',
                                    imagepath:
                                        'assets/images/englishbuttonlogo.png',
                                    buttonColor: splashbuttonColor1)),
                            sizedBoxWidth12,
                            Expanded(
                                child: SplashButton(
                              onTap: () {},
                              buttontitle: 'عربي',
                              imagepath: 'assets/images/arabicbtnlogo.png',
                              buttonColor: splashbuttonColor2,
                            )),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already A User? ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: whiteColor)),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const LoginPage());
                            },
                            child: Text(
                              'Login Now',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    decoration: TextDecoration.underline,
                                    color: whiteColor,
                                  ),
                            ),
                          )
                        ],
                      ),
                      sizedBoxHeight10,
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
