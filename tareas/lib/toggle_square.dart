import 'package:flutter/material.dart';
import 'dart:async';

class ToggleSquare extends StatefulWidget {
  const ToggleSquare({Key? key}) : super(key: key);

  @override
  _ToggleSquareState createState() => _ToggleSquareState();
}

class _ToggleSquareState extends State<ToggleSquare> {
  bool _isSquareVisible = true;
  late Timer _timer;
  
  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      _toggleSquare();
    });
    super.initState();
  }

  void _toggleSquare() {
    setState(() {
      _isSquareVisible = !_isSquareVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
            decoration: BoxDecoration(
              color:  _isSquareVisible ? Colors.amber : Colors.teal,
              borderRadius: BorderRadius.circular(5.0),
            ),
            width: 100.0,
            height: 100.0,
          ),
    );
  }
}