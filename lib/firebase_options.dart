// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDgT441J3S6-Ci_fr8hs7UAh4KI8nh7FPU',
    appId: '1:611084270089:web:b3f639a90529536c6c96d8',
    messagingSenderId: '611084270089',
    projectId: 'dogwalkerapp-64ed7',
    authDomain: 'dogwalkerapp-64ed7.firebaseapp.com',
    storageBucket: 'dogwalkerapp-64ed7.appspot.com',
    measurementId: 'G-4HZ9E4F8YF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAVa40Q8Yr8fHSmfGpvaSQ-iJa3MprriIY',
    appId: '1:611084270089:android:93b9bf7532fc63146c96d8',
    messagingSenderId: '611084270089',
    projectId: 'dogwalkerapp-64ed7',
    storageBucket: 'dogwalkerapp-64ed7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDZnRCMEnpFFw4CEjVbbtfiAoHm8mnlk54',
    appId: '1:611084270089:ios:b22171a1ecf3e7eb6c96d8',
    messagingSenderId: '611084270089',
    projectId: 'dogwalkerapp-64ed7',
    storageBucket: 'dogwalkerapp-64ed7.appspot.com',
    androidClientId: '611084270089-u8j9tef7q4p0rt9bkb8bldr4aclkuffs.apps.googleusercontent.com',
    iosClientId: '611084270089-u8igbllugt0ro250l0baskot75kccgpq.apps.googleusercontent.com',
    iosBundleId: 'com.example.dogWalker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDZnRCMEnpFFw4CEjVbbtfiAoHm8mnlk54',
    appId: '1:611084270089:ios:b22171a1ecf3e7eb6c96d8',
    messagingSenderId: '611084270089',
    projectId: 'dogwalkerapp-64ed7',
    storageBucket: 'dogwalkerapp-64ed7.appspot.com',
    androidClientId: '611084270089-u8j9tef7q4p0rt9bkb8bldr4aclkuffs.apps.googleusercontent.com',
    iosClientId: '611084270089-u8igbllugt0ro250l0baskot75kccgpq.apps.googleusercontent.com',
    iosBundleId: 'com.example.dogWalker',
  );
}