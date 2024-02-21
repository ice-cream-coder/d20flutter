import 'package:flutter/material.dart';

enum CustomTheme {
  black,
  blue,
  green,
  yellow,
  brown,
  red,
  purple,
  pink,
  tan,
  olive,
  white,
}

extension ThemeExtension on CustomTheme {
  CustomTheme next() {
    switch (this) {
      case CustomTheme.black:
        return CustomTheme.blue;
      case CustomTheme.blue:
        return CustomTheme.green;
      case CustomTheme.green:
        return CustomTheme.yellow;
      case CustomTheme.yellow:
        return CustomTheme.brown;
      case CustomTheme.brown:
        return CustomTheme.red;
      case CustomTheme.red:
        return CustomTheme.purple;
      case CustomTheme.purple:
        return CustomTheme.pink;
      case CustomTheme.pink:
        return CustomTheme.tan;
      case CustomTheme.tan:
        return CustomTheme.olive;
      case CustomTheme.olive:
        return CustomTheme.white;
      case CustomTheme.white:
        return CustomTheme.black;
    }
  }

  Color get tintColor {
    switch (this) {
      case CustomTheme.black:
        return Colors.white;
      case CustomTheme.blue:
        return const Color.fromRGBO(242, 116, 94, 1);
      case CustomTheme.green:
        return const Color.fromRGBO(191, 164, 193, 1);
      case CustomTheme.yellow:
        return const Color.fromRGBO(70, 106, 122, 1);
      case CustomTheme.brown:
        return const Color.fromRGBO(77, 77, 38, 1);
      case CustomTheme.red:
        return const Color.fromRGBO(188, 218, 54, 1);
      case CustomTheme.purple:
        return const Color.fromRGBO(231, 82, 92, 1);
      case CustomTheme.pink:
        return const Color.fromRGBO(6, 122, 53, 1);
      case CustomTheme.tan:
        return const Color.fromRGBO(9, 6, 214, 1);
      case CustomTheme.olive:
        return const Color.fromRGBO(164, 132, 61, 1);
      case CustomTheme.white:
        return Colors.black;
      default:
        return Colors.transparent;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case CustomTheme.black:
        return Colors.black;
      case CustomTheme.blue:
        return const Color.fromRGBO(16, 67, 156, 1);
      case CustomTheme.green:
        return const Color.fromRGBO(63, 81, 37, 1);
      case CustomTheme.yellow:
        return const Color.fromRGBO(185, 159, 43, 1);
      case CustomTheme.brown:
        return const Color.fromRGBO(198, 136, 111, 1);
      case CustomTheme.red:
        return const Color.fromRGBO(204, 77, 35, 1);
      case CustomTheme.purple:
        return const Color.fromRGBO(77, 1, 148, 1);
      case CustomTheme.pink:
        return const Color.fromRGBO(238, 197, 203, 1);
      case CustomTheme.tan:
        return const Color.fromRGBO(227, 203, 187, 1);
      case CustomTheme.olive:
        return const Color.fromRGBO(49, 59, 48, 1);
      case CustomTheme.white:
        return Colors.white;
      default:
        return Colors.transparent;
    }
  }
}
