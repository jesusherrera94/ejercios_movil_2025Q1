import 'dart:convert';
import 'package:flutter/material.dart';
import '../adapters/local_storage.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final LocalStorage _localStorage = LocalStorage();
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    String userData = await _localStorage.getUser();
    final Map<String, dynamic> userDataMap = jsonDecode(userData);
    setState(() {
      _userData = userDataMap;
    });
  }

  Future<void> _logOut(BuildContext context) async {
   await _localStorage.clearAll();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                if (_userData != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      _userData!['profilePicture'],
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                    'Name: ',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 2.0),
                  Text(
                    _userData!['fullname'],
                    style: TextStyle(
                      fontSize: 18.0,
                    )
                    )
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Username: ${_userData!['username']}',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Email: ${_userData!['email']}',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Gender: ${_userData!['gender']}',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Principal interest: ${_userData!['principalInterest']}',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[700],
                    ),
                  ),
                ] else ...[
                  CircularProgressIndicator(),
                ],
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _logOut(context);
                  },
                  child: const Text("Cerrar sesión"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}