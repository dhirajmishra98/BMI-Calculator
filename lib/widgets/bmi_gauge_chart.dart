import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BMIGaugeChart extends StatelessWidget {
  final String nutritionalStatus;
  final double bmiValue;

  const BMIGaugeChart(
      {Key? key, required this.bmiValue, required this.nutritionalStatus})
      : super(key: key);

  Color getColor(double bmi) {
    if (bmi < 16.5) {
      return Colors.red; // Severely underweight
    } else if (bmi >= 16.5 && bmi < 18.5) {
      return Colors.orange; // Underweight
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return Colors.green; // Normal weight
    } else if (bmi >= 25.0 && bmi <= 29.9) {
      return Colors.yellow; // Overweight
    } else if (bmi >= 30.0 && bmi <= 34.9) {
      return Colors.orange; // Obesity class I
    } else if (bmi >= 35.0 && bmi <= 39.9) {
      return Colors.red; // Obesity class II
    } else {
      return Colors.purple; // Obesity class III
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: SfRadialGauge(
              enableLoadingAnimation: true,
              axes: [
                RadialAxis(
                  minimum: 10,
                  maximum: 40,
                  ranges: [
                    GaugeRange(
                      startValue: 10,
                      endValue: 16.5,
                      color: Colors.red,
                      startWidth: 15,
                      endWidth: 15,
                    ),
                    GaugeRange(
                      startValue: 16.5,
                      endValue: 18.5,
                      color: Colors.orange,
                      startWidth: 15,
                      endWidth: 15,
                    ),
                    GaugeRange(
                      startValue: 18.5,
                      endValue: 24.9,
                      color: Colors.green,
                      startWidth: 15,
                      endWidth: 15,
                    ),
                    GaugeRange(
                      startValue: 25.0,
                      endValue: 29.9,
                      color: Colors.yellow,
                      startWidth: 15,
                      endWidth: 15,
                    ),
                    GaugeRange(
                      startValue: 30.0,
                      endValue: 34.9,
                      color: Colors.orange,
                      startWidth: 15,
                      endWidth: 15,
                    ),
                    GaugeRange(
                      startValue: 35.0,
                      endValue: 39.9,
                      color: Colors.red,
                      startWidth: 15,
                      endWidth: 15,
                    ),
                    GaugeRange(
                      startValue: 40,
                      endValue: 50,
                      color: Colors.purple,
                      startWidth: 15,
                      endWidth: 15,
                    ),
                  ],
                  pointers: [
                    NeedlePointer(
                      value: bmiValue,
                      enableAnimation: true,
                      needleColor: Colors.black,
                      needleLength: 0.6,
                      lengthUnit: GaugeSizeUnit.factor,
                      needleStartWidth: 2,
                      needleEndWidth: 10,
                      animationType: AnimationType.ease,
                    ),
                  ],
                  annotations: [
                    GaugeAnnotation(
                      widget: Column(
                        children: [
                          Text(
                            'BMI: $bmiValue',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Status: $nutritionalStatus',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      positionFactor:
                          1.8, // Adjust this value to move the annotation below
                      angle: 90,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
