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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDxRmAjGKvuYDvXHA64Aiqpp_UkPm3kOo8',
    appId: '1:367018665293:android:3d74ed01cbecfa2adb4304',
    messagingSenderId: '367018665293',
    projectId: 'health-studio-5f0b9',
    storageBucket: 'health-studio-5f0b9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAJvnYvDbvZNzbq7mA_C-mHXM8PAb9Fylc',
    appId: '1:367018665293:ios:1f08038d81b7178cdb4304',
    messagingSenderId: '367018665293',
    projectId: 'health-studio-5f0b9',
    storageBucket: 'health-studio-5f0b9.appspot.com',
    androidClientId: '367018665293-q9qp7r9e2a5i8nl45kglabgn2j5tjoh9.apps.googleusercontent.com',
    iosClientId: '367018665293-f67l8pslcogk2sncsmh3dbg9c2fcf2ol.apps.googleusercontent.com',
    iosBundleId: 'com.example.healthStudioUser',
  );
}