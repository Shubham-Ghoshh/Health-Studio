import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/address_controller.dart';
import 'package:health_studio_user/ui/widgets/bottom_navigation_bar.dart';
import 'package:health_studio_user/utils/buttons.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:health_studio_user/ui/widgets/app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddressForm extends StatefulWidget {
  const AddressForm({Key? key}) : super(key: key);

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AddressController(context),
        builder: (addressController) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            // bottomNavigationBar: bottomNavigationBar(),
            body: Container(
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
                          AppLocalizations.of(context)!.add_address,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 28.sp, fontWeight: FontWeight.w600),
                        ),
                      ),
                      sizedBoxHeight10,
                      Form(
                        onChanged: () {
                          if (addressController.addressKey.currentState
                                  ?.validate() ??
                              false) {
                            if (addressController.city != null) {
                              addressController.isValid = true;
                              addressController.update();
                            }
                          } else {
                            addressController.isValid = false;
                            addressController.update();
                          }
                        },
                        key: addressController.addressKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              child: TextFormField(
                                onChanged: (value) {
                                  addressController.name = value;
                                },
                                cursorColor: Colors.black,
                                style: Theme.of(context).textTheme.headline1,
                                decoration: InputDecoration(
                                  contentPadding: edgeInsets16,
                                  hintText: AppLocalizations.of(context)!
                                      .address_name,
                                ),
                                validator: (value) =>
                                    (value == null || value.isEmpty)
                                        ? AppLocalizations.of(context)!
                                            .name_required
                                        : null,
                              ),
                            ),
                            sizedBoxHeight10,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              child: TextFormField(
                                validator: (value) =>
                                    (value == null || value.isEmpty)
                                        ? AppLocalizations.of(context)!
                                            .block_required
                                        : null,
                                onChanged: (value) {
                                  addressController.block = value;
                                },
                                cursorColor: Colors.black,
                                style: Theme.of(context).textTheme.headline1,
                                decoration: InputDecoration(
                                  contentPadding: edgeInsets16,
                                  hintText: AppLocalizations.of(context)!
                                      .block_number,
                                ),
                              ),
                            ),
                            sizedBoxHeight10,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              child: TextFormField(
                                validator: (value) =>
                                    (value == null || value.isEmpty)
                                        ? AppLocalizations.of(context)!
                                            .street_required
                                        : null,
                                onChanged: (value) {
                                  addressController.street = value;
                                },
                                cursorColor: Colors.black,
                                style: Theme.of(context).textTheme.headline1,
                                decoration: InputDecoration(
                                  contentPadding: edgeInsets16,
                                  hintText: AppLocalizations.of(context)!
                                      .street_number,
                                ),
                              ),
                            ),
                            sizedBoxHeight10,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              child: TextFormField(
                                validator: (value) =>
                                    (value == null || value.isEmpty)
                                        ? AppLocalizations.of(context)!
                                            .house_required
                                        : null,
                                onChanged: (value) {
                                  addressController.housenumber = value;
                                },
                                cursorColor: Colors.black,
                                style: Theme.of(context).textTheme.headline1,
                                decoration: InputDecoration(
                                  hintText:
                                      AppLocalizations.of(context)!.house_no,
                                  contentPadding: edgeInsets16,
                                ),
                              ),
                            ),
                            sizedBoxHeight10,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              child: TextFormField(
                                onChanged: (value) {
                                  addressController.paci = value;
                                },
                                cursorColor: Colors.black,
                                style: Theme.of(context).textTheme.headline1,
                                decoration: InputDecoration(
                                  hintText:
                                      AppLocalizations.of(context)!.paci_no,
                                  contentPadding: edgeInsets16,
                                ),
                              ),
                            ),
                            sizedBoxHeight10,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              child: TextFormField(
                                onChanged: (value) {
                                  addressController.floornumber = value;
                                },
                                cursorColor: Colors.black,
                                style: Theme.of(context).textTheme.headline1,
                                decoration: InputDecoration(
                                  hintText:
                                      AppLocalizations.of(context)!.floor_no,
                                  contentPadding: edgeInsets16,
                                ),
                              ),
                            ),
                            sizedBoxHeight10,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              child: TextFormField(
                                onChanged: (value) {
                                  addressController.avenue = value;
                                },
                                cursorColor: Colors.black,
                                style: Theme.of(context).textTheme.headline1,
                                decoration: InputDecoration(
                                  contentPadding: edgeInsets16,
                                  hintText:
                                      AppLocalizations.of(context)!.avenue,
                                ),
                              ),
                            ),
                            sizedBoxHeight10,
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                child: bottomwidget(context)),
                            sizedBoxHeight10,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              child: TextFormField(
                                textInputAction: TextInputAction.done,
                                validator: (value) =>
                                    (value == null || value.isEmpty)
                                        ? AppLocalizations.of(context)!
                                            .address_required
                                        : null,
                                onChanged: (value) {
                                  addressController.detailaddress = value;
                                },
                                cursorColor: Colors.black,
                                maxLines: 5,
                                style: Theme.of(context).textTheme.headline1,
                                decoration: InputDecoration(
                                  contentPadding: edgeInsets16,
                                  hintText: AppLocalizations.of(context)!
                                      .deatil_address,
                                ),
                              ),
                            ),
                            sizedBoxHeight12,
                            LoginButton(
                              height: 50.h,
                              onTap: () {
                                addressController.addAddress();
                                addressController.setInitailValue =
                                    AppLocalizations.of(context)!.area_city;
                              },
                              enabled: addressController.city != null &&
                                  (addressController.addressKey.currentState
                                          ?.validate() ??
                                      false),
                              title: AppLocalizations.of(context)!.save,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget bottomwidget(context) {
    return GetBuilder<AddressController>(
        init: AddressController(context),
        builder: (addressController) {
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  // backgroundColor: Color(0xFF2A7891),
                  context: context,
                  builder: (context) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: addressController.details.length,
                      itemBuilder: (BuildContext context, int index) {
                        return StickyHeader(
                          header: Container(
                            padding: edgeInsets8,
                            width: double.infinity,
                            color: plantextColor,
                            child: Text(
                              addressController.details[index].nameEn
                                  .toString(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          content: ListView.separated(
                            separatorBuilder: (context, index) => Divider(),
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount:
                                addressController.details[index].cities!.length,
                            itemBuilder:
                                (BuildContext context, int contentindex) {
                              return GestureDetector(
                                onTap: () {
                                  addressController.setInitailValue =
                                      addressController.details[index]
                                          .cities![contentindex].nameEn
                                          .toString();
                                  addressController.city = addressController
                                      .details[index].cities![contentindex].id
                                      .toString();
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: edgeInsets8,
                                  // height: 40.h,
                                  color:
                                      const Color.fromARGB(150, 255, 255, 255),
                                  child: Text(
                                    addressController.details[index]
                                        .cities![contentindex].nameEn
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          color: textfieldcolor,
                                        ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  });
            },
            child: Container(
                height: 45.h,
                width: double.infinity,
                color: const Color.fromARGB(150, 255, 255, 255),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        addressController.initialvalue,
                        style: const TextStyle(
                          color: Color.fromARGB(183, 10, 9, 9),
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Icon(
                          Icons.arrow_downward,
                          color: Color.fromARGB(183, 10, 9, 9),
                        ),
                      ),
                    ],
                  ),
                )),
          );
        });
  }
}
