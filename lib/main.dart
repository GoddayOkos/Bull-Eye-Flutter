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
  GamePage({this.title = ""});

  final String title;

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool _alertIsVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Hello to my first flutter app",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
            TextButton(
                onPressed: () {
                  _alertIsVisible = true;
                  _showAlert(context, _alertIsVisible, "Awesome!",
                      "Hello there!", "This is my first pop-up");
                  print("Button pressed!");
                },
                child: const Text(
                  "Hit Me!",
                  style: TextStyle(color: Colors.blue),
                )),
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
