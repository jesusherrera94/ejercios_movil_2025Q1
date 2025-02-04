import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

class Contador extends StatefulWidget {

  @override
  State<Contador> createState() => _ContadorState();

}


class _ContadorState extends State<Contador> with WidgetsBindingObserver {
  // state
  int _counterState = 0;

  // controlador
  late Timer _timer;

  @override
  void initState () {
    _contador();
    // agrego esto para que se puedan leer cuando el usuario se sale del app
    WidgetsBinding.instance.addObserver(this);
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
  // se remueve cuando el usuario cierra el app
  WidgetsBinding.instance.removeObserver(this);
  super.dispose();
 }

@override
 void didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state) {
      case AppLifecycleState.paused:
      print( '===========================================> Lost focus');
      _timer.cancel(); // se fuerza a detener el contador
      break;
      case AppLifecycleState.resumed:
      print("====================================> back");
      _contador(); // vuelvo a llamar la funcion para reiniciar el contador
      break;
      default:
      print("default");

    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("$_counterState"),
    );
  }
  
}