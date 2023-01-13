import 'package:flutter/material.dart';
import 'package:health_studio_user/ui/widgets/app_bar.dart';

class TermsandConditions extends StatelessWidget {
  const TermsandConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  
                ])))));
  }
}
