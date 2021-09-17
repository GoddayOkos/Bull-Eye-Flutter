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
                      "Hello there!", "The slider's value is ${_sliderValue()}.\n" +
                  "You scored ${_pointsForCurrentRound()} points for this round.");
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

  int _sliderValue() => _model.current;

  int _pointsForCurrentRound() {
    var maximumScore = 100;
    var difference = (_model.target - _sliderValue()).abs();
    return maximumScore - difference;
  }

  void _showAlert(BuildContext context, bool state, String okText, String title,
      String content) {
    Widget okButton = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          state = false;
          setState(() {
            _model.totalScore += _pointsForCurrentRound();
            _model.target = Random().nextInt(100) + 1;
            _model.round += 1;
          });
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
