import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:health_studio_user/core/models/address.dart';
import 'package:health_studio_user/core/request.dart';
import 'package:health_studio_user/ui/widgets/loader.dart';

class AddressController extends GetxController {
  List<AddressListing> addresses = [];
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAddresses();
    });
  }

  void getAddresses() async {
    Utility.showLoadingDialog();
    Map<String, dynamic> response = await getRequest("address");
    Utility.closeDialog();

    if (response["error"] != 0) {
      Get.rawSnackbar(message: response["message"] ?? "");
    } else {
      addresses = response["details"] == null
          ? <AddressListing>[]
          : List<AddressListing>.from(response["details"]
              .map((e) => AddressListing.fromJson(e))
              .toList());
      update();
    }
  }

  void deleteAddress(String id) async {
    Utility.showLoadingDialog();
    Map<String, dynamic> body = {};
    Map<String, dynamic> response =
        await postRequest("address/delete/$id", body);
    Utility.closeDialog();
    if (response["error"] != 0) {
      Get.rawSnackbar(message: response["message"] ?? "");
    } else {
      addresses.removeWhere((item) => item.id.toString() == id.toString());
      Get.rawSnackbar(message: "Successfully address deleted");

      update();
    }
  }
}
