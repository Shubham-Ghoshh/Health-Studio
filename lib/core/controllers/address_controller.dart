import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/models/address.dart';
import 'package:health_studio_user/core/request.dart';
import 'package:health_studio_user/ui/widgets/loader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddressController extends GetxController {
  final BuildContext context;
  AddressController(this.context);
  List<AddressListing> addresses = [];
  List<Details> details = [];
  String? name;
  String? block;
  String? street;
  String? detailaddress;
  String? paci;
  String? city;
  String? avenue;
  String? floornumber;
  String? housenumber;
  String get initialvalue => AppLocalizations.of(context)!.area_city;
  set setInitailValue(String value) {
    setInitailValue = value;
  }

  GlobalKey<FormState> addressKey = GlobalKey<FormState>();
  bool isValid = false;

  // static BuildContext get context => context;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAddresses();
      getcities();
    });
  }

  void addAddress() async {
    Utility.showLoadingDialog();
    Map<String, dynamic> body = {
      "name": name,
      "street": street,
      "building": housenumber,
      "floor": floornumber,
      "house": housenumber,
      "avenue": avenue,
      "block": block,
      "detail": detailaddress,
      "city": city,
      "paci": paci,
    };
    Map<String, dynamic> response = await postRequest("address", body);
    Utility.closeDialog();
    if (response["error"] != 0 ||
        response["details"] == null ||
        (response["details"]?.isEmpty ?? true)) {
      Get.rawSnackbar(message: response["message"] ?? "");
    } else {
      getAddresses(back: true);
      update();
    }
  }

  void getAddresses({bool back = false}) async {
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

    if (back) {
      Get.back();
      Get.rawSnackbar(message: AppLocalizations.of(context)!.added_address);
    }
  }

  void getcities() async {
    Utility.showLoadingDialog();
    Map<String, dynamic> response = await getRequest("cities");
    Utility.closeDialog();
    if (response["error"] != 0) {
      Get.rawSnackbar(message: response["message"] ?? "");
    } else {
      details = response["details"] == null
          ? <Details>[]
          : List<Details>.from(
              response["details"].map((e) => Details.fromJson(e)).toList());

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
      Get.rawSnackbar(message: AppLocalizations.of(context)!.deleted_address);

      update();
    }
  }
}
