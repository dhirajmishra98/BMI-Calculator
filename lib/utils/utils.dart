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
  double heightFeet = double.parse(feet);
  double heightInches = double.parse(inches);
  // Convert feet and inches to meters
  double heightMeters = (heightFeet * 0.3048) + (heightInches * 0.0254);
  return heightMeters;
}

double getWeightInKg(String value, String weightType) {
  double weight = double.tryParse(value)!;

  if (weightType == "lb") {
    weight = weight * 0.45359237;
  }
  return weight;
}

void showSnackbar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      backgroundColor: Colors.teal, // Change background color
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
    ),
  );
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

validateWeight(String value, BuildContext context) {
  if (value.isEmpty) {
    return "weight cannot be empty";
  }

  if (double.tryParse(value) == null) {
    return "enter a valid number";
  }

  if (double.tryParse(value)! <= 0) {
    return "weight cannot be zero or negative";
  }

  return null;
}

validateHeight(String value, BuildContext context) {
  if (value.isEmpty) {
    return "height cannot be empty";
  }

  if (double.tryParse(value) == null) {
    return "enter a valid number";
  }

  if (double.tryParse(value)! <= 0) {
    return "height cannot be zero or negative";
  }

  return null;
}

validateAge(String value, BuildContext context) {
  if (value.isEmpty) {
    return "age cannot be empty";
  }

  if (double.tryParse(value) == null) {
    return "enter a valid number";
  }

  if (double.tryParse(value)! <= 0) {
    return "age cannot be zero or negative";
  }

  if (double.tryParse(value)! > 100) {
    return "age cannot be greater than 100";
  }

  return null;
}
