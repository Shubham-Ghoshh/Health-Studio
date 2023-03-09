import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/utils/buttons.dart';
import 'package:health_studio_user/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../utils/colors.dart';

Future fridayAlertDialog() {
    return showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            icon: const Icon(
              Icons.error,
              color: loginButtonColor,
            ),
            title: Text(AppLocalizations.of(context)!.info),
            content: Text("On Friday, orders are not deliverable"),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              LoginButton(
                onTap: () {
                  Get.back();
                },
                enabled: true,
                title: AppLocalizations.of(context)!.okay,
                height: 50,
                width: 100,
              ),
            ],
          );
        });
  }