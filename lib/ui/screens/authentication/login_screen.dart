import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_studio_user/ui/screens/home_screen.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:health_studio_user/utils/buttons.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.shade400,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  sizedBoxHeight10,
                  Center(
                    child: SizedBox(
                      height: 75,
                      child: Image.asset(
                        "assets/images/health_studio_logo.png",
                      ),
                    ),
                  ),
                  sizedBoxHeight25,
                  const Text(
                    "Welcome ,\nGlad to see you !",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xffFFFDFD),
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                      fontSize: 30,
                    ),
                  ),
                  sizedBoxHeight25,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(150, 255, 255, 255),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Colors.black,
                          width: 0.15,
                        ),
                      ),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          color: Color(0xff0A0909),
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(183, 10, 9, 9),
                            fontFamily: "Poppins",
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  sizedBoxHeight16,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(150, 255, 255, 255),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Colors.black,
                          width: 0.15,
                        ),
                      ),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        obscureText: true,
                        style: const TextStyle(
                          color: Color(0xff0A0909),
                          fontFamily: "Poppins",
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 17,
                            color: Color.fromARGB(183, 10, 9, 9),
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  sizedBoxHeight6,
                  Padding(
                    padding: EdgeInsets.only(
                      right: 0.05.sw,
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ),
                  sizedBoxHeight10,
                  LoginButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                      // () => Get.to(() => const HomePage());
                    },
                  ),
                  sizedBoxHeight16,
                  const Text(
                    "OR Login Using Social Networks",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xffFFFDFD),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                      fontSize: 17,
                    ),
                  ),
                  sizedBoxHeight6,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FacebookLoginButton(
                        onTap: () {},
                      ),
                      GoogleLoginButton(
                        onTap: () {},
                      ),
                      AppleLoginButton(
                        onTap: () {},
                      ),
                    ],
                  ),
                  sizedBoxHeight52,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don’t have an account?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xffFFFDFD),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          fontSize: 17,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Sign Up Now",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color(0xffFFFDFD),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins",
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                  sizedBoxHeight16,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
