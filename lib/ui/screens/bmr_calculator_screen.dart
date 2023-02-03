import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:health_studio_user/core/controllers/auth_controller.dart';
import 'package:health_studio_user/core/controllers/bmr_calculator_controller.dart';
import 'package:health_studio_user/ui/widgets/app_bar.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:health_studio_user/utils/buttons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class BMRCalculatorPage extends StatefulWidget {
  const BMRCalculatorPage({super.key});

  @override
  State<BMRCalculatorPage> createState() => _BMRCalculatorPageState();
}

class _BMRCalculatorPageState extends State<BMRCalculatorPage> {
  final TextEditingController _genderController = TextEditingController();
  bool isVisible = false;
  List<String> get items => [
        AppLocalizations.of(context)!.male,
        AppLocalizations.of(context)!.female
      ];
  final fromkey = GlobalKey<FormState>();
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                sizedBoxHeight6,
                appBar(),
                sizedBoxHeight20,
                Form(
                  key: fromkey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GetBuilder<BMRController>(
                      init: BMRController(),
                      builder: (bmrController) => Column(
                        children: [
                          const Text(
                            "Calorie Calculator",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xffFFFDFD),
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                            ),
                          ),
                          sizedBoxHeight25,
                          TextFormField(
                            validator: ((value) {
                              if (value?.isEmpty ?? true) {
                                return "Weight cannot be empty.";
                              } else {
                                return null;
                              }
                            }),
                            onChanged: (value) {
                              bmrController.weight = value;
                              bmrController.update();
                            },
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                              color: Color(0xff0A0909),
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: const InputDecoration(
                              hintText: "Enter your weight in KG",
                            ),
                          ),
                          sizedBoxHeight16,
                          TextFormField(
                            validator: ((value) {
                              if (value?.isEmpty ?? true) {
                                return "Height cannot be empty.";
                              } else {
                                return null;
                              }
                            }),
                            onChanged: (value) {
                              bmrController.height = value;
                              bmrController.update();
                            },
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                              color: Color(0xff0A0909),
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: const InputDecoration(
                              hintText: "Enter your height in cm",
                            ),
                          ),
                          sizedBoxHeight16,
                          TextFormField(
                            validator: ((value) {
                              if (value?.isEmpty ?? true) {
                                return "Age cannot be empty.";
                              } else {
                                return null;
                              }
                            }),
                            onChanged: (value) {
                              bmrController.age = value;
                              bmrController.update();
                            },
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                              color: Color(0xff0A0909),
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: const InputDecoration(
                              hintText: "Enter your age",
                            ),
                          ),
                          sizedBoxHeight16,
                          GetBuilder<AuthController>(
                            builder: (authController) => TextFormField(
                              validator: ((value) {
                                if (value?.isEmpty ?? true) {
                                  return "Gender cannot be empty.";
                                } else {
                                  return null;
                                }
                              }),
                              readOnly: true,
                              controller: _genderController,
                              cursorColor: Colors.black,
                              style: const TextStyle(
                                color: Color(0xff0A0909),
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                  hintText: "Select your gender",
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
                          ),
                          sizedBoxHeight40,
                          LoginButton(
                              height: 52,
                              title: "CALCULATE",
                              enabled: true,
                              onTap: () {
                                if (fromkey.currentState!.validate()) {
                                  setState(() {
                                    isVisible = true;
                                  });
                                  if (_genderController.text ==
                                      AppLocalizations.of(context)!.male) {
                                    bmrController.bmr = 66.5 +
                                        (13.75 *
                                                double.parse(
                                                    bmrController.weight) +
                                            (5.003 *
                                                double.parse(
                                                    bmrController.height)) -
                                            (6.75 *
                                                double.parse(
                                                    bmrController.age)));
                                    bmrController.update();
                                  } else {
                                    bmrController.bmr = 655.1 +
                                        (9.563 *
                                                double.parse(
                                                    bmrController.weight) +
                                            1.850 *
                                                double.parse(
                                                    bmrController.height) -
                                            4.676 *
                                                double.parse(
                                                    bmrController.age));
                                    bmrController.update();
                                  }
                                }
                              }),
                          sizedBoxHeight75,
                          Visibility(
                            visible: isVisible,
                            child: Text(
                              "${bmrController.bmr.toStringAsFixed(2)} kcal/day",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xffFFFDFD),
                                fontWeight: FontWeight.w800,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
          ),
        ],
      ),
    );
  }
}
