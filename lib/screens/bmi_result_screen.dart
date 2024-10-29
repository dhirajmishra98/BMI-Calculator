import 'package:flutter/material.dart';

import '../utils/utils.dart';

class BMIResultScreen extends StatelessWidget {
  final double bmiValue;
  final String message;

  const BMIResultScreen(
      {Key? key, required this.bmiValue, required this.message})
      : super(key: key);

  List<String> getImprovementTips(double bmi) {
    List<String> tips = [];

    if (bmi < 16.5) {
      tips.add(
          'Consult with a healthcare professional for immediate intervention.');
      tips.add(
          'Consider a personalized treatment plan for severe underweight.');
      tips.add('Include nutrient-dense foods in your diet.');
      tips.add('Focus on gradual weight gain with a balanced diet.');
    } else if (bmi >= 16.5 && bmi < 18.5) {
      tips.add('Consider adding more protein and healthy fats to your diet.');
      tips.add('Incorporate strength training exercises to build muscle mass.');
      tips.add('Include a variety of fruits and vegetables in your meals.');
      tips.add(
          'Ensure you are getting enough calories to support your weight.');
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      tips.add(
          'Maintain a balanced diet with a variety of nutrient-rich foods.');
      tips.add(
          'Stay physically active with regular exercise for overall well-being.');
      tips.add('Stay hydrated by drinking an adequate amount of water.');
      tips.add('Get enough sleep to support your overall health.');
    } else if (bmi >= 25.0 && bmi <= 29.9) {
      tips.add('Focus on portion control and avoid overeating.');
      tips.add(
          'Engage in aerobic exercises like walking, running, or cycling.');
      tips.add('Limit the intake of processed and sugary foods.');
      tips.add('Incorporate strength training exercises to boost metabolism.');
    } else if (bmi >= 30.0 && bmi <= 34.9) {
      tips.add(
          'Adopt a healthy, calorie-controlled diet to promote weight loss.');
      tips.add('Incorporate both aerobic and strength training exercises.');
      tips.add('Monitor portion sizes and avoid high-calorie snacks.');
      tips.add(
          'Consider seeking guidance from a nutritionist for a personalized plan.');
    } else if (bmi >= 35.0 && bmi <= 39.9) {
      tips.add(
          'Consult with a healthcare professional for a personalized weight management plan.');
      tips.add(
          'Consider joining a support group or seeking guidance from a nutritionist.');
      tips.add(
          'Incorporate stress management techniques for overall well-being.');
      tips.add('Set realistic weight loss goals and track your progress.');
    } else {
      tips.add(
          'Immediate intervention is necessary. Consult with healthcare professionals for personalized treatment.');
      tips.add(
          'Addressing severe obesity may require a comprehensive approach involving medical experts.');
      tips.add(
          'Consider bariatric surgery as an option for significant weight loss.');
      tips.add('Engage in regular medical check-ups to monitor your health.');
    }

    return tips;
  }

  @override
  Widget build(BuildContext context) {
    List<String> improvementTips = getImprovementTips(bmiValue);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your BMI is: ${bmiValue.toStringAsFixed(1)}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Status: $message',
              style: customTextDecoration(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Improvement Tips:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            for (String tip in improvementTips)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
                child: Text('• $tip'),
              ),
          ],
        ),
      ),
    );
  }
}
