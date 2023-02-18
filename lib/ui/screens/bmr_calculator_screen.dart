import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:health_studio_user/core/controllers/auth_controller.dart';
import 'package:health_studio_user/core/controllers/bmr_calculator_controller.dart';
import 'package:health_studio_user/ui/screens/bmr_calculations_screen.dart';
import 'package:health_studio_user/ui/widgets/app_bar.dart';
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
  bool isVisible = false;
  bool isEnabled = false;
  List<String> get genderItems => [
        AppLocalizations.of(context)!.male,
        AppLocalizations.of(context)!.female
      ];
  List<String> get activityLevelItems => [
        AppLocalizations.of(context)!.exercise_0,
        AppLocalizations.of(context)!.exercise_1_2,
        AppLocalizations.of(context)!.exercise_2_3,
        AppLocalizations.of(context)!.exercise_3_5,
        AppLocalizations.of(context)!.exercise_6_7,
        AppLocalizations.of(context)!.proessional_athelete,
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
                          Text(
                            AppLocalizations.of(context)!.calorie_calculator,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xffFFFDFD),
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                            ),
                          ),
                          sizedBoxHeight25,
                          TextFormField(
                            initialValue: bmrController.weight,
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
                                return AppLocalizations.of(context)!
                                    .weight_error;
                              }
                              if (double.parse(value!) <= 0) {
                                isVisible = false;
                                isEnabled = false;
                                return AppLocalizations.of(context)!
                                    .weight_greater_than_zero;
                              }
                              if (double.parse(value) > 450 ||
                                  double.parse(value) <= 2) {
                                isVisible = false;
                                isEnabled = false;
                                return AppLocalizations.of(context)!
                                    .weight_error_realistic;
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
                            decoration: InputDecoration(
                              suffix: Text(
                                AppLocalizations.of(context)!.kg,
                                style: const TextStyle(
                                  color: Color(0xff0A0909),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                    top: 11, left: 10, right: 10),
                                child: Text(
                                  AppLocalizations.of(context)!.weight_label,
                                  style: const TextStyle(
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
                            initialValue: bmrController.height,
                            textAlign: TextAlign.end,
                            validator: ((value) {
                              if (value?.isEmpty ?? true) {
                                isVisible = false;
                                isEnabled = false;
                                return AppLocalizations.of(context)!
                                    .height_empty_error;
                              }
                              if (double.parse(value!) <= 0) {
                                isVisible = false;
                                isEnabled = false;
                                return AppLocalizations.of(context)!
                                    .height_error_greater_than_zero;
                              }
                              if (double.parse(value) > 280 ||
                                  double.parse(value) < 60) {
                                isVisible = false;
                                isEnabled = false;
                                return AppLocalizations.of(context)!
                                    .height_error_realistic;
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
                            decoration: InputDecoration(
                              suffix: Text(
                                AppLocalizations.of(context)!.cm,
                                style: const TextStyle(
                                  color: Color(0xff0A0909),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                    top: 11, left: 10, right: 10),
                                child: Text(
                                  AppLocalizations.of(context)!.height_label,
                                  style: const TextStyle(
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
                              initialValue: bmrController.age,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r"[0-9]")),
                              ],
                              textAlign: TextAlign.end,
                              // initialValue: authController.age,
                              validator: ((value) {
                                if (value?.isEmpty ?? true) {
                                  isVisible = false;
                                  return AppLocalizations.of(context)!
                                      .age_empty_error;
                                } else if (int.parse(value!) < 18) {
                                  isVisible = false;
                                  isEnabled = false;
                                  return AppLocalizations.of(context)!
                                      .age_value_error;
                                } else if (int.parse(value) > 150) {
                                  isVisible = false;
                                  isEnabled = false;
                                  return AppLocalizations.of(context)!
                                      .age_realistic_error;
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
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 11, left: 10, right: 10),
                                  child: Text(
                                    AppLocalizations.of(context)!.age_label,
                                    style: const TextStyle(
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
                                  return AppLocalizations.of(context)!
                                      .gender_empty_error;
                                } else {
                                  return null;
                                }
                              }),
                              readOnly: true,
                              controller: bmrController.genderController,
                              cursorColor: Colors.black,
                              style: const TextStyle(
                                color: Color(0xff0A0909),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 11, left: 10, right: 10),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .gender_label,
                                      style: const TextStyle(
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
                                      bmrController.genderController.text =
                                          value;
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
                                return AppLocalizations.of(context)!
                                    .activity_error_empty;
                              } else {
                                return null;
                              }
                            }),
                            readOnly: true,
                            controller: bmrController.activityLevelController,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                              color: Color(0xff0A0909),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!
                                    .activity_label,
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
                                    bmrController.activityLevelController.text =
                                        value;
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
                              title: AppLocalizations.of(context)!.calculate,
                              enabled: isEnabled,
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    isVisible = true;
                                  });
                                }
                                bmrController.calculateBMR(context);
                              }),
                          sizedBoxHeight14,
                          Visibility(
                            visible: isVisible && !(bmrController.bmr > 0),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .unrealistic_values_error,
                              style: const TextStyle(
                                color: Color(0xffFFFDFD),
                                fontWeight: FontWeight.w600,
                                fontSize: 19,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: isVisible && (bmrController.bmr > 0),
                            child: SfCircularChart(
                              title: ChartTitle(
                                text: AppLocalizations.of(context)!
                                    .your_daily_calorie_intake,
                                textStyle: const TextStyle(
                                  color: Color(0xffFFFDFD),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 19,
                                ),
                              ),
                              legend: Legend(
                                // backgroundColor: Colors.blue.wit,
                                textStyle: const TextStyle(
                                  color: Color(0xffFFFDFD),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                                isVisible: true,
                                overflowMode: LegendItemOverflowMode.wrap,
                              ),
                              series: <CircularSeries>[
                                PieSeries<BMRData, String>(
                                  pointColorMapper: (BMRData data, index) =>
                                      data.color,
                                  dataSource: [
                                    BMRData(
                                      AppLocalizations.of(context)!.carbs,
                                      bmrController.carbs.toInt(),
                                      const Color(0xff74ADD1),
                                    ),
                                    BMRData(
                                      AppLocalizations.of(context)!.proteins,
                                      bmrController.proteins.toInt(),
                                      const Color(0xff4575B4),
                                    ),
                                    BMRData(
                                      AppLocalizations.of(context)!.fats,
                                      bmrController.fats.toInt(),
                                      const Color(0xff2D4D76),
                                    ),
                                  ],
                                  xValueMapper: (BMRData data, _) =>
                                      data.nutrient,
                                  yValueMapper: (BMRData data, _) =>
                                      data.nutrientValue,
                                ),
                              ],
                            ),
                          ),
                          sizedBoxHeight8,
                          Visibility(
                            visible: isVisible && (bmrController.bmr > 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${AppLocalizations.of(context)!.carbs_label} ${bmrController.carbs.round()} |",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xffFFFDFD),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  " ${AppLocalizations.of(context)!.fats_label} ${bmrController.fats.round()} |",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xffFFFDFD),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  " ${AppLocalizations.of(context)!.proteins_label} ${bmrController.proteins.round()}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xffFFFDFD),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: isVisible && (bmrController.bmr > 0),
                            child: Text(
                              "${bmrController.bmr.toStringAsFixed(0)} ${AppLocalizations.of(context)!.kcal_per_day}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xffFFFDFD),
                                fontWeight: FontWeight.w800,
                                fontSize: 28,
                              ),
                            ),
                          ),
                          sizedBoxHeight16,
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
