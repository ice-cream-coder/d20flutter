import "package:d20flutter_new/dice_row.dart";
import "package:d20flutter_new/results_widget.dart";
import "package:flutter/material.dart";
import "roll.dart";

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  Roll roll = EmptyRoll();
  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  late final Animation<double> _boom = _controller.drive(Tween<double>(begin: 1.3, end: 1));

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ResultsWidget(roll: roll, boom: _boom),
        DiceRow(createOnChangeCallback: createOnChangeCallback, onRoll: onRoll, rollOneMore: rollOneMore)
      ],
    );
  }

  Function createOnChangeCallback(int sides) {
    return (int count) {
      setState(() {
        roll = Roll(count, sides);
      });
    };
  }

  void onRoll() {
    setState(() {
      roll.roll();
      _controller.reset();
      _controller.forward();
    });
  }

  void rollOneMore() {
    setState(() {
      roll.oneMore();
    });
  }
}