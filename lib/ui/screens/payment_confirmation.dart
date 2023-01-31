import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:health_studio_user/core/controllers/language_controller.dart';
import 'package:health_studio_user/core/controllers/order_controller.dart';
import 'package:health_studio_user/core/controllers/setting_controller.dart';
import 'package:health_studio_user/ui/screens/home_screen.dart';
import 'package:health_studio_user/ui/widgets/app_bar.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentConfirmationPage extends StatelessWidget {
  final String status;

  const PaymentConfirmationPage({required this.status});

  Widget paymentSuccessful(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      return Column(
        children: [
          Text(
            status.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: loginButtonColor,
              fontWeight: FontWeight.w600,
              fontSize: 24.sp,
            ),
          ),
          sizedBoxHeight6,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              AppLocalizations.of(context)!.payment_received,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: whiteColor,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget paymentUnsuccessful(BuildContext context) {
    return Column(
      children: [
        Text(
          status.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: activeIconColor,
            fontWeight: FontWeight.w600,
            fontSize: 24.sp,
          ),
        ),
        sizedBoxHeight6,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            AppLocalizations.of(context)!.payment_not_received,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
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
            SafeArea(
              child: GetBuilder<LanguageTogglerController>(
                builder: (languageController) => SingleChildScrollView(
                  child: Column(
                    children: [
                      sizedBoxHeight6,
                      appBar(canGoBack: false),
                      sizedBoxHeight20,
                      status == AppLocalizations.of(context)!.captured ||
                              status == AppLocalizations.of(context)!.paid
                          ? paymentSuccessful(context)
                          : paymentUnsuccessful(context),
                      sizedBoxHeight16,
                      PaymentFeatures(
                        (AppLocalizations.of(context)!.subscription),
                        languageController.isEnglish
                            ? orderController.orderDetails!.categoryEn
                            : orderController.orderDetails!.categoryAr,
                      ),
                      PaymentFeatures(
                          AppLocalizations.of(context)!.subscription_start,
                          orderController.order.startDate!),
                      // PaymentFeatures("End Date", orderController.order.endDate!),
                      PaymentFeatures(AppLocalizations.of(context)!.amount,
                          "KD ${orderController.order.amount!}"),
                      PaymentFeatures(
                        AppLocalizations.of(context)!.package,
                        orderController.orderDetails!.packageEn == ""
                            ? AppLocalizations.of(context)!.custom_package
                            : (languageController.isEnglish
                                ? orderController.orderDetails!.packageEn
                                : orderController.orderDetails!.packageAr),
                      ),
                      PaymentFeatures(
                          AppLocalizations.of(context)!.order_reference_ID,
                          orderController.orderDetails!.orderReference),
                      sizedBoxHeight40,
                      GestureDetector(
                        onTap: () {
                          Get.offAll(() => const HomePage());
                          Get.find<SettingsController>().getUserDetails();
                          Get.find<SettingsController>().getUserSubscription();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16, top: 8, bottom: 25),
                          child: Container(
                            width: 380.w,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xffFAAF4A),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.done,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Column PaymentFeatures(String featureHeading, String featureName) {
    return Column(
      children: [
        sizedBoxHeight16,
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Text(
            featureHeading,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.w400,
              fontSize: 13.sp,
            ),
          ),
        ),
        Text(
          featureName,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: whiteColor,
            fontWeight: FontWeight.w600,
            fontSize: 16.5.sp,
          ),
        ),
      ],
    );
  }
}
