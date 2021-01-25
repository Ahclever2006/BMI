import 'package:flutter/material.dart';
import 'dart:math';

import 'package:localize_and_translate/localize_and_translate.dart';

class ResultScreen extends StatelessWidget {
  final int weight;
  final int height;

  String type;
  String advice;

  ResultScreen({@required this.height, @required this.weight});

  double result;

  void calcBMI() {
    result = weight / pow(height / 100, 2);

    if (result < 18.5) {
      type = 'UnderWeight';
      advice = 'You need to eat more';
    } else if (result < 25) {
      type = 'NormalWeight';
      advice = 'Good job';
    } else if (result < 30) {
      type = 'OverWeight';
      advice = 'You need to eat healthy food';
    } else if (result > 30) {
      type = 'Obesity';
      advice = 'You need to visit doctor';
    }

    if (translator.currentLanguage == 'ar') {
      if (type == 'NormalWeight') {
        type = 'وزنك طبيعي';
        advice = 'احسنت';
      } else if (type == 'UnderWeight') {
        type = 'وزنك قليل';
        advice = 'اكثر من اكلك';
      } else if (type == 'OverWeight') {
        type = 'وزنك زائد';
        advice = 'قلل من اكلك';
      } else {
        type = 'وزنك زائد جدا';
        advice = 'استشر طبيب';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    calcBMI();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 28, 29, 41),
          title: Center(
            child: Text(
              'Result',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 171, 173, 181)),
            ),
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Color.fromARGB(255, 28, 29, 41),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  translator.translate('YourResult'),
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 39, 40, 54),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                          child: Text(
                        '$type',
                        style: TextStyle(color: Colors.green, fontSize: 24),
                      )),
                      Center(
                          child: Text('${result.toStringAsFixed(1)}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold))),
                      Center(
                          child: Text(
                        '$advice',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 26,
                            color: Color.fromARGB(255, 171, 173, 181)),
                      )),
                    ],
                  ),
                ),
              ),
              Container(
                height: 70,
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(4),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    translator.translate('Recalculate'),
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  color: Colors.pink,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
