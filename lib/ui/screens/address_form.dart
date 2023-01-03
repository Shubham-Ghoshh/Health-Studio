import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/ui/widgets/bottom_navigation_bar.dart';
import 'package:health_studio_user/utils/buttons.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:health_studio_user/utils/spacing.dart';

class AddressForm extends StatelessWidget {
  const AddressForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    child: Image.asset("assets/images/health_studio_logo.png"),
                  ),
                ],
              ),
              Padding(
                padding: edgeInsetsleft16,
                child: Text(
                  'Add New Address',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 28.sp, fontWeight: FontWeight.w600),
                ),
              ),
              sizedBoxHeight10,
              Form(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: TextFormField(
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
                    child: TextFormField(
                      cursorColor: Colors.black,
                      style: Theme.of(context).textTheme.headline1,
                      decoration: InputDecoration(
                        // suffixIcon: Container(
                        //   color: Colors.red,
                        //   height: 15.h,
                        //   width: 15.w,
                        //   child: SvgPicture.asset(
                        //     'assets/images/downwardicon.svg',
                        //   ),
                        // ),
                        contentPadding: edgeInsets16,
                        hintText: 'Area/City',
                      ),
                    ),
                  ),
                  sizedBoxHeight10,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: TextFormField(
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
                    onTap: () {},
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
  }
}
