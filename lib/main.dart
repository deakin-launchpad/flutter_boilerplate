// Author : Sanchit Dang

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import './app.dart';

void main() {
  // Ensures that widgets are binded perfectly to the application.
  // Necessary for locking the orientation.
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    runApp(Application());
  } else {
    //Lock Orientation to Potrait Only
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      debugPrint(
          "Locked Orientation to potrait only.\nNow launching application");
      runApp(Application());
    });
  }
}
