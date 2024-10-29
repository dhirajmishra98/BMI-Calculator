import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/measurement.dart';

class MeasurementTable extends StatelessWidget {
  final List<MeasurementData> measurementsData;

  const MeasurementTable({Key? key, required this.measurementsData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 20,
        columns: const [
          DataColumn(
              label: Text('Height',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Weight',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Age (Years)',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label:
                  Text('Date', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label:
                  Text('BMI', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Interpretation',
                  style: TextStyle(fontWeight: FontWeight.bold))),
        ],
        rows: measurementsData.map((data) {
          return DataRow(cells: [
            DataCell(Text(data.height != null && data.heightUnit != null
                ? '${data.height} ${data.heightUnit!}'
                : '')),
            DataCell(Text(data.weight != null && data.weightUnit != null
                ? '${data.weight} ${data.weightUnit!}'
                : '')),
            DataCell(Text(data.ageYears.toString())),
            DataCell(data.date != null
                ? Text(DateFormat('dd.MM.yyyy HH:mm').format(data.date!))
                : const Text('/')),
            DataCell(Text(data.bmi != null ? data.bmi!.toString() : '')),
            DataCell(Text(data.interpretation ?? '')),
          ]);
        }).toList(),
      ),
    );
  }
}
