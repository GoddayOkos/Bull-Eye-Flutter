import 'package:flutter/material.dart';

void main() => runApp(BullsEyeApp());


class BullsEyeApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
  bool _knockKnockVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Hello to my first flutter app",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
            TextButton(onPressed: () {
              _alertIsVisible = true;
              _showAlert(context);
              print("Button pressed!");
              },
                child: const Text("Hit Me!", style: TextStyle(color: Colors.blue), )),
            TextButton(onPressed: () {
              _knockKnockVisible = true;
              _showWhosThere(context);
            }, child: const Text("Knock, Knock"))
          ],
        ),
      ),
    );
  }

  void _showAlert(BuildContext context) {
    Widget okButton = TextButton(onPressed: () {
      Navigator.of(context).pop();
      _alertIsVisible = false;
      print("Awesome pressed! $_alertIsVisible");
    }, child: const Text("Awesome!"));

    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Hello there!"),
        content: const Text("This is my first pop-up"),
        actions: [okButton],
        elevation: 5,
      );
    });
  }

  void _showWhosThere(BuildContext context) {
    Widget okButton = TextButton(onPressed: () {
      _knockKnockVisible = false;
      Navigator.of(context).pop();
    }, child: const Text("Knock Off"));

    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Who's There?"),
        content: const Text("Man up and handle your sh*t"),
        actions: [okButton],
        elevation: 5,
      );
    });
  }

}
