import 'package:get/get.dart';
import 'package:flutter/material.dart';

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
}

class BMRData {
  BMRData(this.nutrient, this.nutrientValue, this.color);
  String nutrient;
  int nutrientValue;
  Color color;
}
