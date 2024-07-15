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
    apiKey: 'AIzaSyCA5S_wt7AsGTmLbQXyJ3PQHEw4pZBsZ6c',
    appId: '1:633061690863:web:0ce042e3c9d0ea6c21fa1a',
    messagingSenderId: '633061690863',
    projectId: 'metrogeniusapp',
    authDomain: 'metrogeniusapp.firebaseapp.com',
    storageBucket: 'metrogeniusapp.appspot.com',
    measurementId: 'G-7QKFLGJB98',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAsIebjWxKsswfOyBLFjwLWICqg-IA4ch4',
    appId: '1:633061690863:android:a3e89be668e402bb21fa1a',
    messagingSenderId: '633061690863',
    projectId: 'metrogeniusapp',
    storageBucket: 'metrogeniusapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBbHiIb8BishS3FO_85xM23BRDTSKqMEtQ',
    appId: '1:633061690863:ios:433780db9557d33721fa1a',
    messagingSenderId: '633061690863',
    projectId: 'metrogeniusapp',
    storageBucket: 'metrogeniusapp.appspot.com',
    iosBundleId: 'com.example.metrogeniusapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBbHiIb8BishS3FO_85xM23BRDTSKqMEtQ',
    appId: '1:633061690863:ios:433780db9557d33721fa1a',
    messagingSenderId: '633061690863',
    projectId: 'metrogeniusapp',
    storageBucket: 'metrogeniusapp.appspot.com',
    iosBundleId: 'com.example.metrogeniusapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCA5S_wt7AsGTmLbQXyJ3PQHEw4pZBsZ6c',
    appId: '1:633061690863:web:852e2445020f32ab21fa1a',
    messagingSenderId: '633061690863',
    projectId: 'metrogeniusapp',
    authDomain: 'metrogeniusapp.firebaseapp.com',
    storageBucket: 'metrogeniusapp.appspot.com',
    measurementId: 'G-L01YQ78EYC',
  );
}
