import 'package:flutter/material.dart';

enum Theme {
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

extension ThemeExtension on Theme {
  Theme toggle() {
    switch (this) {
      case Theme.black:
        return Theme.blue;
      case Theme.blue:
        return Theme.green;
      case Theme.green:
        return Theme.yellow;
      case Theme.yellow:
        return Theme.brown;
      case Theme.brown:
        return Theme.red;
      case Theme.red:
        return Theme.purple;
      case Theme.purple:
        return Theme.pink;
      case Theme.pink:
        return Theme.tan;
      case Theme.tan:
        return Theme.olive;
      case Theme.olive:
        return Theme.white;
      case Theme.white:
        return Theme.black;
    }
  }

  Color get tintColor {
    switch (this) {
      case Theme.black:
        return Colors.white;
      case Theme.blue:
        return const Color.fromRGBO(242, 116, 94, 1);
      case Theme.green:
        return const Color.fromRGBO(191, 164, 193, 1);
      case Theme.yellow:
        return const Color.fromRGBO(70, 106, 122, 1);
      case Theme.brown:
        return const Color.fromRGBO(77, 77, 38, 1);
      case Theme.red:
        return const Color.fromRGBO(188, 218, 54, 1);
      case Theme.purple:
        return const Color.fromRGBO(231, 82, 92, 1);
      case Theme.pink:
        return const Color.fromRGBO(6, 122, 53, 1);
      case Theme.tan:
        return const Color.fromRGBO(9, 6, 214, 1);
      case Theme.olive:
        return const Color.fromRGBO(164, 132, 61, 1);
      case Theme.white:
        return Colors.black;
      default:
        return Colors.transparent;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case Theme.black:
        return Colors.black;
      case Theme.blue:
        return const Color.fromRGBO(16, 67, 156, 1);
      case Theme.green:
        return const Color.fromRGBO(63, 81, 37, 1);
      case Theme.yellow:
        return const Color.fromRGBO(185, 159, 43, 1);
      case Theme.brown:
        return const Color.fromRGBO(198, 136, 111, 1);
      case Theme.red:
        return const Color.fromRGBO(204, 77, 35, 1);
      case Theme.purple:
        return const Color.fromRGBO(77, 1, 148, 1);
      case Theme.pink:
        return const Color.fromRGBO(238, 197, 203, 1);
      case Theme.tan:
        return const Color.fromRGBO(227, 203, 187, 1);
      case Theme.olive:
        return const Color.fromRGBO(49, 59, 48, 1);
      case Theme.white:
        return Colors.white;
      default:
        return Colors.transparent;
    }
  }
}
