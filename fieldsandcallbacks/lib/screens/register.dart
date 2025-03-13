import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../adapters/dio_adapter.dart';
import '../adapters/local_storage.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../adapters/auth.dart';

class Register extends StatefulWidget {

  @override
  State<Register> createState() => _Register();
  
}

class _Register extends State<Register> with SingleTickerProviderStateMixin{

  late AnimationController _animationController;
  late Animation<double> _animation;
  LocalStorage _localStorage = LocalStorage();

  // form key
  final _formKey = GlobalKey<FormState>();

  // User data
  final _user = User(
    username: '',
    fullname: '',
    email: '',
    password: '',
    gender: 'Male', // Default gender
    principalInterest: '',
  );


  final List<String> _interests = [
    'Instruments',
   'Effects',
     'Software',
  'Tools',
   'Reading',
  ];

  @override
  void initState() {
    super.initState();
    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    // Start animation
    _animationController.forward();
  }

   @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Callback function for gender selection
  void _onGenderSelected(String? value) {
    setState(() {
      _user.gender = value!;
    });
  }

  // Callback function for interest selection
  void _onInterestSelected(dynamic value) {
    setState(() {
      _user.principalInterest = value as String;
    });
  }


  // Callback function for form submission
  void _onSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        dynamic authResponse = await Auth.createUserWithEmailAndPassword(_user.email, _user.password);
        _user.setUid(authResponse.user.uid);
        _user.setProfilePicture();
        dynamic response = await DioAdapter().postRequest('https://firestore.googleapis.com/v1/projects/guitars-eae79/databases/(default)/documents/users', _user.toFirestoreRestMap());
        User newUser = User.fromMap(response);
        // save user to shared preferences
        await _localStorage.setUser(newUser.toStringMap());
        _displaySnackbar(context, 'User registered successfully'); 
      } catch (e) {
        print(e);
        _displaySnackbar(context, 'Error registering user');
      }
    }
  }



  void _displaySnackbar(BuildContext context, String message) {
    SnackBar snackBar = SnackBar(
      content: Text(message),
      // opcional!
      action: SnackBarAction(label: "Undo", onPressed: () {
      }),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushNamed(context, 'app-controller');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Registration'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FadeTransition(
            opacity: _animation, // Animation
            child: Form(
              key: _formKey, // Form key
              child: Column(
                children: [
                  // TextFields
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                    onSaved: (value) => _user.username = value!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Full Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                    onSaved: (value) => _user.fullname = value!,
                  ),
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
                    onSaved: (value) => _user.email = value!,
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
                    onSaved: (value) => _user.password = value!,
                  ),

                  // Radio buttons for gender selection
                  const SizedBox(height: 20),
                  const Text('Gender'),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Male',
                        groupValue: _user.gender,
                        onChanged: _onGenderSelected, // Callback function
                      ),
                      const Text('Male'),
                      Radio<String>(
                        value: 'Female',
                        groupValue: _user.gender,
                        onChanged: _onGenderSelected, // Callback function
                      ),
                      const Text('Female'),
                      Radio<String>(
                        value: 'Other',
                        groupValue: _user.gender,
                        onChanged: _onGenderSelected, // Callback function
                      ),
                      const Text('Other'),
                    ],
                  ),

                  // Searchable dropdown for interests
                  const SizedBox(height: 20),
                   DropdownSearch<String>(
                    mode: Mode.form,
                    items: (f, cs) => _interests, // Interests list
                    onChanged: (String? value) =>
                        _user.principalInterest = value!,
                    selectedItem: _user.principalInterest,
                    popupProps: PopupProps.menu(
                      title: const Text('Select your principal interest'),
                      showSelectedItems: true,
                      showSearchBox: true
                    ),
                  ),

                  // Submit button
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: (){
                      _onSubmit(context);
                      }, // Callback function
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  
}