import 'package:flutter/material.dart';


class Login extends StatefulWidget {

  @override
  State<Login> createState() => _Login();
  
}

class _Login extends State<Login> {

  void _goToAppController(BuildContext context) {
    Navigator.pushNamed(context, 'app-controller');
  }

  void _goToRegister(BuildContext context) {
    Navigator.pushNamed(context, 'register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Iniciar sesion"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
        child: Center(
          child: ElevatedButton(
            onPressed: () { _goToAppController(context); },
            child: const Text("Iniciar sesión")),
        ),
      ),
      GestureDetector(
        onTap: () {
          _goToRegister(context);
        },
        child: Container(
          margin: EdgeInsets.all(20),
          child: const Text("Registrate aquí"),
        ),
      )
        ],
      )
    );
  }

  
}