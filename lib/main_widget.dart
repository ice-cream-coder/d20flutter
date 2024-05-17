import 'package:d20flutter_new/history/history_widget.dart';
import 'package:d20flutter_new/model/database_helper.dart';
import "package:d20flutter_new/dice_row.dart";
import "package:d20flutter_new/header_row.dart";
import "package:d20flutter_new/results_widget.dart";
import "package:d20flutter_new/settings.dart";
import "package:flutter/material.dart";
import 'model/roll_model.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  RollModel roll = EmptyRollModel();
  List<RollModel> rollHistory = List.empty(growable: true);
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  late final Animation<double> _boom = _controller.drive(Tween<double>(begin: 1.3, end: 1));

  @override
  void initState() {
    super.initState();

    // Todo: load history
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Settings.showHistoryNotifier,
        builder: (context, showHistory, _) {
          return Column(
            children: <Widget>[
              const HeaderRow(),
              ResultsWidget(roll: roll, boom: _boom),
              if (showHistory) HistoryWidget(rollHistory),
              DiceRow(createOnChangeCallback: createOnChangeCallback, onRoll: onRoll, rollOneMore: rollOneMore)
            ],
          );
        });
  }

  Function createOnChangeCallback(int sides) {
    return (int count) {
      setState(() {
        roll = RollModel(count, sides);
      });
    };
  }

  void onRoll() {
    setState(() {
      roll.roll();
      _controller.reset();
      _controller.forward();

      final lastRoll = roll.rolls.last;

      rollHistory.insert(0, RollModel.copy(roll));
      // TODO: Add roll to database
      // DatabaseHelper.addRoll(???);
    });
  }

  void rollOneMore() {
    setState(() {
      roll.oneMore();
      rollHistory.first.oneMore();

      // Update roll group
    });
  }
}
