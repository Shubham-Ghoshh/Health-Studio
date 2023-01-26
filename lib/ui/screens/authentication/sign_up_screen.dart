import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:health_studio_user/core/controllers/auth_controller.dart';
import 'package:health_studio_user/ui/widgets/app_bar.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:health_studio_user/utils/buttons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class RegistrationPage extends StatefulWidget {
  final Function()? onSuccess;
  final bool isSocial;
  const RegistrationPage({
    super.key,
    this.onSuccess,
    this.isSocial = false,
  });

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  bool passwordsMatch = false;

  var items = ["Male", "Female"];

  _calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return "Email address is required.";
    } else if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (authController) => Scaffold(
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
                key: authController.signUpFormKey,
                onChanged: () {
                  if (authController.signUpFormKey.currentState?.validate() ??
                      false) {
                    authController.isValid = true;
                    authController.update();
                  } else {
                    authController.isValid = false;
                    authController.update();
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedBoxHeight6,
                    appBar(),
                    sizedBoxHeight20,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          const Text(
                            "Register",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xffFFFDFD),
                              fontWeight: FontWeight.w600,
                              fontSize: 28,
                            ),
                          ),
                          sizedBoxHeight16,
                          TextFormField(
                            initialValue: authController.mobile,
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
                            decoration: const InputDecoration(
                              hintText: "Enter your phone number",
                            ),
                          ),
                          sizedBoxHeight10,
                          TextFormField(
                            controller: _pass,
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
                            onChanged: (value) {},
                            obscureText: true,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                              color: Color(0xff0A0909),
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: const InputDecoration(
                              hintText: "Enter your password",
                            ),
                          ),
                          sizedBoxHeight10,
                          TextFormField(
                            validator: ((value) {
                              if (value != _pass.text) {
                                return "Passwords do not match";
                              } else {
                                passwordsMatch = true;
                              }
                            }),
                            onChanged: (value) {
                              if (passwordsMatch == true) {
                                authController.password = value;
                                authController.update();
                              }
                            },
                            obscureText: true,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                              color: Color(0xff0A0909),
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: const InputDecoration(
                              hintText: "Enter your password again",
                            ),
                          ),
                          sizedBoxHeight10,
                          TextFormField(
                            initialValue: authController.name,
                            validator: (value) =>
                                (value == null || value.isEmpty)
                                    ? "Full Name is required"
                                    : null,
                            onChanged: (value) {
                              authController.name = value;
                              authController.update();
                            },
                            keyboardType: TextInputType.name,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                              color: Color(0xff0A0909),
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: const InputDecoration(
                              hintText: "Enter your fullname",
                            ),
                          ),
                          sizedBoxHeight10,
                          TextFormField(
                            initialValue: authController.email,
                            validator: validateEmail,
                            onChanged: (value) {
                              authController.email = value;
                              authController.update();
                            },
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                              color: Color(0xff0A0909),
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: const InputDecoration(
                              hintText: "Enter your email",
                            ),
                          ),
                          sizedBoxHeight10,
                          TextFormField(
                            validator: (value) =>
                                (value == null || value.isEmpty)
                                    ? "Date of Birth is required"
                                    : null,
                            controller: _dobController,
                            readOnly: true,
                            onChanged: (value) {},
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                                builder: (context, child) => Theme(
                                    data: Theme.of(context).copyWith(
                                        colorScheme: const ColorScheme.light(
                                            primary: Color(0xffFAAF4A))),
                                    child: child!),
                              );
                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat("dd/MM/yyyy").format(pickedDate);

                                setState(() {
                                  _dobController.text =
                                      formattedDate.toString();
                                  authController.age =
                                      _calculateAge(pickedDate).toString();

                                  authController.update();
                                });
                              }
                            },
                            keyboardType: TextInputType.datetime,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                              color: Color(0xff0A0909),
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              hintText: "Your date of birth",
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: SizedBox(
                                  child: SvgPicture.asset(
                                      "assets/images/calender_icon.svg"),
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 16),
                            ),
                          ),
                          sizedBoxHeight10,
                          TextFormField(
                            validator: (value) =>
                                (value == null || value.isEmpty)
                                    ? "Gender is required"
                                    : null,
                            readOnly: true,
                            onChanged: (value) {},
                            controller: _genderController,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                              color: Color(0xff0A0909),
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                                hintText: "Your gender",
                                suffixIcon: PopupMenuButton<String>(
                                  itemBuilder: (BuildContext context) {
                                    return items.map<PopupMenuItem<String>>(
                                        (String value) {
                                      return PopupMenuItem(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: const TextStyle(
                                              color: Color(0xff0A0909),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                            ),
                                          ));
                                    }).toList();
                                  },
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                  ),
                                  onSelected: (String value) {
                                    _genderController.text = value;
                                    authController.gender = value;
                                    authController.update();
                                  },
                                )),
                          ),
                          sizedBoxHeight40,
                          LoginButton(
                            height: 52,
                            title: "SIGN UP",
                            enabled: authController.isValid && passwordsMatch,
                            onTap: () {
                              if (widget.isSocial) {
                                authController.registersocial(
                                  onSuccess: widget.onSuccess,
                                );
                              } else {
                                authController.signUp(
                                  onSuccess: widget.onSuccess,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
