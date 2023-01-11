import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/address_controller.dart';
import 'package:health_studio_user/ui/widgets/bottom_navigation_bar.dart';
import 'package:health_studio_user/utils/buttons.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:sticky_headers/sticky_headers.dart';

class AddressForm extends StatefulWidget {
 const  AddressForm({Key? key}) : super(key: key);

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AddressController(),
        builder: (addressController) {
          return Scaffold(
            bottomNavigationBar: bottomNavigationBar(),
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedBoxHeight10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        sizedBoxHeight10,
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
                          child: Image.asset(
                              "assets/images/health_studio_logo.png"),
                        ),
                      ],
                    ),
                    Padding(
                      padding: edgeInsetsleft16,
                      child: Text(
                        'Add New Address',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 28.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                    sizedBoxHeight10,
                    Form(
                        child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: TextFormField(
                            onChanged: (value) {
                              addressController.name = value;
                            },
                            cursorColor: Colors.black,
                            style: Theme.of(context).textTheme.headline1,
                            decoration: InputDecoration(
                              contentPadding: edgeInsets16,
                              hintText: 'Enter your address name',
                            ),
                          ),
                        ),
                        sizedBoxHeight10,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: TextFormField(
                            onChanged: (value) {
                              addressController.block = value;
                            },
                            cursorColor: Colors.black,
                            style: Theme.of(context).textTheme.headline1,
                            decoration: InputDecoration(
                              contentPadding: edgeInsets16,
                              hintText: 'Enter your block number',
                            ),
                          ),
                        ),
                        sizedBoxHeight10,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: TextFormField(
                            onChanged: (value) {
                              addressController.street = value;
                            },
                            cursorColor: Colors.black,
                            style: Theme.of(context).textTheme.headline1,
                            decoration: InputDecoration(
                              contentPadding: edgeInsets16,
                              hintText: 'Enter your street number',
                            ),
                          ),
                        ),
                        sizedBoxHeight10,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: TextFormField(
                            onChanged: (value) {
                              addressController.housenumber = value;
                            },
                            cursorColor: Colors.black,
                            style: Theme.of(context).textTheme.headline1,
                            decoration: InputDecoration(
                              hintText: 'Enter your house / building number',
                              contentPadding: edgeInsets16,
                            ),
                          ),
                        ),
                        sizedBoxHeight10,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: TextFormField(
                            onChanged: (value) {
                              addressController.paci = value;
                            },
                            cursorColor: Colors.black,
                            style: Theme.of(context).textTheme.headline1,
                            decoration: InputDecoration(
                              hintText: 'Enter PACI number (Optional)',
                              contentPadding: edgeInsets16,
                            ),
                          ),
                        ),
                        sizedBoxHeight10,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: TextFormField(
                            onChanged: (value) {
                              addressController.floornumber = value;
                            },
                            cursorColor: Colors.black,
                            style: Theme.of(context).textTheme.headline1,
                            decoration: InputDecoration(
                              hintText: 'Enter floor number (Optional)',
                              contentPadding: edgeInsets16,
                            ),
                          ),
                        ),
                        sizedBoxHeight10,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: TextFormField(
                            onChanged: (value) {
                              addressController.avenue = value;
                            },
                            cursorColor: Colors.black,
                            style: Theme.of(context).textTheme.headline1,
                            decoration: InputDecoration(
                              contentPadding: edgeInsets16,
                              hintText: 'Enter avenue (Optional)',
                            ),
                          ),
                        ),
                        sizedBoxHeight10,
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: bottomwidget(context)),
                        sizedBoxHeight10,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: TextFormField(
                            onChanged: (value) {
                              addressController.detailaddress = value;
                            },
                            cursorColor: Colors.black,
                            maxLines: 5,
                            style: Theme.of(context).textTheme.headline1,
                            decoration: InputDecoration(
                              contentPadding: edgeInsets16,
                              hintText: 'Detail Address (Optional)',
                            ),
                          ),
                        ),
                        sizedBoxHeight10,
                        LoginButton(
                          height: 50.h,
                          onTap: () {
                            addressController.addAddress();
                            addressController.getAddresses();
                            addressController.initialvalue = "Area/city";
                          },
                          enabled: true,
                          title: 'Save',
                        ),
                        sizedBoxHeight35,
                      ],
                    ))
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget bottomwidget(context) {
    return GetBuilder<AddressController>(
        init: AddressController(),
        builder: (addressController) {
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
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
                            height: 20.h,
                            width: double.infinity,
                            color: Colors.white,
                            child: Padding(
                              padding: edgeInsetsleft16,
                              child: Text(
                                addressController.details[index].nameEn
                                    .toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          content: Container(
                            color: const Color(0xff2A7891),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: addressController
                                  .details[index].cities!.length,
                              itemBuilder:
                                  (BuildContext context, int contentindex) {
                                return GestureDetector(
                                  onTap: () {
                                    addressController.initialvalue =
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
                                    height: 40.h,
                                    color: const Color.fromARGB(
                                        150, 255, 255, 255),
                                    child: Padding(
                                      padding: edgeInsets16,
                                      child: Text(
                                        addressController.details[index]
                                            .cities![contentindex].nameEn
                                            .toString(),
                                        style:
                                            const TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
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
