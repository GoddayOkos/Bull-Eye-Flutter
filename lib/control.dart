import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Control extends StatefulWidget {
  Control({Key? key}) : super(key: key);

  @override
  _ControlState createState() => _ControlState();
}

class _ControlState extends State<Control> {
  double _currentValue = 50.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("1"),
        Slider(
          value: _currentValue,
          onChanged: (newValue) {
            setState(() {
              _currentValue = newValue;
              print(_currentValue);
            });
          },
          min: 1.0,
          max: 100.0,
        ),
        const Text("100")
      ],
    );
  }

}