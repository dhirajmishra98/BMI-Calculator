import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utils/global_variables.dart';

class BMIInfoScreen extends StatelessWidget {
  const BMIInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Information'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'BMI Calculation Formula:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: blueColor,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'BMI = kg/m²',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Interprets the BMI value:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: blueColor,
                ),
              ),
              const Gap(8),
              _buildBMIInterpretation(
                  '• For individuals outside the age range of 5-19 years, it uses the general BMI categories.',
                  ''),
              _buildBMIInterpretation(
                  '• For children and teenagers aged 5-19, it uses BMI-for-age percentiles data, considering the gender of the individual.',
                  ''),
              const Gap(10),
              const Text(
                'Interpretation Guidelines:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: blueColor,
                ),
              ),
              const SizedBox(height: 8),
              _buildBMIInterpretation(
                  "1. For Adults (outside the age range of 5-19 years):", ''),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBMIInterpretation(
                        'Severely underweight: ', 'BMI < 16'),
                    _buildBMIInterpretation('Underweight: ', '16 ≤ BMI < 16.9'),
                    _buildBMIInterpretation(
                        'Mildly underweight: ', '16.9 ≤ BMI < 18.4'),
                    _buildBMIInterpretation(
                        'Normal weight: ', '18.4 ≤ BMI < 24.9'),
                    _buildBMIInterpretation(
                        'Overweight: ', '24.9 ≤ BMI < 29.9'),
                    _buildBMIInterpretation(
                        'Obese Class I (Moderate): ', '29.9 ≤ BMI < 34.9'),
                    _buildBMIInterpretation(
                        'Obese Class II (Severe): ', '34.9 ≤ BMI < 39.9'),
                    _buildBMIInterpretation(
                        'Obese Class III (Very severe or morbidly obese): ',
                        'BMI ≥ 40'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildBMIInterpretation(
                  "2. For Children and Teenagers (age range of 5-19 years):",
                  ''),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBMIInterpretation('Severely wasted: ',
                        'BMI less than the -3rd percentile'),
                    _buildBMIInterpretation('Wasted: ',
                        'BMI between the -3rd and -2nd percentiles'),
                    _buildBMIInterpretation('Normal weight: ',
                        'BMI between the -2nd and 0th percentiles'),
                    _buildBMIInterpretation('Possible risk of overweight: ',
                        'BMI between the 0th and 1st percentiles'),
                    _buildBMIInterpretation('Overweight: ',
                        'BMI between the 1st and 2nd percentiles'),
                    _buildBMIInterpretation(
                        'Obese: ', 'BMI greater than the 2nd percentile'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildSubtitle('Note:'),
              _buildText(
                  'For the age-specific interpretations, the percentile data from WHO is used. '
                  'It\'s essential to ensure the correctness of this dataset for accurate interpretations.'),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBMIInterpretation(String category, String criteria) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          children: [
            TextSpan(text: category),
            TextSpan(
              text: criteria,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubtitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: blueColor,
      ),
    );
  }

  Widget _buildText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }
}
