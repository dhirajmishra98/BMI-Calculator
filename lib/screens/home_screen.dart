import 'package:bmi_calculator/bmi_calculator.dart';
import 'package:calculate_bmi/screens/bmi_result_screen.dart';
import 'package:calculate_bmi/screens/info_screen.dart';
import 'package:calculate_bmi/widgets/custom_button.dart';
import 'package:calculate_bmi/utils/global_variables.dart';
import 'package:calculate_bmi/widgets/bmi_gauge_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../widgets/bmi_card.dart';
import '../widgets/gender_card.dart';
import '../utils/utils.dart';

enum Gender { male, female }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Gender? gender;
  final _formKey = GlobalKey<FormState>();
  String selectedHeightUnit = "m";
  String selectedWeightUnit = "kg";
  bool _isComputed = false;
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _feetController = TextEditingController();
  final TextEditingController _inchesController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  double? bmi;
  String? interpretation;

  void calculateBmi(double height, double weight, int age, String gender) {
    final bmiCalculator = BMI(
      standard: Standard.WHO,
      height: height,
      weight: weight,
      ageYears: age,
      ageMonths: 0,
      gender: gender,
    );

    bmi = double.tryParse(bmiCalculator.computeBMI().toStringAsFixed(2));
    interpretation = bmiCalculator.interpretBMI();
  }

  @override
  void dispose() {
    super.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _ageController.dispose();
    _feetController.dispose();
    _inchesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("BMI Calculator"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>const BMIInfoScreen()),
              );
            },
            icon: const Icon(
              Icons.info,
            ),
          ),
          const Gap(10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Select Your Gender: ",
                  style: customTextDecoration(),
                ),
                GenderCard(
                  text: "Male",
                  iconData: Icons.man,
                  isSelected: gender == Gender.male,
                  onTap: () {
                    setState(() {
                      gender = Gender.male;
                      _isComputed = false;
                    });
                  },
                ),
                GenderCard(
                  text: "Female",
                  iconData: Icons.woman,
                  isSelected: gender == Gender.female,
                  onTap: () {
                    setState(() {
                      gender = Gender.female;
                      _isComputed = false;
                    });
                  },
                ),
              ],
            ),
            const Gap(20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  inputHeight(context),
                  const Gap(10),
                  inputWeight(context),
                  const Gap(10),
                  inputAge(context),
                  const Gap(10),
                ],
              ),
            ),
            Visibility(
              visible: _isComputed && bmi != null && interpretation != null,
              child: Expanded(
                  child: BMIGaugeChart(
                bmiValue: bmi ?? 0.0,
                nutritionalStatus: interpretation ?? "not found!",
              )),
            ),
            if (_isComputed) const BMIStatusCards(),
            if (!_isComputed) ...[
              const Spacer(),
              Text(
                "result will appear here",
                style: customTextDecoration(),
              ),
              const Spacer(),
            ],
            CustomButton(
              onTap: () {
                if (_isComputed) {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: BMIResultScreen(
                            bmiValue: bmi!,
                            message: interpretation!,
                          ),
                        ),
                      );
                    },
                  );
                }
                if (gender == null) {
                  showSnackbar("Select gender", context);
                }
                if (_formKey.currentState!.validate() && gender != null) {
                  double height = 0;
                  if (selectedHeightUnit == "feet & inches") {
                    height = getHeightInMetersFromFeetInches(
                        _feetController.text.trim(),
                        _inchesController.text.trim());
                  } else {
                    height = getHeightInMeters(
                        _heightController.text.trim(), selectedHeightUnit);
                  }

                  double weight = getWeightInKg(
                      _weightController.text.trim(), selectedWeightUnit);
                  int age = int.tryParse(_ageController.text.trim())!;
                  calculateBmi(height, weight, age, gender!.toString());
                  setState(() {
                    _isComputed = true;
                  });
                }
              },
              title: _isComputed ? "get suggestion" : "Calculate",
            ),
          ],
        ),
      ),
    );
  }

  Row inputAge(BuildContext context) {
    return Row(
      children: [
        Text(
          "Age (in Years): ",
          style: customTextDecoration(),
        ),
        const Gap(5),
        Expanded(
          child: TextFormField(
            controller: _ageController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.next,
            decoration: customTextfieldDecoration(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {
              setState(() {
                _isComputed = false;
              });
            },
            validator: (value) => validateAge(value!, context),
          ),
        ),
      ],
    );
  }

  Row inputWeight(BuildContext context) {
    return Row(
      children: [
        Text(
          "Weight: ",
          style: customTextDecoration(),
        ),
        const Gap(5),
        Expanded(
          child: TextFormField(
            controller: _weightController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: customTextfieldDecoration(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => validateWeight(value!, context),
            onChanged: (value) {
              setState(() {
                _isComputed = false;
              });
            },
          ),
        ),
        const Gap(10),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: selectedWeightUnit,
            iconEnabledColor: const Color(0xFFC3C3C3),
            iconDisabledColor: const Color(0xFFC3C3C3),
            iconSize: 25,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            items: weight.map((category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedWeightUnit = value!;
                _isComputed = false;
              });
            },
            decoration: customTextfieldDecoration(),
          ),
        ),
      ],
    );
  }

  Row inputHeight(BuildContext context) {
    return Row(
      children: [
        Text(
          "Height: ",
          style: customTextDecoration(),
        ),
        const Gap(5),
        // Check if the selected unit is "Feet & Inches"
        if (selectedHeightUnit == "feet & inches")
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _feetController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: customTextfieldDecoration(),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => validateHeight(value!, context),
                    onChanged: (value) {
                      setState(() {
                        _isComputed = false;
                      });
                    },
                  ),
                ),
                const Gap(5),
                Text(
                  "ft",
                  style: customTextDecoration(),
                ),
                const Gap(10),
                Expanded(
                  child: TextFormField(
                    controller: _inchesController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: customTextfieldDecoration(),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => validateHeight(value!, context),
                    onChanged: (value) {
                      setState(() {
                        _isComputed = false;
                      });
                    },
                  ),
                ),
                const Gap(5),
                Text(
                  "in",
                  style: customTextDecoration(),
                ),
              ],
            ),
          )
        else
          // If the unit is not "Feet & Inches", show a single TextFormField
          Expanded(
            child: TextFormField(
              controller: _heightController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.next,
              decoration: customTextfieldDecoration(),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => validateHeight(value!, context),
              onChanged: (value) {
                setState(() {
                  _isComputed = false;
                });
              },
            ),
          ),
        const Gap(10),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: selectedHeightUnit,
            iconEnabledColor: const Color(0xFFC3C3C3),
            iconDisabledColor: const Color(0xFFC3C3C3),
            iconSize: 25,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            items: height.map((category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedHeightUnit = value!;
                _isComputed = false;
              });
            },
            decoration: customTextfieldDecoration(),
          ),
        ),
      ],
    );
  }
}
