import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/ui/widgets/app_bar.dart';
import 'package:health_studio_user/ui/widgets/bottom_navigation_bar.dart';
import 'package:health_studio_user/utils/buttons.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                          hintText: AppLocalizations.of(context)!.address_name,
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
                          hintText: AppLocalizations.of(context)!.block_number,
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
                          hintText: AppLocalizations.of(context)!.street_number,
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
                          hintText: AppLocalizations.of(context)!.house_no,
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
                          hintText: AppLocalizations.of(context)!.paci_no,
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
                          hintText: AppLocalizations.of(context)!.floor_no,
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
                          hintText: AppLocalizations.of(context)!.avenue,
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
                          hintText: AppLocalizations.of(context)!.area_city,
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
                          hintText:
                              AppLocalizations.of(context)!.deatil_address,
                        ),
                      ),
                    ),
                    sizedBoxHeight10,
                    LoginButton(
                      height: 50.h,
                      onTap: () {},
                      enabled: true,
                      title: AppLocalizations.of(context)!.save,
                    ),
                    sizedBoxHeight35,
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
