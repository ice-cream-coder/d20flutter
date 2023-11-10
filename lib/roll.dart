import 'dart:math';

class Roll {
  int count;
  final int sides;
  List<int> rolls = [];

  Roll(this.count, this.sides);

  String _render() => count == 0 ? "" : "${count}d$sides";

  static String render(Roll roll) => roll._render();

  void _roll() {
    rolls.add(Random().nextInt(sides) + 1);
  }

  void roll() {
    rolls = [];
    for (int i = 0; i < count; i++) {
      _roll();
    }
  }

  void oneMore() {
    count++;
    _roll();
  }

  String result() {
    if (rolls.isEmpty) {
      return "--";
    }
    int sum = 0;
    for (int i = 0; i < rolls.length; i++) {
      sum += rolls[i];
    }
    return sum.toString();
  }
}

class EmptyRoll extends Roll {
  EmptyRoll() : super(0, 0);
}
