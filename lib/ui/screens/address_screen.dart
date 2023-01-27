import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/address_controller.dart';
import 'package:health_studio_user/core/controllers/order_controller.dart';
import 'package:health_studio_user/core/models/address.dart';
import 'package:health_studio_user/ui/screens/address_form.dart';
import 'package:health_studio_user/ui/screens/confirmation_screen.dart';
import 'package:health_studio_user/ui/screens/temp.dart';
import 'package:health_studio_user/ui/widgets/app_bar.dart';
import 'package:health_studio_user/ui/widgets/bottom_navigation_bar.dart';
import 'package:health_studio_user/utils/buttons.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Address extends StatefulWidget {
  final bool check;
  const Address({Key? key, required this.check}) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  bool home = true;
  bool office = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressController>(
        init: AddressController(context),
        builder: (addressController) {
          return Scaffold(
            // bottomNavigationBar: bottomNavigationBar(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Get.to(() => AddressForm());
              },
              backgroundColor: whiteColor,
              child: const Icon(
                Icons.add,
                color: loginButtonColor,
              ),
            ),
            body: Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appBar(),
                      Padding(
                        padding: edgeInsetsleft16,
                        child: Text(
                          AppLocalizations.of(context)!.address,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 28.sp, fontWeight: FontWeight.w600),
                        ),
                      ),
                      ...addressController.addresses
                          .map((e) => addressContainer(
                                e,
                                home,
                                widget.check,
                              )),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget addressContainer(AddressListing a, bool isVisible, check) {
    return GetBuilder<AddressController>(
        init: AddressController(context),
        builder: (addressController) {
          return GestureDetector(
            onTap: () {
              if (check) {
                Get.find<OrderController>().order.addressId = a.id;
                Get.to(() => const ConfirmationPage());
              }
            },
            child: Column(
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
                                a.areaEn.toString(),
                                style: TextStyle(
                                    color: loginButtonColor,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            isVisible && check
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: SvgPicture.asset(
                                        'assets/images/verified.svg'),
                                  )
                                : Container()
                          ],
                        ),
                        Padding(
                          padding: edgeInsetsleft16,
                          child: Row(
                            children: [
                              Text(
                                '${a.street}, ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    color: pureblackColor),
                              ),
                              Text(
                                '${AppLocalizations.of(context)!.building} ${a.building}, ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    color: pureblackColor),
                              ),
                              Text(
                                '${AppLocalizations.of(context)!.floor} ${a.floor},',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    color: pureblackColor),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: edgeInsetsleft16,
                          child: Text(
                              '${AppLocalizations.of(context)!.apartment} ${a.apartementNumber}.',
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
                              Row(
                                children: [
                                  Text(
                                    '${a.cityEn} , ',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: pureblackColor),
                                  ),
                                  Text(
                                    '${a.governorateEn}  ',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: pureblackColor),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                  onTap: () {
                                    addressController
                                        .deleteAddress(a.id.toString());
                                    addressController.getAddresses();
                                  },
                                  child: SvgPicture.asset(
                                      'assets/images/deleteicon.svg'))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
