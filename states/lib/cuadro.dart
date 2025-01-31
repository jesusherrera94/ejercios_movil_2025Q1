import 'package:flutter/material.dart';


class Cuadro extends StatelessWidget {
  const Cuadro({super.key});

 @override
  Widget build(BuildContext context) {
    return Container(
    decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(5.0)
        ),
    width: 100.0,
    height: 100.0,
    child: Center(
            child: Text("Hello World!", style: TextStyle(color: Colors.white),),
        ),
  );
  }
}