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
    apiKey: 'AIzaSyD_OWoj_xM3sPdb5UC6dOtT7yKBXyFlFn0',
    appId: '1:757697922331:web:c19b81433589f5e970bfbe',
    messagingSenderId: '757697922331',
    projectId: 'sustainable-farm-ad936',
    authDomain: 'sustainable-farm-ad936.firebaseapp.com',
    databaseURL: 'https://sustainable-farm-ad936-default-rtdb.firebaseio.com',
    storageBucket: 'sustainable-farm-ad936.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAdBdcCHdZy__qykiT0I5rHxMzHaRZCGHE',
    appId: '1:757697922331:android:eb342e258ed8fec070bfbe',
    messagingSenderId: '757697922331',
    projectId: 'sustainable-farm-ad936',
    databaseURL: 'https://sustainable-farm-ad936-default-rtdb.firebaseio.com',
    storageBucket: 'sustainable-farm-ad936.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC9engSL9bswY4hokaHUwy_xIxI_qMy3ZE',
    appId: '1:757697922331:ios:75d427507c8f0acf70bfbe',
    messagingSenderId: '757697922331',
    projectId: 'sustainable-farm-ad936',
    databaseURL: 'https://sustainable-farm-ad936-default-rtdb.firebaseio.com',
    storageBucket: 'sustainable-farm-ad936.appspot.com',
    iosClientId: '757697922331-7hq0tmeapk1s0kugluha4v7kh4646lna.apps.googleusercontent.com',
    iosBundleId: 'com.example.farmApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC9engSL9bswY4hokaHUwy_xIxI_qMy3ZE',
    appId: '1:757697922331:ios:75d427507c8f0acf70bfbe',
    messagingSenderId: '757697922331',
    projectId: 'sustainable-farm-ad936',
    databaseURL: 'https://sustainable-farm-ad936-default-rtdb.firebaseio.com',
    storageBucket: 'sustainable-farm-ad936.appspot.com',
    iosClientId: '757697922331-7hq0tmeapk1s0kugluha4v7kh4646lna.apps.googleusercontent.com',
    iosBundleId: 'com.example.farmApp',
  );
}