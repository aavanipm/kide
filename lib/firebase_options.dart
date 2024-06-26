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
    apiKey: 'AIzaSyAd7LFfHzMu0PoHp9t_zsvabJLGQKXePzo',
    appId: '1:831061918223:web:91769caace3a8f85eed97a',
    messagingSenderId: '831061918223',
    projectId: 'game-341ee',
    authDomain: 'game-341ee.firebaseapp.com',
    storageBucket: 'game-341ee.appspot.com',
    measurementId: 'G-5BNT6K50GW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAKoXgAPPPxMC1rJ0WwPEVGygYQM6e70-Q',
    appId: '1:831061918223:android:7ffc0528526385e5eed97a',
    messagingSenderId: '831061918223',
    projectId: 'game-341ee',
    storageBucket: 'game-341ee.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC9wU4o8m6knfPJl7GmOdXUotr03_Vp2fw',
    appId: '1:831061918223:ios:7baf6baac3e59f82eed97a',
    messagingSenderId: '831061918223',
    projectId: 'game-341ee',
    storageBucket: 'game-341ee.appspot.com',
    iosBundleId: 'com.example.game',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC9wU4o8m6knfPJl7GmOdXUotr03_Vp2fw',
    appId: '1:831061918223:ios:9a83127f6a2eb9edeed97a',
    messagingSenderId: '831061918223',
    projectId: 'game-341ee',
    storageBucket: 'game-341ee.appspot.com',
    iosBundleId: 'com.example.game.RunnerTests',
  );
}
