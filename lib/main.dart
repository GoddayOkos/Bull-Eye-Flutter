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
    _model = GameModel(50);
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
                      "Hello there!", "The slider's value is ${_model.current}");
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
