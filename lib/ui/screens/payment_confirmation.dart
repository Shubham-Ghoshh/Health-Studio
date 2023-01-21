import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_studio_user/ui/widgets/app_bar.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';

class PaymentConfirmationPage extends StatefulWidget {
  const PaymentConfirmationPage({super.key});

  @override
  State<PaymentConfirmationPage> createState() =>
      _PaymentConfirmationPageState();
}

class _PaymentConfirmationPageState extends State<PaymentConfirmationPage> {
  Widget paymentSuccessful() {
    return Column(
      children: [
        Text(
          "CAPTURED",
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
            "Thank you! We have received your payment.",
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

  Widget paymentUnsuccessful() {
    return Column(
      children: [
        Text(
          "DECLINED",
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
            "Sorry! We could not recieve your payement.",
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  sizedBoxHeight6,
                  appBar(),
                  sizedBoxHeight20,
                  paymentSuccessful(),
                  sizedBoxHeight16,
                  PaymentFeatures("Subscription", "Lifestyle/ Weight Loss"),
                  PaymentFeatures("Subscription Start", "November 12, 2022"),
                  PaymentFeatures("End Date", "December 11, 2022"),
                  PaymentFeatures("Amount", "KWD 80.00"),
                  PaymentFeatures("Track ID", "20221010114410000"),
                  PaymentFeatures("Payment ID", "10020222830111726"),
                  PaymentFeatures("Transaction ID", "228310000091"),
                  sizedBoxHeight40,
                  GestureDetector(
                    onTap: () {},
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
                            "Done",
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
        ],
      ),
    );
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
