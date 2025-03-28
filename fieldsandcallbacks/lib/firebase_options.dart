// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAiETSaeVYHvjAi07amrRCMBiK99e3gcsA',
    appId: '1:825327376585:web:85f8f516e35f9b9c1bd518',
    messagingSenderId: '825327376585',
    projectId: 'guitars-eae79',
    authDomain: 'guitars-eae79.firebaseapp.com',
    storageBucket: 'guitars-eae79.firebasestorage.app',
    measurementId: 'G-05FDEHJCYP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAXpeu0rBLPy-NqG947grZr-UB82ymm95M',
    appId: '1:825327376585:android:284ed6e4b37460271bd518',
    messagingSenderId: '825327376585',
    projectId: 'guitars-eae79',
    storageBucket: 'guitars-eae79.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAj7wtow9ySktb-zrfz9lxPn8Iv8rnEx6E',
    appId: '1:825327376585:ios:f1e787bce6b581231bd518',
    messagingSenderId: '825327376585',
    projectId: 'guitars-eae79',
    storageBucket: 'guitars-eae79.firebasestorage.app',
    iosBundleId: 'com.jesus.guitarapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAj7wtow9ySktb-zrfz9lxPn8Iv8rnEx6E',
    appId: '1:825327376585:ios:f1e787bce6b581231bd518',
    messagingSenderId: '825327376585',
    projectId: 'guitars-eae79',
    storageBucket: 'guitars-eae79.firebasestorage.app',
    iosBundleId: 'com.jesus.guitarapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAiETSaeVYHvjAi07amrRCMBiK99e3gcsA',
    appId: '1:825327376585:web:f6ef65b1b27453931bd518',
    messagingSenderId: '825327376585',
    projectId: 'guitars-eae79',
    authDomain: 'guitars-eae79.firebaseapp.com',
    storageBucket: 'guitars-eae79.firebasestorage.app',
    measurementId: 'G-K72G7KGYQK',
  );

}