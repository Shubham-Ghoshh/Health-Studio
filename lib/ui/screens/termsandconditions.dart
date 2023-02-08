import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/ui/screens/address_screen.dart';
import 'package:health_studio_user/utils/buttons.dart';
import 'package:health_studio_user/utils/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:health_studio_user/utils/spacing.dart';

class TermsandConditions extends StatelessWidget {
  final bool showAddress;

  const TermsandConditions({Key? key, this.showAddress = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.white,
            ),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: plantextColor,
          title: Text(
            AppLocalizations.of(context)!.terms_conditions,
            style: TextStyle(
                fontSize: 20.sp,
                color: whiteColor,
                fontWeight: FontWeight.bold),
          )),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: const [
                      Text(
                          'ملاحظه" مهمه يتم ابتداء وتفعيل الاشتراك من بعد الدفع من يومين الى ٣ أيام عمل"او يتم تحديد التاريخ المناسب في الابليكيشن\nعمل"او يتم تحديد التاريخ المناسب في الابليكيشن\nوفي حالة الاشتراك بالعرض لا يحق للمشترك استرداد المبلغ فقط في اشتراكات العرض'),
                      Text(
                          '١- في حاله الالغاء في الأسبوع الاول من تاريخ بدء الاشتراك يتم خصم أسبوع كامل من قيمة الاشتراك مع ٢٥دينار كويتي رسوم الغاء'),
                      Text(
                          '٢- في حاله مرور ١٤ يوم من بدء الاشتراك لايحق للعميل الألغاء ولا استرداد قيمة الأشتراك الأشتراك'),
                      Text(
                          '٣- يحق للعميل وقف الأشتراك عند الضروره مره واحده في الشهر لمده أسبوع متواصل والرجوع الي الإداره للموافقه علي وقف الاشتراك .'),
                      Text(
                          '٤- اللحم يكون ٣ ايام بالاسبوع فقط والسمك ٣ ايام بالاسبوع فقط والربيان مره واحده بالاسبوع'),
                      Text(
                          '١٣-اي تغيير على نظام الجدول الغذائي من يومين إلى\n٣ أيام\nقد تحتوي بعض الوجبات على مسببات الحساسية. ينصح العملاء بشدة باختيار\nوجباتهم وفقًا لمتطلباتهم'),
                      Text(
                          'التوصيل كل يوم من الساعه ٨ صباحا حتى الساعه ٣ مساءا ويكون البوكس لليوم اللي بعده ( لا يوجد تحديد وقت لفترة التوصيل ) ويكون كل يوم جمعه يوم راحة')
                    ],
                  ),
                ),
                const Divider(
                  // height: 2,
                  thickness: 2,
                  color: Colors.grey,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      '1.  An important “note” that the subscription will start and be activated 3 working days after payment “or the appropriate date is specified in the application.\n2.  In subscribing to a promotion or offer, the subscriber who wishes to cancel his or her subscription will not entitled to a refund. Cancellations refunds made under the following instances will be  computed as follows:\na- In the event of cancellation in the first week of the subscription start date, a full week will be deducted from the subscription value plus 25 Kuwaiti dinars cancellation fees\nb- In the event that 14 days have passed since the start of the subscription, the customer is not entitled to cancel or refund the subscription value\nc- The customer has the right to stop the subscription when necessary once a month for a continuous week and refer to the administration for approval to stop the subscription.\n3.  Meat and Fish are served alternately for 3 days a week, and shrimp is served once a week\n4.  Any change to the diet schedule from will be effected after 3 days.\n5.  Some meals may contain allergens. Customers are strongly advised to choose their meals according to their requirements.\n6.  Subscription meals are delivered everyday between 8:00AM until 3:00PM at no exact time.  Meals delivered on the day are intended for next day consumption. There is no delivery schedule every Friday.\n'),
                ),
                showAddress
                    ? Column(
                        children: [
                          sizedBoxHeight12,
                          LoginButton(
                            enabled: true,
                            height: 50,
                            onTap: () {
                              Get.to(() => const Address(
                                    check: true,
                                  ));
                            },
                            title: AppLocalizations.of(context)!.accept,
                          ),
                          sizedBoxHeight16,
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
