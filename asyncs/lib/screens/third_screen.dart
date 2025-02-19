import 'package:flutter/material.dart';


class ThirdScreen extends StatefulWidget {

  @override
  State<ThirdScreen> createState() => _ThirdScreen();
  
}

class _ThirdScreen extends State<ThirdScreen> {

  void _goToAppController(BuildContext context) {
    Navigator.pushNamed(context, 'app-controller');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ThirdScreen"),
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
            onPressed: () { _goToAppController(context); },
            child: const Text("Go back")),
        ),
      ),
    );
  }

  
}