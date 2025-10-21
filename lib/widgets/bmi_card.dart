import 'package:flutter/material.dart';

class BMIStatusCards extends StatelessWidget {
  const BMIStatusCards({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BMICard(
                range: 'Underweight',
                status: 'Below 18.5',
                color: Colors.blue,
              ),
              BMICard(
                range: 'Normal',
                status: '18.5–24.9',
                color: Colors.green,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BMICard(
                range: 'Overweight',
                status: '25.0–29.9',
                color: Colors.orange,
              ),
              BMICard(
                range: 'Obesity',
                status: '30.0 and above',
                color: Colors.red,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class BMICard extends StatelessWidget {
  final String range;
  final String status;
  final Color color;

  const BMICard({
    Key? key,
    required this.range,
    required this.status,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Card(
      color: color,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        width: size.width * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              range,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              status,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
