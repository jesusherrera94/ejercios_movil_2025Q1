import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import '../adapters/local_storage.dart';
import '../adapters/dio_adapter.dart';
import '../adapters/http_adapter.dart';

class Login extends StatefulWidget {

  @override
  State<Login> createState() => _Login();
  
}

class _Login extends State<Login> {

  bool _hasLoaded = false;

  // instancia
  LocalStorage _localStorage = LocalStorage();
  DioAdapter _dioAdapter = DioAdapter();
  HttpAdapter _httpAdapter = HttpAdapter();

@override
void initState() {
    _validateLogin(context);
    super.initState();
  }


  Future<void> _validateLogin(BuildContext context) async {
    bool isAuthenticated = await _localStorage.getLoginStatus();
    dynamic dioResponse = await _dioAdapter.getRequest('https://official-joke-api.appspot.com/random_ten');
    dynamic httpResponse = await _httpAdapter.getRequest();
    List<dynamic> responseJson = convert.jsonDecode(httpResponse);
      
    print("================================> DIO ${responseJson[0]["type"]}");
    print("================================> HTTP ${httpResponse.runtimeType}");
    

    setState(() {
      _hasLoaded = true;
    });

    if (isAuthenticated) {
      Navigator.pushNamed(context, 'app-controller');
    }

  }


  void _goToAppController(BuildContext context) {
    _localStorage.setLoginStatus(true);
    Navigator.pushNamed(context, 'app-controller');
  }

  void _goToRegister(BuildContext context) {
    Navigator.pushNamed(context, 'register');
  }

  @override
  Widget build(BuildContext context) {

    if (!_hasLoaded) {
      return Container(child: Text("Cargando...."),);
    }

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
