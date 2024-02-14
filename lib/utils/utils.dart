import 'package:calculate_bmi/utils/global_variables.dart';
import 'package:flutter/material.dart';

double getHeightInMeters(String value, String heightType) {
  double height = double.tryParse(value)!;

  if (heightType == "cm") {
    height = height / 100;
  } else if (heightType == "inches") {
    height = height * 0.0254;
  }
  return height;
}

double getHeightInMetersFromFeetInches(String feet, String inches) {
  dynamic heightFeet = double.tryParse(feet);
  dynamic heightInches = double.tryParse(inches);
  // Convert feet and inches to meters
  double heightMeters =
      ((heightFeet ?? 0.0) * 0.3048) + ((heightInches ?? 0.0) * 0.0254);
  return heightMeters;
}

double getWeightInKg(String value, String weightType) {
  double weight = double.tryParse(value)!;

  if (weightType == "lb") {
    weight = weight * 0.45359237;
  }
  return weight;
}

void showSnackbar(
    {required String message,
    required BuildContext context,
    bool isValidation = false}) {
  final size = MediaQuery.sizeOf(context);
  final SnackBar snackbar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16.0,
      ),
    ),
    backgroundColor: Colors.teal, // Change background color
    margin: EdgeInsets.only(
        bottom: isValidation ? size.height * 0.72 : 20, left: 20, right: 20),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    dismissDirection: DismissDirection.horizontal,
    duration: const Duration(seconds: 2), // Set duration
    action: SnackBarAction(
      label: 'OK',
      textColor: Colors.white,
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

TextStyle customTextDecoration() {
  return const TextStyle(
    color: blueColor,
    fontSize: 15,
    fontWeight: FontWeight.w800,
  );
}

InputDecoration customTextfieldDecoration() {
  return const InputDecoration(
    isDense: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFC3C3C3),
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFC3C3C3),
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFC3C3C3),
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
    ),
  );
}
