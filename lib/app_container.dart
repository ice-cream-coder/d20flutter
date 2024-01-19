import "package:flutter/material.dart";
import 'main_widget.dart';

class AppContainer extends StatelessWidget {
  const AppContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: MainWidget());
  }
}
