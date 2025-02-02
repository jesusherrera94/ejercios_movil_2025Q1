import 'package:flutter/material.dart';
import 'contador.dart';

class Cuadro extends StatelessWidget {
  const Cuadro({super.key});

 @override
  Widget build(BuildContext context) {
    return Container(
    decoration: BoxDecoration(
          color: const Color.fromARGB(255, 223, 222, 221),
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: const Color.fromARGB(255, 170, 168, 168), width: 2.0),
        ),
        width: 200.0,
    child: Center(
            child: Column(
              children: [
                Text("Tu hora local es:", style: TextStyle(fontSize: 20.0),),
                Contador(),
              ],
            ),
        ),
  );
  }
}