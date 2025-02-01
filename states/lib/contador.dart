import 'package:flutter/material.dart';
import 'dart:async';

class Contador extends StatefulWidget {

  @override
  State<Contador> createState() => _ContadorState();

}


class _ContadorState extends State<Contador> {
  // state
  int _counterState = 0;

  // controlador
  late Timer _timer;

  @override
  void initState () {
    _contador();
    super.initState();
  }

  void _contador () {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (_counterState <= 0 ) {
         setState(() {
          _counterState = 10;
         });
        
      } else {
         setState(() {
          _counterState--;
         });
      }
      // opcion 2
      // setState(() {});
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
      child: Text("$_counterState"),
    );
  }
  
}