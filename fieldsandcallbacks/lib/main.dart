import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'screens/tab_controller.dart';
import 'screens/login.dart';
import 'screens/third_screen.dart';
import 'screens/bottom_navbar.dart';
import 'screens/register.dart';
import 'screens/search_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: 'init',
      routes: {
        // "home" <- no se puede utilizar
        "init": (context) => Login(),
        // "app-controller": (context) => MyTabController(),
        "app-controller": (context) => MyBottomNavigationBar(),
        "third-screen": (context) => ThirdScreen(),
        "register": (context) => Register(),
        "search": (context) => SearchScreen(),
      },
    );
  }
}

