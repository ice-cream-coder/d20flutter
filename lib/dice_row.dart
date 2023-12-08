import 'package:d20flutter_new/horizontal_item_scroll_physics.dart';
import 'package:flutter/material.dart';
import 'dice_button.dart';

class DiceRow extends StatelessWidget {
  const DiceRow({super.key, required this.createOnChangeCallback, required this.onRoll, required this.rollOneMore});

  final Function createOnChangeCallback;
  final Function onRoll;
  final Function rollOneMore;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: HorizontalItemScrollPhysics(
            itemWidth: MediaQuery.of(context).size.width / 6,
            parent: const PageScrollPhysics(),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              DiceButton(
                text: "D4",
                imageId: "images/D4.png",
                onChange: createOnChangeCallback(4),
                onRoll: onRoll,
                rollOneMore: rollOneMore,
              ),
              DiceButton(
                text: "D6",
                imageId: "images/D6.png",
                onChange: createOnChangeCallback(6),
                onRoll: onRoll,
                rollOneMore: rollOneMore,
              ),
              DiceButton(
                text: "D8",
                imageId: "images/D8.png",
                onChange: createOnChangeCallback(8),
                onRoll: onRoll,
                rollOneMore: rollOneMore,
              ),
              DiceButton(
                text: "D10",
                imageId: "images/D10.png",
                onChange: createOnChangeCallback(10),
                onRoll: onRoll,
                rollOneMore: rollOneMore,
              ),
              DiceButton(
                text: "D12",
                imageId: "images/D12.png",
                onChange: createOnChangeCallback(12),
                onRoll: onRoll,
                rollOneMore: rollOneMore,
              ),
              DiceButton(
                text: "D20",
                imageId: "images/D20.png",
                onChange: createOnChangeCallback(20),
                onRoll: onRoll,
                rollOneMore: rollOneMore,
              ),
              DiceButton(
                text: "D100",
                imageId: "images/D100.png",
                onChange: createOnChangeCallback(100),
                onRoll: onRoll,
                rollOneMore: rollOneMore,
              ),
            ],
          ),
        ));
  }
}
