import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:health_studio_user/core/controllers/setting_controller.dart';
import 'package:health_studio_user/core/request.dart';

class BMRController extends GetxController {
  String height = "";
  String age = "";
  String weight = "";
  double bmr = 0;
  double carbs = 0;
  double proteins = 0;
  double fats = 0;
  double bmi = 0;
  String bmiMessage = "";
  final TextEditingController genderController = TextEditingController();
  final TextEditingController activityLevelController = TextEditingController();

  calculateBMR(BuildContext context) async {
    if (genderController.text == AppLocalizations.of(context)!.male) {
      bmr = (10 * double.parse(weight)) +
          (6.25 * double.parse(height)) -
          (5 * double.parse(age)) +
          5;

      update();
    } else {
      bmr = (10 * double.parse(weight)) +
          (6.25 * double.parse(height)) -
          (5 * double.parse(age)) -
          161;

      update();
    }

    if (activityLevelController.text == "Little/No Exercise") {
      bmr *= 1.2;
    } else if (activityLevelController.text == "Exercise 1-2 times/week") {
      bmr *= 1.4;
    } else if (activityLevelController.text == "Exercise 2-3 times/week") {
      bmr *= 1.6;
    } else if (activityLevelController.text == "Exercise 3-5 times/week") {
      bmr *= 1.75;
    } else if (activityLevelController.text == "Exercise 6-7 times/week") {
      bmr *= 2;
    } else {
      bmr *= 2.3;
    }
    // bmrController.bmi = (double.parse(
    //                                           bmrController.weight) /
    //                                       (double.parse(bmrController.height) *
    //                                           double.parse(
    //                                               bmrController.height))) *
    //                                   10000;
    //                               bmrController.update();
    //                               if (bmrController.bmi < 18.5) {
    //                                 bmrController.bmiMessage =
    //                                     "Your BMI is lower than normal.\nPlease visit your doctor.";
    //                               }
    //                               if (bmrController.bmi > 18.5 &&
    //                                   bmrController.bmi < 25) {
    //                                 bmrController.bmiMessage =
    //                                     "Great, you have a normal BMI.";
    //                               }
    //                               if (bmrController.bmi > 25) {
    //                                 bmrController.bmiMessage =
    //                                     "Your BMI is greater than normal.\nPlease visit your doctor.";
    //                               }

    //                               if (_genderController.text ==
    //                                   AppLocalizations.of(context)!.male) {
    //                                 bmrController.bmr = (10 *
    //                                         double.parse(
    //                                             bmrController.weight)) +
    //                                     (6.25 *
    //                                         double.parse(
    //                                             bmrController.height)) -
    //                                     (5 * double.parse(bmrController.age)) +
    //                                     5;

    //                                 bmrController.update();
    //                               } else {
    //                                 bmrController.bmr = (10 *
    //                                         double.parse(
    //                                             bmrController.weight)) +
    //                                     (6.25 *
    //                                         double.parse(
    //                                             bmrController.height)) -
    //                                     (5 * double.parse(bmrController.age)) -
    //                                     161;

    //                                 bmrController.update();
    //                               }

    //                               if (_activityLevelController.text ==
    //                                   "Little/No Exercise") {
    //                                 bmrController.bmr *= 1.2;
    //                               } else if (_activityLevelController.text ==
    //                                   "Exercise 1-2 times/week") {
    //                                 bmrController.bmr *= 1.4;
    //                               } else if (_activityLevelController.text ==
    //                                   "Exercise 2-3 times/week") {
    //                                 bmrController.bmr *= 1.6;
    //                               } else if (_activityLevelController.text ==
    //                                   "Exercise 3-5 times/week") {
    //                                 bmrController.bmr *= 1.75;
    //                               } else if (_activityLevelController.text ==
    //                                   "Exercise 6-7 times/week") {
    //                                 bmrController.bmr *= 2;
    //                               } else {
    //                                 bmrController.bmr *= 2.3;
    //                               }
    //                               bmrController.update();

    //                               if (_weightPlanController.text ==
    //                                   "Weight Gain") {
    //                                 bmrController.bmr += 300;
    //                                 bmrController.carbs =
    //                                     (bmrController.bmr * 0.45)
    //                                         .roundToDouble();
    //                                 bmrController.proteins =
    //                                     (bmrController.bmr * 0.45)
    //                                         .roundToDouble();
    //                                 bmrController.fats =
    //                                     (bmrController.bmr * 0.10)
    //                                         .roundToDouble();
    //                               }
    //                               if (_weightPlanController.text ==
    //                                   "Maintain Weight") {
    //                                 bmrController.carbs =
    //                                     (bmrController.bmr * 0.50)
    //                                         .roundToDouble();
    //                                 bmrController.proteins =
    //                                     (bmrController.bmr * 0.30)
    //                                         .roundToDouble();
    //                                 bmrController.fats =
    //                                     (bmrController.bmr * 0.20)
    //                                         .roundToDouble();
    //                               }
    //                               if (_weightPlanController.text ==
    //                                   "Weight Loss") {
    //                                 bmrController.bmr -= 300;
    //                                 bmrController.carbs =
    //                                     (bmrController.bmr * 0.50)
    //                                         .roundToDouble();
    //                                 bmrController.proteins =
    //                                     (bmrController.bmr * 0.35)
    //                                         .roundToDouble();
    //                                 bmrController.fats =
    //                                     (bmrController.bmr * 0.15)
    //                                         .roundToDouble();
    //                               }
    //                               bmrController.update();
    //                               Get.to(() => const BMRCalculationsPage());
    update();

    carbs = (bmr * 0.60).roundToDouble();
    fats = (bmr * 0.275).roundToDouble();
    proteins = (bmr * 0.125).roundToDouble();
    update();

    Map<String, dynamic> body = {
      "height": height,
      "weight": weight,
      "activity_level": activityLevelController.text,
      "carbs": carbs,
      "fats": fats,
      "proteins": proteins,
      "total_calories": bmr.toStringAsFixed(0)
    };

    Map<String, dynamic> response = await postRequest("user/bmi", body);
    if (response["error"] != 0) {
      Get.rawSnackbar(message: response["message"]);
    } else {
      Get.find<SettingsController>().getUserDetails();
    }
  }
}

class BMRData {
  BMRData(this.nutrient, this.nutrientValue, this.color);
  String nutrient;
  int nutrientValue;
  Color color;
}
