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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDRZOFc8Iq55DefHB1gmQD05N5FkNFZkSI',
    appId: '1:305757418974:web:f24b2e40c07c01f67e194f',
    messagingSenderId: '305757418974',
    projectId: 'icu-app1',
    authDomain: 'icu-app1.firebaseapp.com',
    databaseURL: 'https://icu-app1-default-rtdb.firebaseio.com/',
    storageBucket: 'icu-app1.appspot.com',
    measurementId: 'G-41C214KJ6D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCEvTraVWx7tNeCiUS8_PovxRlRIPS12b4',
    appId: '1:305757418974:android:83cc1859795108167e194f',
    messagingSenderId: '305757418974',
    projectId: 'icu-app1',
    databaseURL: 'https://icu-app1-default-rtdb.firebaseio.com',
    storageBucket: 'icu-app1.appspot.com',
  );
}
