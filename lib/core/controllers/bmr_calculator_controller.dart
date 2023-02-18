import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:health_studio_user/core/controllers/setting_controller.dart';
import 'package:health_studio_user/core/request.dart';
import 'package:health_studio_user/ui/screens/bmr_calculations_screen.dart';

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
  final TextEditingController weightPlanController = TextEditingController();

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

    if (activityLevelController.text ==
        AppLocalizations.of(context)!.exercise_0) {
      bmr *= 1.2;
    } else if (activityLevelController.text ==
        AppLocalizations.of(context)!.exercise_1_2) {
      bmr *= 1.4;
    } else if (activityLevelController.text ==
        AppLocalizations.of(context)!.exercise_2_3) {
      bmr *= 1.6;
    } else if (activityLevelController.text ==
        AppLocalizations.of(context)!.exercise_3_5) {
      bmr *= 1.75;
    } else if (activityLevelController.text ==
        AppLocalizations.of(context)!.exercise_6_7) {
      bmr *= 2;
    } else {
      bmr *= 2.3;
    }
    update();
    bmi =
        (double.parse(weight) / (double.parse(height) * double.parse(height))) *
            10000;
    update();
    if (bmi < 18.5) {
      bmiMessage =
          "${AppLocalizations.of(context)!.bmi_lower}\n${AppLocalizations.of(context)!.visit_doctor}";
    }
    if (bmi > 18.5 && bmi < 25) {
      bmiMessage = AppLocalizations.of(context)!.bmi_normal;
    }
    if (bmi > 25) {
      bmiMessage =
          "${AppLocalizations.of(context)!.bmi_greater}\n${AppLocalizations.of(context)!.visit_doctor}";
    }
    update();
    if (weightPlanController.text ==
        AppLocalizations.of(context)!.weight_gain) {
      bmr += 300;
      carbs = (bmr * 0.45).roundToDouble();
      proteins = (bmr * 0.45).roundToDouble();
      fats = (bmr * 0.10).roundToDouble();
    }
    if (weightPlanController.text ==
        AppLocalizations.of(context)!.maintain_weight) {
      carbs = (bmr * 0.50).roundToDouble();
      proteins = (bmr * 0.30).roundToDouble();
      fats = (bmr * 0.20).roundToDouble();
    }
    if (weightPlanController.text ==
        AppLocalizations.of(context)!.weight_loss) {
      bmr -= 300;
      carbs = (bmr * 0.50).roundToDouble();
      proteins = (bmr * 0.35).roundToDouble();
      fats = (bmr * 0.15).roundToDouble();
    }
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
