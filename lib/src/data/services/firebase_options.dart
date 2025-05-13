// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class DefaultFirebaseOptions {
//   static FirebaseOptions get currentPlatform {
//     if (kIsWeb) {
//       throw UnsupportedError(
//         'DefaultFirebaseOptions have not been configured for web - '
//         'you can reconfigure this by running the FlutterFire CLI again.',
//       );
//     }
//     switch (defaultTargetPlatform) {
//       case TargetPlatform.android:
//         return _androidOptions; // Retorna as opções de configuração para Android
//       case TargetPlatform.iOS:
//         return _iosOptions; // Retorna as opções de configuração para iOS
//       case TargetPlatform.macOS:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for macos - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       default:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions are not supported for this platform.',
//         );
//     }
//   }

//   // Configurações para Android
//   static const FirebaseOptions _androidOptions = FirebaseOptions(
//     apiKey: 'SUA-API-KEY',
//     appId: 'SUA-APP-ID',
//     messagingSenderId: 'SUA-MESSAGING-SENDER-ID',
//     projectId: 'SUA-PROJECT-ID',
//     databaseURL: 'SUA-DATABASE-URL',
//     storageBucket: 'SUA-STORAGE-BUCKET',
//   );

//   // Configurações para iOS
//   static const FirebaseOptions _iosOptions = FirebaseOptions(
//     apiKey: 'SUA-API-KEY',
//     appId: 'SUA-APP-ID',
//     messagingSenderId: 'SUA-MESSAGING-SENDER-ID',
//     projectId: 'SUA-PROJECT-ID',
//     databaseURL: 'SUA-DATABASE-URL',
//     storageBucket: 'SUA-STORAGE-BUCKET',
//     iosClientId: 'SUA-IOS-CLIENT-ID',
//     iosBundleId: 'com.seuapp.ios',
//   );
// }
