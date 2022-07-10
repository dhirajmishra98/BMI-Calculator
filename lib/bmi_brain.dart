import 'dart:math';

class BmiBrain {
  BmiBrain({required this.height, required this.weight});
  final int height;
  final int weight;
  double _bmi = 0;

  final List _quotesOverweight = [
    'Consume less “bad” fat and more “good” fat.',
    'Consume less processed and sugary foods.',
    'Eat more servings of vegetables and fruits.',
    'Engage in regular aerobic activity.',
  ];
  final List _quotesNormal = [
    'Eat a variety of foods.',
    'Base your diet on plenty of foods rich in carbohydrates.',
    'Eat regularly, control the portion size.',
    'Enjoy plenty of fruits and vegetables.',
  ];
  final List _quotesUnderweight = [
    'Eat more frequently. When you\'re underweight, you may feel full faster.',
    'Choose nutrient-rich foods.',
    'Have an occasional treat.',
    'Try smoothies and shakes.',
  ];

  String getBmi() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi >= 25) {
      return 'Overweight';
    } else if (_bmi >= 18.5) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  String komments() {
    if (_bmi >= 25) {
      return _quotesOverweight[Random().nextInt(4)];
    } else if (_bmi >= 18.5) {
      return _quotesNormal[Random().nextInt(4)];
    } else {
      return _quotesUnderweight[Random().nextInt(4)];
    }
  }

  String rangeText() {
    if (_bmi >= 25) {
      return 'Overweight BMI Range: ';
    } else if (_bmi >= 18.5) {
      return 'Normal BMI Range: ';
    } else {
      return 'Underweight BMI Range: ';
    }
  }

  String rangeValue() {
    if (_bmi >= 25) {
      return '25 - Above kg/m2';
    } else if (_bmi >= 18.5) {
      return '18.5 - 24.9 kg/m2';
    } else {
      return '18.5 - Below kg/m2';
    }
  }
}
