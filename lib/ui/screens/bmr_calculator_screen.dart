import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:health_studio_user/core/controllers/auth_controller.dart';
import 'package:health_studio_user/core/controllers/bmr_calculator_controller.dart';
import 'package:health_studio_user/ui/screens/bmr_calculations_screen.dart';
import 'package:health_studio_user/ui/widgets/app_bar.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:health_studio_user/utils/buttons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BMRCalculatorPage extends StatefulWidget {
  const BMRCalculatorPage({super.key});

  @override
  State<BMRCalculatorPage> createState() => _BMRCalculatorPageState();
}

class _BMRCalculatorPageState extends State<BMRCalculatorPage> {
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _activityLevelController =
      TextEditingController();
  final TextEditingController _weightPlanController = TextEditingController();
  bool isVisible = false;
  bool isEnabled = false;
  List<String> get genderItems => [
        AppLocalizations.of(context)!.male,
        AppLocalizations.of(context)!.female
      ];
  List<String> get activityLevelItems => [
        "Little/No Exercise",
        "Exercise 1-2 times/week",
        "Exercise 2-3 times/week",
        "Exercise 3-5 times/week",
        "Exercise 6-7 times/week",
        "Professional Athlete"
      ];
  List<String> get weightPlanItems => [
        "Weight Gain",
        "Weight Loss",
        "Maintain Weight",
      ];
  final formKey = GlobalKey<FormState>();

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
                  key: formKey,
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
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9.]")),
                              TextInputFormatter.withFunction(
                                  (oldValue, newValue) {
                                try {
                                  final text = newValue.text;
                                  if (text.isNotEmpty) double.parse(text);
                                  return newValue;
                                } catch (e) {}
                                return oldValue;
                              }),
                            ],
                            textAlign: TextAlign.end,
                            validator: ((value) {
                              if (value?.isEmpty ?? true) {
                                isVisible = false;
                                isEnabled = false;
                                return "Weight cannot be empty";
                              }
                              if (double.parse(value!) <= 0) {
                                isVisible = false;
                                isEnabled = false;
                                return "Weight should be greater than 0 kg";
                              }
                              if (double.parse(value) > 450 ||
                                  double.parse(value) <= 2) {
                                isVisible = false;
                                isEnabled = false;
                                return "Please provide a realistic weight";
                              } else {
                                return null;
                              }
                            }),
                            onChanged: (value) {
                              bmrController.weight = value;
                              bmrController.update();
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isEnabled = true;
                                });
                              }
                            },
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                              color: Color(0xff0A0909),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: const InputDecoration(
                              suffix: Text(
                                "kg",
                                style: TextStyle(
                                  color: Color(0xff0A0909),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(
                                    top: 11, left: 10, right: 10),
                                child: Text(
                                  "WEIGHT :",
                                  style: TextStyle(
                                    color: Color.fromARGB(160, 10, 9, 9),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          sizedBoxHeight16,
                          TextFormField(
                            textAlign: TextAlign.end,
                            validator: ((value) {
                              if (value?.isEmpty ?? true) {
                                isVisible = false;
                                isEnabled = false;
                                return "Height cannot be empty";
                              }
                              if (double.parse(value!) <= 0) {
                                isVisible = false;
                                isEnabled = false;
                                return "Height should be greater than 0 cm";
                              }
                              if (double.parse(value!) > 280 ||
                                  double.parse(value!) < 60) {
                                isVisible = false;
                                isEnabled = false;
                                return "Please provide a realistic height";
                              } else {
                                return null;
                              }
                            }),
                            onChanged: (value) {
                              bmrController.height = value;
                              bmrController.update();
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isEnabled = true;
                                });
                              }
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9.]")),
                              TextInputFormatter.withFunction(
                                  (oldValue, newValue) {
                                try {
                                  final text = newValue.text;
                                  if (text.isNotEmpty) double.parse(text);
                                  return newValue;
                                } catch (e) {}
                                return oldValue;
                              }),
                            ],
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                              color: Color(0xff0A0909),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: const InputDecoration(
                              suffix: Text(
                                "cm",
                                style: TextStyle(
                                  color: Color(0xff0A0909),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(
                                    top: 11, left: 10, right: 10),
                                child: Text(
                                  "HEIGHT :",
                                  style: TextStyle(
                                    color: Color.fromARGB(160, 10, 9, 9),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          sizedBoxHeight16,
                          GetBuilder<AuthController>(
                            builder: (authController) => TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r"[0-9]")),
                              ],
                              textAlign: TextAlign.end,
                              // initialValue: authController.age,
                              validator: ((value) {
                                if (value?.isEmpty ?? true) {
                                  isVisible = false;
                                  return "Age cannot be empty";
                                } else if (int.parse(value!) < 18) {
                                  isVisible = false;
                                  isEnabled = false;
                                  return "Not applicable for children(under 18 years)";
                                } else if (int.parse(value!) > 150) {
                                  isVisible = false;
                                  isEnabled = false;
                                  return "Please provide a realistic age";
                                } else {
                                  return null;
                                }
                              }),
                              onChanged: (value) {
                                bmrController.age = value;
                                bmrController.update();
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    isEnabled = true;
                                  });
                                }
                              },
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.black,
                              style: const TextStyle(
                                color: Color(0xff0A0909),
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: const InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(
                                      top: 11, left: 10, right: 10),
                                  child: Text(
                                    "AGE :",
                                    style: TextStyle(
                                      color: Color.fromARGB(160, 10, 9, 9),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          sizedBoxHeight16,
                          GetBuilder<AuthController>(
                            builder: (authController) => TextFormField(
                              textAlign: TextAlign.end,
                              // initialValue: authController.gender,
                              validator: ((value) {
                                if (value?.isEmpty ?? true) {
                                  isVisible = false;
                                  return "Gender cannot be empty";
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
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.only(
                                        top: 11, left: 10, right: 10),
                                    child: Text(
                                      "GENDER :",
                                      style: TextStyle(
                                        color: Color.fromARGB(160, 10, 9, 9),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  suffixIcon: PopupMenuButton<String>(
                                    itemBuilder: (BuildContext context) {
                                      return genderItems
                                          .map<PopupMenuItem<String>>(
                                              (String genderValue) {
                                        return PopupMenuItem(
                                            value: genderValue,
                                            child: Text(
                                              genderValue,
                                              style: const TextStyle(
                                                color: Color(0xff0A0909),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ));
                                      }).toList();
                                    },
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(0xff0A0909),
                                    ),
                                    onSelected: (String value) {
                                      _genderController.text = value;
                                      if (formKey.currentState!.validate()) {
                                        setState(() {
                                          isEnabled = true;
                                        });
                                      }
                                    },
                                  )),
                            ),
                          ),
                          sizedBoxHeight16,
                          TextFormField(
                            textAlign: TextAlign.start,
                            validator: ((value) {
                              if (value?.isEmpty ?? true) {
                                isVisible = false;
                                return "Activity Level cannot be empty";
                              } else {
                                return null;
                              }
                            }),
                            readOnly: true,
                            controller: _activityLevelController,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                              color: Color(0xff0A0909),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                                labelText: "ACTIVITY LEVEL :",
                                labelStyle: const TextStyle(
                                  color: Color.fromARGB(160, 10, 9, 9),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                                suffixIcon: PopupMenuButton<String>(
                                  itemBuilder: (BuildContext context) {
                                    return activityLevelItems
                                        .map<PopupMenuItem<String>>(
                                            (String value) {
                                      return PopupMenuItem(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: const TextStyle(
                                              color: Color(0xff0A0909),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ));
                                    }).toList();
                                  },
                                  icon: const Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(0xff0A0909),
                                    ),
                                  ),
                                  onSelected: (String value) {
                                    _activityLevelController.text = value;
                                    if (formKey.currentState!.validate()) {
                                      setState(() {
                                        isEnabled = true;
                                      });
                                    }
                                  },
                                )),
                          ),
                          sizedBoxHeight16,
                          TextFormField(
                            textAlign: TextAlign.start,
                            validator: ((value) {
                              if (value?.isEmpty ?? true) {
                                isVisible = false;
                                return "Weight plan cannot be empty";
                              } else {
                                return null;
                              }
                            }),
                            readOnly: true,
                            controller: _weightPlanController,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                              color: Color(0xff0A0909),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                                labelText: "WEIGHT PLAN :",
                                labelStyle: const TextStyle(
                                  color: Color.fromARGB(160, 10, 9, 9),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                                suffixIcon: PopupMenuButton<String>(
                                  itemBuilder: (BuildContext context) {
                                    return weightPlanItems
                                        .map<PopupMenuItem<String>>(
                                            (String value) {
                                      return PopupMenuItem(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: const TextStyle(
                                              color: Color(0xff0A0909),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ));
                                    }).toList();
                                  },
                                  icon: const Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(0xff0A0909),
                                    ),
                                  ),
                                  onSelected: (String value) {
                                    _weightPlanController.text = value;
                                    if (formKey.currentState!.validate()) {
                                      setState(() {
                                        isEnabled = true;
                                      });
                                    }
                                  },
                                )),
                          ),
                          sizedBoxHeight40,
                          LoginButton(
                              height: 52,
                              title: "CALCULATE",
                              enabled: isEnabled,
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    isVisible = true;
                                  });
                                  bmrController.bmi = (double.parse(
                                              bmrController.weight) /
                                          (double.parse(bmrController.height) *
                                              double.parse(
                                                  bmrController.height))) *
                                      10000;
                                  bmrController.update();
                                  if (bmrController.bmi < 18.5) {
                                    bmrController.bmiMessage =
                                        "Your BMI is lower than normal.\nPlease visit your doctor.";
                                  }
                                  if (bmrController.bmi > 18.5 &&
                                      bmrController.bmi < 25) {
                                    bmrController.bmiMessage =
                                        "Great, you have a normal BMI.";
                                  }
                                  if (bmrController.bmi > 25) {
                                    bmrController.bmiMessage =
                                        "Your BMI is greater than normal.\nPlease visit your doctor.";
                                  }

                                  if (_genderController.text ==
                                      AppLocalizations.of(context)!.male) {
                                    bmrController.bmr = (10 *
                                            double.parse(
                                                bmrController.weight)) +
                                        (6.25 *
                                            double.parse(
                                                bmrController.height)) -
                                        (5 * double.parse(bmrController.age)) +
                                        5;

                                    bmrController.update();
                                  } else {
                                    bmrController.bmr = (10 *
                                            double.parse(
                                                bmrController.weight)) +
                                        (6.25 *
                                            double.parse(
                                                bmrController.height)) -
                                        (5 * double.parse(bmrController.age)) -
                                        161;

                                    bmrController.update();
                                  }

                                  if (_activityLevelController.text ==
                                      "Little/No Exercise") {
                                    bmrController.bmr *= 1.2;
                                  } else if (_activityLevelController.text ==
                                      "Exercise 1-2 times/week") {
                                    bmrController.bmr *= 1.4;
                                  } else if (_activityLevelController.text ==
                                      "Exercise 2-3 times/week") {
                                    bmrController.bmr *= 1.6;
                                  } else if (_activityLevelController.text ==
                                      "Exercise 3-5 times/week") {
                                    bmrController.bmr *= 1.75;
                                  } else if (_activityLevelController.text ==
                                      "Exercise 6-7 times/week") {
                                    bmrController.bmr *= 2;
                                  } else {
                                    bmrController.bmr *= 2.3;
                                  }
                                  bmrController.update();

                                  if (_weightPlanController.text ==
                                      "Weight Gain") {
                                    bmrController.bmr += 300;
                                    bmrController.carbs =
                                        (bmrController.bmr * 0.45)
                                            .roundToDouble();
                                    bmrController.proteins =
                                        (bmrController.bmr * 0.45)
                                            .roundToDouble();
                                    bmrController.fats =
                                        (bmrController.bmr * 0.10)
                                            .roundToDouble();
                                  }
                                  if (_weightPlanController.text ==
                                      "Maintain Weight") {
                                    bmrController.carbs =
                                        (bmrController.bmr * 0.50)
                                            .roundToDouble();
                                    bmrController.proteins =
                                        (bmrController.bmr * 0.30)
                                            .roundToDouble();
                                    bmrController.fats =
                                        (bmrController.bmr * 0.20)
                                            .roundToDouble();
                                  }
                                  if (_weightPlanController.text ==
                                      "Weight Loss") {
                                    bmrController.bmr -= 300;
                                    bmrController.carbs =
                                        (bmrController.bmr * 0.50)
                                            .roundToDouble();
                                    bmrController.proteins =
                                        (bmrController.bmr * 0.35)
                                            .roundToDouble();
                                    bmrController.fats =
                                        (bmrController.bmr * 0.15)
                                            .roundToDouble();
                                  }
                                  bmrController.update();
                                  Get.to(() => const BMRCalculationsPage());
                                }
                              }),
                          sizedBoxHeight14,
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
