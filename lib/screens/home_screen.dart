import 'dart:convert';

import 'package:bmi_calculator/bmi_calculator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/measurement.dart';
import '../utils/form_validators.dart';
import '../utils/global_variables.dart';
import '../utils/utils.dart';
import '../widgets/bmi_card.dart';
import '../widgets/bmi_gauge_chart.dart';
import '../widgets/gender_card.dart';
import 'bmi_result_screen.dart';
import 'history_screen.dart';
import 'info_screen.dart';

enum Gender { male, female }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // for history storage
  late SharedPreferences _prefs;
  List<MeasurementData> measurementsData = [];

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
  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.getString('measurementsData') != null) {
      _loadData();
    } else {
      setState(() {
        measurementsData = [];
      });
    }
  }

  Future<void> _loadData() async {
    _prefs = await SharedPreferences.getInstance();
    final String? jsonString = _prefs.getString('measurementsData');
    if (jsonString != null) {
      setState(() {
        measurementsData = (json.decode(jsonString) as List)
            .map((item) => MeasurementData.fromMap(item))
            .toList();
      });
    }
  }

  void calculateBmi(double height, double weight, int age, String gender) {
    debugPrint(age.toString());
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

void storeData(double height, double weight, int age, String gender) async {
  await _loadData();

  final dateToStore = MeasurementData(
      height: height,
      weight: weight,
      ageYears: age,
      ageMonths: 0,
      gender: gender,
      bmi: bmi,
      interpretation: interpretation,
      date: DateTime.now(),
      heightUnit: selectedHeightUnit,
      weightUnit: selectedWeightUnit);

  // Check for duplicates
  bool isDuplicate = measurementsData.any((measurement) =>
      measurement.height == height &&
      measurement.weight == weight &&
      measurement.ageYears == age &&
      measurement.gender == gender);

  if (!isDuplicate) {
    measurementsData.add(dateToStore);

    await _prefs.setString('measurementsData',
        json.encode(measurementsData.map((e) => e.toMap()).toList()));

    setState(() {});
  }
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
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("BMI Calculator"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BMIInfoScreen()),
                );
              },
              icon: const Icon(
                Icons.info,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HistoryScreen()),
                );
              },
              icon: const Icon(
                Icons.history,
              ),
            ),
            const Gap(10),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
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
                    Expanded(
                      child: GenderCard(
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
                    ),
                    Expanded(
                      child: GenderCard(
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
                    ),
                  ],
                ),
                const Gap(10),
                SizedBox(
                  height: _isComputed ? size.height * 0.25 : size.height * 0.4,
                  child: Form(
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
                ),
                Visibility(
                  visible: _isComputed && bmi != null && interpretation != null,
                  child: SizedBox(
                    height: size.height * 0.3,
                    child: Expanded(
                      child: BMIGaugeChart(
                        bmiValue: bmi ?? 0.0,
                        nutritionalStatus: interpretation ?? "not found!",
                      ),
                    ),
                  ),
                ),
                if (_isComputed) const BMIStatusCards(),
                if (!_isComputed) ...[
                  Image.asset(
                    "assets/bmi-waiting.png",
                    height: size.height * 0.2,
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                  ),
                  Text(
                    "Result will appear here",
                    style: customTextDecoration(),
                  ),
                ],
                const Gap(50),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: blueColor,
          onPressed: () {
            if (_isComputed) {
              _showModalBottomSheet(context);
            }
            if (gender == null) {
              WidgetsBinding.instance.addPostFrameCallback((_) =>
                  showSnackbar(message: "Select gender", context: context));
            }
            if (_formKey.currentState!.validate() && gender != null) {
              double height = 0;
              debugPrint(_inchesController.text);
              if (selectedHeightUnit == "feet & inches") {
                height = getHeightInMetersFromFeetInches(
                    _feetController.text.trim(), _inchesController.text.trim());
              } else {
                height = getHeightInMeters(
                    _heightController.text.trim(), selectedHeightUnit);
              }

              double weight = getWeightInKg(
                  _weightController.text.trim(), selectedWeightUnit);
              int age = double.tryParse(_ageController.text.trim())!.round();
              calculateBmi(height, weight, age, gender!.toString());
              storeData(height, weight, age,
                  gender!.toString()); //store data in local memory

              setState(() {
                _isComputed = true;
              });
            }
          },
          label: Text(
            _isComputed ? "Get Suggestion" : "Calculate",
            style: const TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Future<dynamic> _showModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
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
          flex: 3,
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
          flex: 1,
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
                    validator: (value) => validateHeightFeet(value!, context),
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
                    validator: (value) => validateHeightInch(value!, context),
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
