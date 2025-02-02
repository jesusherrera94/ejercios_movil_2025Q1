import 'package:flutter/material.dart';


class Cuadro extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return Container(
    decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: Center(
          child: Text("Hello World!", style: TextStyle(color: Colors.white),),
        ),
    width: 100.0,
    height: 100.0,
  );
  }
}

