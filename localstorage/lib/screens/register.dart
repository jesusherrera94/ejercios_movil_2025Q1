import 'package:flutter/material.dart';


class Register extends StatefulWidget {

  @override
  State<Register> createState() => _Register();
  
}

class _Register extends State<Register> {

  void _displaySnackbar(BuildContext context) {
    // Navigator.pushNamed(context, 'app-controller');
    SnackBar snackBar = SnackBar(
      content: const Text("Mi primer snackbar"),
      // opcional!
      action: SnackBarAction(label: "Undo", onPressed: () {
        print("==================> Undo action!!!!");
      }),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
            onPressed: () { _displaySnackbar(context); },
            child: const Text("Registra tu usuario")),
        ),
      ),
    );
  }

  
}