import 'package:flutter/material.dart';

import 'utils.dart';

validateWeight(String value, BuildContext context) {
  if (value.isEmpty) {
    return "weight cannot be empty";
  }

  if (double.tryParse(value) == null) {
    return "weight is invalid number";
  }

  if (double.tryParse(value)! <= 0) {
    return "weight cannot be less than 0";
  }

  return null;
}

validateHeight(String value, BuildContext context) {
  if (value.isEmpty) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showSnackbar(
        message: "height cannot be empty",
        context: context,
        isValidation: true));
    return "empty";
  }

  if (double.tryParse(value) == null) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showSnackbar(
        message: "height value is not a valid number",
        context: context,
        isValidation: true));
    return "invalid number";
  }

  if (double.tryParse(value)! <= 0) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showSnackbar(
        message: "height cannot be zero or negative",
        context: context,
        isValidation: true));
    return "negative or zero";
  }

  return null;
}

validateHeightFeet(String value, BuildContext context) {
  if (value.isEmpty) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showSnackbar(
        message: "feet cannot be empty", context: context, isValidation: true));
    return "";
  }

  if (double.tryParse(value) == null) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showSnackbar(
        message: "feet is invalid number",
        context: context,
        isValidation: true));
    return "";
  }

  if (double.tryParse(value)! % 1 != 0) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showSnackbar(
        message: "feet cannot contain decimal value",
        context: context,
        isValidation: true));
    return "";
  }

  if (double.tryParse(value)! <= 0) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showSnackbar(
        message: "feet cannot be zero or negative",
        context: context,
        isValidation: true));
    return "";
  }

  return null;
}

validateHeightInch(String value, BuildContext context) {
  if (value.isEmpty) {
    return null;
  }

  if (double.tryParse(value) == null) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showSnackbar(
        message: "inch is invalid number",
        context: context,
        isValidation: true));
    return "";
  }

  if (double.tryParse(value)! < 0) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showSnackbar(
        message: "inch cannot be negative",
        context: context,
        isValidation: true));
    return "";
  }

  return null;
}

validateAge(String value, BuildContext context) {
  if (value.isEmpty) {
    return "age cannot be empty";
  }

  if (double.tryParse(value) == null) {
    return "age is invalid number";
  }

  if (double.tryParse(value)! % 1 != 0) {
    return "age cannot contain decimal value";
  }

  if (double.tryParse(value)! <= 0) {
    return "age cannot be less than 0";
  }

  if (double.tryParse(value)! > 100) {
    return "age cannot be greater than 100";
  }

  return null;
}
