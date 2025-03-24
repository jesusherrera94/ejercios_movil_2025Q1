import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import '../adapters/local_storage.dart';
import '../adapters/dio_adapter.dart';
import '../adapters/http_adapter.dart';
import 'package:http/http.dart' as http;
import '../adapters/auth.dart';
import '../adapters/db.dart';
import '../models/user.dart';


class Login extends StatefulWidget {
  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  bool _hasLoaded = false;

  // User data
  late String _email;
  late String _password;
  String _error = '';

  // instancia
  LocalStorage _localStorage = LocalStorage();
  DioAdapter _dioAdapter = DioAdapter();
  HttpAdapter _httpAdapter = HttpAdapter(client: http.Client());
  Db _db = Db();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _validateLogin(context);
    super.initState();
  }

  Future<void> _validateLogin(BuildContext context) async {
    bool isAuthenticated = await _localStorage.getLoginStatus();
    dynamic dioResponse = await _dioAdapter
        .getRequest('https://official-joke-api.appspot.com/random_ten');
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

  void _login(BuildContext context) async  {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        dynamic response = await Auth.signInWithEmailAndPassword(_email, _password);
        if (response == null || response.user == null) {
          setState(() {
            _error = 'Invalid email or password';
          });
          return;
        }
        print(response.user.uid);

        Map<String, dynamic>? userData = await _db.getUserData(response.user.uid);
        if (userData == null) {
          setState(() {
            _error = 'User not found';
          });
          return;
        }
        User user = User.fromFirebaseMap(userData);
        await _localStorage.setUser(user.toStringMap());
        setState(() {
          _error = '';
        });
        await _localStorage.setLoginStatus(true);
        _goToAppController(context);
      } catch (e) {
        
        if(e.toString().contains('The supplied auth credential is incorrec')) {
          setState(() {
            _error = 'Invalid email or password';
          });
          return;
        }
        setState(() {
          _error = 'An unknown error occurred';
        });
        print(e);

      }
    }
  }

  void _goToAppController(BuildContext context) {
    Navigator.pushNamed(context, 'app-controller');
  }

  void _goToRegister(BuildContext context) {
    Navigator.pushNamed(context, 'register');
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasLoaded) {
      return Container(
        child: Text("Cargando...."),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Iniciar sesion"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Login', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
              TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    onSaved: (value) => _email = value!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    onSaved: (value) => _password = value!,
                  ),
                  if (_error.isNotEmpty) ...[
                    SizedBox(height: 10),
                    Text(_error, style: TextStyle(color: Colors.red)),
                  ],
                  SizedBox(height: 10),
              Container(
                child: Center(
                  child: ElevatedButton(
                      onPressed: () {
                        _login(context);
                      },
                      child: const Text("Login")),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  _goToRegister(context);
                },
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: const Text("Register"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
