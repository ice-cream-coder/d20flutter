import "dart:math";

import "package:d20flutter_new/model/roll.dart";
import "package:d20flutter_new/model/roll_group.dart";
import "package:uuid/uuid.dart";

class RollModel {
  String id = const Uuid().v4();
  int count;
  final int sides;
  List<int> rolls = [];

  RollModel(this.count, this.sides);

  RollModel.copy(RollModel source)
      : count = source.count,
        sides = source.sides,
        rolls = [...source.rolls];

  String render() => count == 0 ? "" : "${count}d$sides";

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

  RollGroup toRollGroup() {
    return RollGroup(id: id);
  }

  List<Roll> toRolls() {
    return rolls.map((roll) => Roll(die: sides, side: roll, rollGroupId: id)).toList();
  }
}

class EmptyRollModel extends RollModel {
  EmptyRollModel() : super(0, 0);
}
