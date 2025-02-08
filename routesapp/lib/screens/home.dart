import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

void _goToAppController(BuildContext context) {
    Navigator.pushNamed(context, 'third-screen');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: ElevatedButton(
            onPressed: () { _goToAppController(context); },
            child: const Text("go to third screen")),
        ),
      );
  }
  
}