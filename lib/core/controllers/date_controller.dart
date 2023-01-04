import 'package:get/get.dart';
import 'package:flutter/material.dart';

class DateController extends GetxController {
  TextEditingController subsciptionStartDateController =
      TextEditingController();
  TextEditingController subsciptionEndDateController = TextEditingController();

  DateController() {
    subsciptionStartDateController.text = "";
    subsciptionEndDateController.text = "";
  }
}
