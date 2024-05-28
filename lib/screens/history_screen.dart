import 'dart:convert';
import 'package:calculate_bmi/widgets/history_chart.dart';
import 'package:calculate_bmi/widgets/measure-table.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/measurement.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late SharedPreferences _prefs;
  List<MeasurementData> measurementsData = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void clearAllHistory() {
    setState(() {
      measurementsData.clear();
      _prefs.setString('measurementsData', json.encode([]));
    });
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
    } else {
      setState(() {
        measurementsData = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("BMI Calculator"),
          actions: [
            IconButton(
              onPressed: () {
                clearAllHistory();
              },
              icon: const Icon(
                Icons.delete_forever,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (measurementsData.isNotEmpty) ...[
                  const Text(
                    'Measurement History Graph',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  BMIChart(
                    yData:
                        measurementsData.map((data) => data.bmi ?? 0).toList(),
                    xData: measurementsData.map((data) {
                      if (data.date != null) {
                        return DateFormat('dd.MM.yyyy HH:mm')
                            .format(data.date!);
                      } else {
                        return "";
                      }
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Measurement History Table',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  MeasurementTable(measurementsData: measurementsData),
                ] else ...[
                  const Text(
                    'No measurement history found.',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
