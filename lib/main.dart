// ignore_for_file: use_key_in_widget_constructors

import 'package:d20flutter_new/app_container.dart';
import "package:flutter/material.dart";
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    return WidgetsApp(
      builder: (BuildContext context, Widget? child) {
        return const AppContainer();
      },
      textStyle: const TextStyle(fontFamily: 'BasicSans', color: Colors.white),
      color: const Color(0xFFFFFFFF),
      debugShowCheckedModeBanner: false,
    );
  }
}
