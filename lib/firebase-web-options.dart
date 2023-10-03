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
class DefaultFirebaseOptionsB {
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
    apiKey: "AIzaSyCpybC6kzW2YvmzhCdu3uGhh9Cio55OKQ4",
    authDomain: "quizzcloud-873f9.firebaseapp.com",
    databaseURL: "https://quizzcloud-873f9-default-rtdb.firebaseio.com",
    projectId: "quizzcloud-873f9",
    storageBucket: "quizzcloud-873f9.appspot.com",
    messagingSenderId: "632924829441",
    appId: "1:632924829441:web:31d2f14a65b4e8e3a38d00",
    measurementId: "G-VVXKBB4XTM"
  );

  static const FirebaseOptions android = FirebaseOptions(
apiKey: "AIzaSyCpybC6kzW2YvmzhCdu3uGhh9Cio55OKQ4",
    authDomain: "quizzcloud-873f9.firebaseapp.com",
    databaseURL: "https://quizzcloud-873f9-default-rtdb.firebaseio.com",
    projectId: "quizzcloud-873f9",
    storageBucket: "quizzcloud-873f9.appspot.com",
    messagingSenderId: "632924829441",
    appId: "1:632924829441:web:31d2f14a65b4e8e3a38d00",
    measurementId: "G-VVXKBB4XTM"
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyCpybC6kzW2YvmzhCdu3uGhh9Cio55OKQ4",
    authDomain: "quizzcloud-873f9.firebaseapp.com",
    databaseURL: "https://quizzcloud-873f9-default-rtdb.firebaseio.com",
    projectId: "quizzcloud-873f9",
    storageBucket: "quizzcloud-873f9.appspot.com",
    messagingSenderId: "632924829441",
    appId: "1:632924829441:web:31d2f14a65b4e8e3a38d00",
    measurementId: "G-VVXKBB4XTM"
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: "AIzaSyCpybC6kzW2YvmzhCdu3uGhh9Cio55OKQ4",
    authDomain: "quizzcloud-873f9.firebaseapp.com",
    databaseURL: "https://quizzcloud-873f9-default-rtdb.firebaseio.com",
    projectId: "quizzcloud-873f9",
    storageBucket: "quizzcloud-873f9.appspot.com",
    messagingSenderId: "632924829441",
    appId: "1:632924829441:web:31d2f14a65b4e8e3a38d00",
    measurementId: "G-VVXKBB4XTM"
  );
}
