import 'package:flutter/material.dart';
import 'package:bmi_calculator/Components/constants.dart';
class IconContent extends StatelessWidget {
  IconContent({required this.iconCustom, required this.label});

  final IconData iconCustom;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          iconCustom,
          size: 80.0,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: kLabelTextStyle,
        )
      ],
    );
  }
}
