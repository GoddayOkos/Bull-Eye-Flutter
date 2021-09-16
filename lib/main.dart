import 'package:flutter/material.dart';

void main() {
  runApp(BullsEyeApp());
}

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

}
