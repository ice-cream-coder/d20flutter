import "package:flutter/material.dart";

class HorizontalItemScrollPhysics extends ScrollPhysics {
  final double itemWidth;

  const HorizontalItemScrollPhysics({required this.itemWidth, ScrollPhysics? parent}) : super(parent: parent);

  @override
  HorizontalItemScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return HorizontalItemScrollPhysics(itemWidth: itemWidth, parent: buildParent(ancestor));
  }

  double _getPage(ScrollMetrics position) {
    return position.pixels / itemWidth;
  }

  double _getPixels(double page) {
    return page * itemWidth;
  }

  double _getTargetPixels(ScrollMetrics position, Tolerance tolerance, double velocity) {
    double page = _getPage(position);
    if (velocity < -tolerance.velocity) {
      page -= 0.5;
    } else if (velocity > tolerance.velocity) {
      page += 0.5;
    }
    return _getPixels(page.roundToDouble());
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) || (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) return super.createBallisticSimulation(position, velocity);
    final Tolerance tolerance = this.tolerance;
    final double target = _getTargetPixels(position, tolerance, velocity).clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    );
    return ScrollSpringSimulation(spring, position.pixels, target, velocity, tolerance: tolerance);
  }
}
