import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({ Key? key }) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.orange,
    );
  }
}