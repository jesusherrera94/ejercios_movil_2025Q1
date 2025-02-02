import 'package:flutter/material.dart';
import 'dart:async';

class Contador extends StatefulWidget {

  @override
  State<Contador> createState() => _ContadorState();

}


class _ContadorState extends State<Contador> {
  // state
  int _counterState = 0;
  String _time = "00:00:00";

  // controlador
  late Timer _timer;


  @override
  void initState () {
    _contador();
    super.initState();
  }

  void _contador () {
    DateTime now;
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      now = DateTime.now();
      setState(() {
        _time = "${now.hour}:${now.minute}:${now.second}";
      });
    });
  }

  // este solo se ejecuta cuando el widget ya no se ve
  @override
 void dispose() {
  _timer.cancel();
  super.dispose();
 }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("$_time", style: TextStyle(fontSize: 20.0),),
    );
  }
  
}