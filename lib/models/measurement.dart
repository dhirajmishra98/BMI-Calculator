import 'dart:convert';

class MeasurementData {
  final double height;
  final double weight;
  final int ageYears;
  final int ageMonths;
  final String gender;
  final double? bmi;
  final String? interpretation;
  final DateTime? date;
  final String? heightUnit;
  final String? weightUnit;

  MeasurementData({
    required this.height,
    required this.weight,
    required this.ageYears,
    required this.ageMonths,
    required this.gender,
    this.bmi,
    this.interpretation,
    this.date,
    this.heightUnit,
    this.weightUnit,
  });

  Map<String, dynamic> toMap() {
    return {
      'height': height,
      'weight': weight,
      'ageYears': ageYears,
      'ageMonths': ageMonths,
      'gender': gender,
      'bmi': bmi,
      'interpretation': interpretation,
      'date': date?.toString(), // Convert DateTime to string
      'heightUnit': heightUnit,
      'weightUnit': weightUnit,
    };
  }

  factory MeasurementData.fromMap(Map<String, dynamic> map) {
    return MeasurementData(
      height: map['height'],
      weight: map['weight'],
      ageYears: map['ageYears'],
      ageMonths: map['ageMonths'],
      gender: map['gender'],
      bmi: map['bmi'],
      interpretation: map['interpretation'],
      date: map['date'] != null
          ? DateTime.parse(map['date'])
          : null, 
      heightUnit: map['heightUnit'],
      weightUnit: map['weightUnit'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MeasurementData.fromJson(String source) =>
      MeasurementData.fromMap(json.decode(source));
}
