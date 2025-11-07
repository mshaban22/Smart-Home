

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
class HomeUI extends StatefulWidget {
  final double temperature;
  final double humidity;
  final double gasLevel;
  final String quality;
  final String smquality;
  final double smokeLevel;
  const HomeUI({Key? key, required this.temperature, required this.humidity, required this.gasLevel, required this.quality, required this.smquality, required this.smokeLevel}) : super(key: key);
  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.only(
                left: 14,
                right: 14,
                top: 185, 
                bottom:185
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.black)),
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(children: [const SizedBox(
                      width: 20,
                    ),SleekCircularSlider(
                      appearance: CircularSliderAppearance(
                          customWidths: CustomSliderWidths(
                              trackWidth: 4,
                              progressBarWidth: 20,
                              shadowWidth: 40),
                          customColors: CustomSliderColors(
                              trackColor: HexColor('#ef6c00'),
                              progressBarColor: HexColor('#ffb74d'),
                              shadowColor: HexColor('#ffb74d'),
                              shadowMaxOpacity: 0.5, //);
                              shadowStep: 20),
                          infoProperties: InfoProperties(
                              bottomLabelStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                              bottomLabelText: 'Temp.',
                              mainLabelStyle: TextStyle(
                                  color: HexColor('#54826D'),
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600),
                              modifier: (double value) {
                                return '${widget.temperature.to} ˚C';
                              }),
                          startAngle: 90,
                          angleRange: 360,
                          size: 150,
                          animationEnabled: true),
                      min: 0,
                      max: 100,
                      initialValue: widget.temperature,
                    ),const SizedBox(
                  width: 25,
                    ),SleekCircularSlider(
                      appearance: CircularSliderAppearance(
                          customWidths: CustomSliderWidths(
                              trackWidth: 4,
                              progressBarWidth: 20,
                              shadowWidth: 40),
                          customColors: CustomSliderColors(
                              trackColor: Colors.redAccent,
                              progressBarColor: HexColor('#4FC3F7'),
                              shadowColor: HexColor('#B2EBF2'),
                              shadowMaxOpacity: 0.5, //);
                              shadowStep: 20),
                          infoProperties: InfoProperties(
                              bottomLabelStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                              bottomLabelText: 'Humidity.',
                              mainLabelStyle: TextStyle(
                                  color: HexColor('#54826D'),
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w600),
                              modifier: (double value) {
                                return '${widget.humidity} %';
                              }),
                          startAngle: 90,
                          angleRange: 360,
                          size: 150.0,
                          animationEnabled: true),
                      min: 0,
                      max: 100,
                      initialValue: widget.humidity,
                    ),],),
                    
                    const SizedBox(
                      height: 80,
                    ),
                    Row(children: [const SizedBox(
                      width: 20,
                    ),SleekCircularSlider(
                      appearance: CircularSliderAppearance(
                          customWidths: CustomSliderWidths(
                              trackWidth: 4,
                              progressBarWidth: 20,
                              shadowWidth: 40),
                          customColors: CustomSliderColors(
                              trackColor: HexColor('#ef6c00'),
                              progressBarColor: HexColor('#ffb74d'),
                              shadowColor: HexColor('#ffb74d'),
                              shadowMaxOpacity: 0.5, //);
                              shadowStep: 20),
                          infoProperties: InfoProperties(
                              bottomLabelStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                              bottomLabelText: 'Smoke',
                              mainLabelStyle: TextStyle(
                                  color: HexColor('#54826D'),
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600),
                              modifier: (double value) {
                                return '${widget.smquality}';
                              }),
                          startAngle: 90,
                          angleRange: 360,
                          size: 150,
                          animationEnabled: true),
                      min: 0,
                      max: 100,
                      initialValue: widget.smokeLevel,
                    ),const SizedBox(
                  width: 25,
                    ),SleekCircularSlider(
                      appearance: CircularSliderAppearance(
                          customWidths: CustomSliderWidths(
                              trackWidth: 4,
                              progressBarWidth: 20,
                              shadowWidth: 40),
                          customColors: CustomSliderColors(
                              trackColor: Colors.redAccent,
                              progressBarColor: HexColor('#4FC3F7'),
                              shadowColor: HexColor('#B2EBF2'),
                              shadowMaxOpacity: 0.5, //);
                              shadowStep: 20),
                          infoProperties: InfoProperties(
                              bottomLabelStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                              bottomLabelText: 'Air Quality.',
                              mainLabelStyle: TextStyle(
                                  color: HexColor('#54826D'),
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w600),
                              modifier: (double value) {
                                return '${widget.quality}';
                              }),
                          startAngle: 90,
                          angleRange: 360,
                          size: 150.0,
                          animationEnabled: true),
                      min: 0,
                      max: 100,
                      initialValue: widget.gasLevel,
                    ),],),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
                      height: 30,
                    ),
         
        
      
          ])));
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
