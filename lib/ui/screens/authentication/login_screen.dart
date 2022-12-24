import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:health_studio_user/core/controllers/auth_controller.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:health_studio_user/utils/buttons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (authController) {
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
                    child: Form(
                      key: authController.formKey,
                      onChanged: () {
                        authController.isValid =
                            authController.formKey.currentState?.validate() ??
                                false;
                        authController.update();
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            child: TextFormField(
                              validator: ((value) {
                                if (value?.isEmpty ?? true) {
                                  return "Please enter a valid mobile number";
                                } else if (value?.length != 8) {
                                  return "Mobile number should be 8 digits";
                                } else {
                                  return null;
                                }
                              }),
                              onChanged: (value) {
                                authController.mobile = value;
                                authController.update();
                              },
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.black,
                              style: const TextStyle(
                                fontFamily: "Poppins",
                                color: Color(0xff0A0909),
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Mobile Number',
                              ),
                            ),
                          ),
                          sizedBoxHeight16,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: TextFormField(
                              onChanged: ((value) {
                                authController.password = value;
                                authController.update();
                              }),
                              validator: ((value) {
                                if (value?.isEmpty ?? true) {
                                  return "Please enter a valid password";
                                } else if ((value?.length ?? 0) < 5) {
                                  return "Password should be more than 5 characters";
                                } else {
                                  return null;
                                }
                              }),
                              cursorColor: Colors.black,
                              obscureText: true,
                              style: const TextStyle(
                                color: Color(0xff0A0909),
                                fontFamily: "Poppins",
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Password',
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
                            enabled: authController.isValid,
                            onTap: () {
                              authController.login();
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
                ),
              ],
            ),
          );
        });
  }
}
