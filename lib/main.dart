import 'package:d20flutter_new/app_container.dart';
import 'package:d20flutter_new/custom_theme.dart';
import 'package:d20flutter_new/settings.dart';
import "package:flutter/material.dart";
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Settings.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    return ValueListenableBuilder(
      valueListenable: Settings.themeNotifier,
      builder: (context, currentTheme, child) {
        return Container(
          color: currentTheme.backgroundColor,
          child: Theme(
            data: ThemeData(primaryColor: currentTheme.tintColor),
            child: WidgetsApp(
              textStyle: TextStyle(
                  fontFamily: 'BasicSans', color: currentTheme.tintColor),
              color: currentTheme.tintColor,
              debugShowCheckedModeBanner: false,
              builder: (BuildContext context, Widget? child) {
                return const AppContainer();
              },
            ),
          ),
        );
      },
    );
  }
}
