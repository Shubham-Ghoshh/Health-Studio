import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:health_studio_user/core/controllers/auth_controller.dart';
import 'package:health_studio_user/ui/screens/authentication/sign_up_screen.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:health_studio_user/utils/buttons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatelessWidget {
  final Function()? onSuccess;
  const LoginPage({super.key, this.onSuccess});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (authController) {
          return Scaffold(
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
                SafeArea(
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
                        Center(
                          child: SizedBox(
                            height: 75,
                            child: Image.asset(
                              "assets/images/health_studio_logo.png",
                            ),
                          ),
                        ),
                        sizedBoxHeight16,
                        Text(
                          "${AppLocalizations.of(context)!.welcome}\n${AppLocalizations.of(context)!.welcome_message}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xffFFFDFD),
                            fontWeight: FontWeight.w600,
                            fontSize: 28,
                          ),
                        ),
                        sizedBoxHeight16,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: TextFormField(
                            validator: ((value) {
                              if (value?.isEmpty ?? true) {
                                return AppLocalizations.of(context)!
                                    .valid_mobile_no;
                              } else if (value?.length != 8) {
                                return AppLocalizations.of(context)!
                                    .mobile_no_format;
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
                              color: Color(0xff0A0909),
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.mobile_no,
                            ),
                          ),
                        ),
                        sizedBoxHeight6,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: TextFormField(
                            onChanged: ((value) {
                              authController.password = value;
                              authController.update();
                            }),
                            validator: ((value) {
                              if (value?.isEmpty ?? true) {
                                return AppLocalizations.of(context)!
                                    .valid_password;
                              } else if ((value?.length ?? 0) < 5) {
                                return AppLocalizations.of(context)!
                                    .password_format;
                              } else {
                                return null;
                              }
                            }),
                            cursorColor: Colors.black,
                            obscureText: true,
                            style: const TextStyle(
                              color: Color(0xff0A0909),
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.password,
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
                              child: Text(
                                AppLocalizations.of(context)!.forgot_password,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              onTap: () {},
                            ),
                          ),
                        ),
                        sizedBoxHeight6,
                        LoginButton(
                          height: 52,
                          title: AppLocalizations.of(context)!.login,
                          enabled: authController.isValid,
                          onTap: () {
                            authController.login(onSuccess: onSuccess);
                          },
                        ),
                        sizedBoxHeight16,
                        Text(
                          AppLocalizations.of(context)!.login_social_networks,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xffFFFDFD),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
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
                              onTap: () async {},
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.no_account,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xffFFFDFD),
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.to(() => const RegistrationPage());
                              },
                              child: Text(
                                AppLocalizations.of(context)!.sign_up_now,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color(0xffFFFDFD),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
