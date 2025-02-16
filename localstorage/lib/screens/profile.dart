import 'package:flutter/material.dart';
import '../adapters/local_storage.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final LocalStorage _localStorage = LocalStorage();

  Future<void> _logOut(BuildContext context) async {
    await _localStorage.setLoginStatus(false);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Card(
          child: Container(
            child: Center(
              child: ElevatedButton(onPressed: () {
                  _logOut(context);
              }, child: const Text("Cerrar sesión")),
            ),
          ),
        ),
      ),
    );
  }
  
}