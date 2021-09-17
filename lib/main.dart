import 'dart:math';

import 'package:bull_eye/control.dart';
import 'package:bull_eye/gamemodel.dart';
import 'package:bull_eye/prompt.dart';
import 'package:bull_eye/score.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(BullsEyeApp());

class BullsEyeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Set orientation to landscape only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);

    return MaterialApp(
      title: "BullsEye",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: GamePage(title: "BullsEye"),
    );
  }
}

class GamePage extends StatefulWidget {
  GamePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool _alertIsVisible = false;
  late GameModel _model;

  @override
  void initState() {
    super.initState();
    _model = GameModel(Random().nextInt(100) + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Prompt(targetValue: _model.target),
            Control(model: _model),
            TextButton(
                onPressed: () {
                  _alertIsVisible = true;
                  _showAlert(context, _alertIsVisible, "Awesome!",
                      "Hello there!", "The slider's value is ${_model.current}.\n" +
                  "You scored ${_pointsForCurrentRound()} points fot this round.");
                },
                child: const Text(
                  "Hit Me!",
                  style: TextStyle(color: Colors.blue),
                )),
            Score(
                totalScore: _model.totalScore,
                round: _model.round)
          ],
        ),
      ),
    );
  }

  int _pointsForCurrentRound() {
    int maximumScore = 100;
    int difference;
    int sliderValue = _model.current;
    if (sliderValue > _model.target) {
      difference = sliderValue - _model.target;
    } else if (_model.target > sliderValue) {
      difference = _model.target - sliderValue;
    } else {
      difference = 0;
    }
    return maximumScore - difference;
  }

  void _showAlert(BuildContext context, bool state, String okText, String title,
      String content) {
    Widget okButton = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          state = false;
        },
        child: Text(okText));

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [okButton],
            elevation: 5,
          );
        });
  }
}
