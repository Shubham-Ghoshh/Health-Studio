import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/ui/screens/address_form.dart';
import 'package:health_studio_user/ui/widgets/bottom_navigation_bar.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';

class Address extends StatefulWidget {
  const Address({Key? key}) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddressForm());
        },
        backgroundColor: whiteColor,
        child: const Icon(
          Icons.add,
          color: loginButtonColor,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizedBoxHeight10,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 270.w,
                  height: 75.h,
                  child: Image.asset("assets/images/health_studio_logo.png"),
                ),
              ],
            ),
            Padding(
              padding: edgeInsetsleft16,
              child: Text(
                'Address',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 28.sp, fontWeight: FontWeight.w600),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isVisible = !(isVisible);
                });
              },
              child: addressContainer(
                'Home',
              ),
            ),
            addressContainer('Office'),
          ],
        ),
      ),
    );
  }

  Widget addressContainer(String title) {
    return Column(
      children: [
        Padding(
          padding: edgeInsets16,
          child: Container(
            height: 146.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        title,
                        style: TextStyle(
                            color: loginButtonColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    isVisible
                        ? Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child:
                                SvgPicture.asset('assets/images/verified.svg'),
                          )
                        : Container()
                  ],
                ),
                Padding(
                  padding: edgeInsetsleft16,
                  child: Text(
                    'Street 12 , Building 110 , Floor 3,',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: pureblackColor),
                  ),
                ),
                Padding(
                  padding: edgeInsetsleft16,
                  child: Text('Apartment 110.',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: pureblackColor)),
                ),
                Padding(
                  padding: edgeInsets16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hawalli , Salmiya',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: pureblackColor),
                      ),
                      SvgPicture.asset('assets/images/deleteicon.svg')
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
