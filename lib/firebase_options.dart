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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDT51g7C6GMjjrozmkdWM5vQISgvktLlGw',
    appId: '1:797827443462:android:467fba0d0f8337fe564c87',
    messagingSenderId: '797827443462',
    projectId: 'user-auth-using-flutter',
    storageBucket: 'user-auth-using-flutter.firebasestorage.app',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAk4Hgq1y8POkDmCHluNjIlXiENjfX0enU',
    appId: '1:797827443462:web:6ce32108042f45d3564c87',
    messagingSenderId: '797827443462',
    projectId: 'user-auth-using-flutter',
    authDomain: 'user-auth-using-flutter.firebaseapp.com',
    storageBucket: 'user-auth-using-flutter.firebasestorage.app',
    measurementId: 'G-J00C1BB7VW',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCqT1QPz9l1v_kbTMCg7m48vEMQ6GKLHqs',
    appId: '1:797827443462:ios:898f8a7f08ac8207564c87',
    messagingSenderId: '797827443462',
    projectId: 'user-auth-using-flutter',
    storageBucket: 'user-auth-using-flutter.firebasestorage.app',
    iosBundleId: 'io.ajinkyaghode.com.userAuthModule',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCqT1QPz9l1v_kbTMCg7m48vEMQ6GKLHqs',
    appId: '1:797827443462:ios:898f8a7f08ac8207564c87',
    messagingSenderId: '797827443462',
    projectId: 'user-auth-using-flutter',
    storageBucket: 'user-auth-using-flutter.firebasestorage.app',
    iosBundleId: 'io.ajinkyaghode.com.userAuthModule',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAk4Hgq1y8POkDmCHluNjIlXiENjfX0enU',
    appId: '1:797827443462:web:da4394eae31f73ea564c87',
    messagingSenderId: '797827443462',
    projectId: 'user-auth-using-flutter',
    authDomain: 'user-auth-using-flutter.firebaseapp.com',
    storageBucket: 'user-auth-using-flutter.firebasestorage.app',
    measurementId: 'G-3P1EKJ9LYZ',
  );

}