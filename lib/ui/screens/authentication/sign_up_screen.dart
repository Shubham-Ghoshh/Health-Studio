import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:health_studio_user/core/controllers/auth_controller.dart';
import 'package:health_studio_user/ui/widgets/app_bar.dart';
import 'package:health_studio_user/ui/widgets/bottom_navigation_bar.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:health_studio_user/utils/buttons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  var items = ["Male", "Female"];
  @override
  Widget build(BuildContext context) {
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
        SingleChildScrollView(
          child: SafeArea(
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
                        onChanged: (value) {},
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
                        validator: ((value) {
                          if (value?.isEmpty ?? true) {
                            return AppLocalizations.of(context)!.valid_password;
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
                          if (value?.isEmpty ?? true) {
                            return AppLocalizations.of(context)!.valid_password;
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
                          hintText: "Enter your password again",
                        ),
                      ),
                      sizedBoxHeight10,
                      TextFormField(
                        onChanged: (value) {},
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
                        onChanged: (value) {},
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
                        controller: _dobController,
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
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
                              _dobController.text = formattedDate.toString();
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
                                return items
                                    .map<PopupMenuItem<String>>((String value) {
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
                              },
                            )),
                      ),
                      sizedBoxHeight40,
                      LoginButton(
                        height: 52,
                        title: "SIGN UP",
                        enabled: true,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
