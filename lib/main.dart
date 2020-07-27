// Author : Sanchit Dang

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './app.dart';

void main() {
  //Lock Orientation to Potrait Only
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    debugPrint(
        "Locked Orientation to potrait only.\nNow launching application");
    runApp(new Application());
  });
}
