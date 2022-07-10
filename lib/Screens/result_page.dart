import 'package:bmi_calculator/Components/constants.dart';
import 'package:bmi_calculator/Components/reusable_card.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  ResultPage(
      {required this.resultText,
      required this.bmiNumber,
      required this.komments,
      required this.rangeText,
      required this.rangeValue});
  final String resultText;
  final String bmiNumber;
  final String komments;
  final String rangeText;
  final String rangeValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                'Your Result',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: ReusableCard(
              onPress: () {},
              childCard: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        resultText.toUpperCase(),
                        style: kResultTextStyle,
                      ),
                    ),
                  ),
                  Text(
                    bmiNumber,
                    style: kBmiReadingResult,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          rangeText,
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Color(0xFF8D8E98),
                          ),
                        ),
                        Text(
                          rangeValue,
                          style: kComments,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    komments,
                    style: kComments,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    //functionality is not added
                    color: Color(0xFF111338),
                      margin: EdgeInsets.all(5.0),
                      padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 15.0),
                      child: Text(
                    'SAVE RESULT',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 2.0
                    ),
                  )),
                ],
              ),
              colour: kActiveCardColor,
            ),
          ),
          CalculateOption(
            text: 'Re-CALCULATE',
            command: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
