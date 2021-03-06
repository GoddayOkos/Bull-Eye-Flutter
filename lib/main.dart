import 'dart:math';

import 'package:bull_eye/control.dart';
import 'package:bull_eye/gamemodel.dart';
import 'package:bull_eye/hitmebutton.dart';
import 'package:bull_eye/prompt.dart';
import 'package:bull_eye/score.dart';
import 'package:bull_eye/styledbutton.dart';
import 'package:bull_eye/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const BullsEyeApp());

class BullsEyeApp extends StatelessWidget {
  const BullsEyeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set orientation to landscape only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);

    // Hide status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return MaterialApp(
      title: "BullsEye",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const GamePage(title: "BullsEye"),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late GameModel _model;

  @override
  void initState() {
    super.initState();
    _model = GameModel(_newTargetValue());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage("images/background.png"),
          fit: BoxFit.cover
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 48.0, bottom: 32.0),
                child: Prompt(targetValue: _model.target),
              ),
              Control(model: _model),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: HitMeButton(
                    onPressed: () {
                      _showAlert(context);
                    },
                    text: "HIT ME!",
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Score(
                    totalScore: _model.totalScore,
                    round: _model.round,
                  onStartOver: _startNewGame,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  int _sliderValue() => _model.current;

  int _pointsForCurrentRound() {
    var maximumScore = 100;
    var difference = _amountOff();
    var bonus = 0;
    if (difference == 0) {
      bonus = 100;
    } else if (difference == 1) {
      bonus = 50;
    }
    return maximumScore - difference + bonus;
  }

  int _newTargetValue() => Random().nextInt(100) + 1;

  void _startNewGame() {
    setState(() {
      _model.totalScore = GameModel.SCORE_START;
      _model.round = GameModel.ROUND_START;
      _model.target = _newTargetValue();
      _model.current = GameModel.SLIDER_START;
    });
  }

  void _showAlert(BuildContext context) {
    Widget okButton = StyledButton(
        onPressed: () {
          Navigator.of(context).pop();
          setState(() {
            _model.totalScore += _pointsForCurrentRound();
            _model.target = _newTargetValue();
            _model.round += 1;
          });
        },
        icon: Icons.close);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                _alertTitle(),
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                    "THE SLIDER'S VALUE IS",
                  textAlign: TextAlign.center,
                ),
                Text(
                    "${_sliderValue()}",
                  style: TargetTextStyle.bodyText1(context),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "\nYou scored ${_pointsForCurrentRound()} points this round.",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [okButton],
            elevation: 5,
          );
        });
  }

  int _amountOff() => (_model.target - _sliderValue()).abs();

  String _alertTitle() {
    var difference = _amountOff();

    String title;
    if (difference == 0) {
      title = "Perfect!";
    } else if (difference < 5) {
      title = "You almost had it!";
    } else if (difference <= 10) {
      title = "Not bad.";
    } else {
      title = "Are you even trying?";
    }

    return title;
  }
}
