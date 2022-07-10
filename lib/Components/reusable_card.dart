import 'package:flutter/material.dart';
import 'package:bmi_calculator/Components/constants.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard(
      {required this.colour, required this.childCard, required this.onPress});
  final Color colour;
  final Widget childCard;
  // final void Function() onPress ;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: childCard,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  RoundIconButton({required this.icon, required this.onPressed});
  final IconData icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(icon),
      onPressed: onPressed,
      elevation: 6.0,
      fillColor: Color(0xFF4C4F5E),
      constraints: BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      shape: CircleBorder(),
    );
  }
}

class CalculateOption extends StatelessWidget {
  CalculateOption({required this.text, required this.command});
  final String text;
  final void Function() command;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: command,
      child: Container(
        child: Center(
          child: Text(
            text,
            style: kLargeButtonTextStyle,
          ),
        ),
        color: kBottomContainerColor,
        margin: EdgeInsets.only(top: 10.0),
        width: double.infinity,
        height: kBottomContainerHeight,
        padding: EdgeInsets.only(bottom: 10.0),
      ),
    );
  }
}

