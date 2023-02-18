import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_studio_user/core/controllers/bmr_calculator_controller.dart';
import 'package:health_studio_user/ui/screens/bmr_calculator_screen.dart';
import 'package:health_studio_user/ui/widgets/app_bar.dart';
import 'package:health_studio_user/utils/buttons.dart';
import 'package:health_studio_user/utils/spacing.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BMRCalculationsPage extends StatefulWidget {
  const BMRCalculationsPage({super.key});

  @override
  State<BMRCalculationsPage> createState() => _BMRCalculationsPageState();
}

class _BMRCalculationsPageState extends State<BMRCalculationsPage> {
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
          SingleChildScrollView(
            child: SafeArea(
                child: GetBuilder<BMRController>(
              builder: (bmrController) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  sizedBoxHeight8,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizedBoxWidth12,
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      sizedBoxWidth25,
                      const Center(
                        child: SizedBox(
                          width: 235,
                          child: Center(
                            child: Text(
                              "Results",
                              style: TextStyle(
                                color: Color(0xffFFFDFD),
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins",
                                fontSize: 34,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  sizedBoxHeight10,
                  Visibility(
                    visible: !(bmrController.bmr > 0),
                    child: const Padding(
                      padding: EdgeInsets.only(
                          left: 30, right: 30, top: 200, bottom: 200),
                      child: Center(
                        child: Text(
                          "Unrealistic values provided.\nPlease check the values and try again.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xffFFFDFD),
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                            fontSize: 21,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: (bmrController.bmr > 0),
                    child: SfCircularChart(
                      title: ChartTitle(
                        text: "Your Daily Calorie Intake",
                        textStyle: const TextStyle(
                          color: Color(0xffFFFDFD),
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                          fontSize: 19,
                        ),
                      ),
                      legend: Legend(
                        // backgroundColor: Colors.blue.wit,
                        textStyle: const TextStyle(
                          color: Color(0xffFFFDFD),
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                          fontSize: 16,
                        ),
                        isVisible: true,
                        overflowMode: LegendItemOverflowMode.wrap,
                      ),
                      series: <CircularSeries>[
                        PieSeries<BMRData, String>(
                          pointColorMapper: (BMRData data, index) => data.color,
                          dataSource: [
                            BMRData(
                              "Carbs",
                              bmrController.carbs.toInt(),
                              const Color(0xff74ADD1),
                            ),
                            BMRData(
                              "Proteins",
                              bmrController.proteins.toInt(),
                              const Color(0xff4575B4),
                            ),
                            BMRData(
                              "Fats",
                              bmrController.fats.toInt(),
                              const Color(0xff2D4D76),
                            ),
                          ],
                          xValueMapper: (BMRData data, _) => data.nutrient,
                          yValueMapper: (BMRData data, _) => data.nutrientValue,
                        ),
                      ],
                    ),
                  ),
                  sizedBoxHeight8,
                  Visibility(
                    visible: (bmrController.bmr > 0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Carbs: ${(bmrController.carbs / 4).round()}g |",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xffFFFDFD),
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              " Fats: ${(bmrController.fats / 9).round()}g |",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xffFFFDFD),
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              " Proteins: ${(bmrController.proteins / 4).round()}g",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xffFFFDFD),
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: (bmrController.bmr > 0),
                    child: Text(
                      "${bmrController.bmr.toStringAsFixed(2)} kcal/day",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xffFFFDFD),
                        fontWeight: FontWeight.w800,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  sizedBoxHeight16,
                  Visibility(
                    visible: (bmrController.bmr > 0) && (bmrController.bmr > 0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(children: [
                          sizedBoxHeight10,
                          Text(
                            "BMI: ${bmrController.bmi.toStringAsFixed(2)}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xffFFFDFD),
                              fontWeight: FontWeight.w800,
                              fontSize: 28,
                            ),
                          ),
                          sizedBoxHeight16,
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  bmiStrip(
                                      "Underweight", Colors.blueAccent, "18.5"),
                                  bmiStrip("Normal", Colors.green, "25.0"),
                                  bmiStrip("Overweight", Colors.orangeAccent,
                                      "30.0"),
                                  bmiStrip("Obese", Colors.red, ""),
                                ],
                              ),
                              sizedBoxHeight14,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Text(
                                  bmrController.bmiMessage,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xffFFFDFD),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              sizedBoxHeight20,
                            ],
                          ),
                        ]),
                      ),
                    ),
                  ),
                  sizedBoxHeight40,
                  LoginButton(
                    onTap: () {
                      Get.to(() => const BMRCalculatorPage());
                    },
                    enabled: true,
                    title: "RE-CALCUALTE",
                    height: 52,
                  ),
                  sizedBoxHeight16,
                ],
              ),
            )),
          )
        ],
      ),
    );
  }

  Column bmiStrip(String bmiCategory, Color color, String bmiValue) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 62.0, bottom: 4),
          child: Text(
            bmiValue,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Color.fromARGB(186, 255, 253, 253),
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ),
        Container(
          width: 87.5,
          height: 8,
          color: color,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            bmiCategory,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color.fromARGB(186, 255, 253, 253),
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }
}
