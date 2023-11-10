import 'package:flutter/material.dart';

class ResultLayoutDelegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    Size resultSize = Size.zero;
    if (hasChild(ResultLayoutKeys.result)) {
      resultSize = layoutChild(ResultLayoutKeys.result, BoxConstraints.loose(size));
      positionChild(ResultLayoutKeys.result, Offset(size.width / 2 - resultSize.width / 2, size.height / 2 - resultSize.height / 2));
    }

    if (hasChild(ResultLayoutKeys.roll)) {
      Size rollSize = layoutChild(ResultLayoutKeys.roll, BoxConstraints.loose(size));
      positionChild(ResultLayoutKeys.roll, Offset(size.width / 2 - rollSize.width / 2, size.height / 2 - rollSize.height / 2 - resultSize.height / 2 - 24));
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => false;
}

enum ResultLayoutKeys { roll, result }