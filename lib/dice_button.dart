import "package:flutter/material.dart";
import "dart:math";

class DiceButton extends StatefulWidget {
  final String text;
  final String imageId;
  final Function onChange;
  final Function onRoll;
  final Function rollOneMore;

  const DiceButton({super.key, required this.text, required this.imageId, required this.onChange, required this.onRoll, required this.rollOneMore});

  @override
  State<DiceButton> createState() => _DiceButtonState();
}

class _DiceButtonState extends State<DiceButton> {
  double startOffsetY = 0;
  DateTime? lastTap;

  @override
  build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 6,
      child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTapDown: (result) {
            DateTime currentTap = DateTime.now();
            if (lastTap == null || currentTap.difference(lastTap!).inMilliseconds > 333) {
              widget.onChange(1);
            }
          },
          onTapUp: (result) {
            DateTime currentTap = DateTime.now();
            if (lastTap == null || currentTap.difference(lastTap!).inMilliseconds > 333) {
              widget.onChange(1);
              widget.onRoll();
            } else {
              widget.rollOneMore();
            }
            lastTap = currentTap;
          },
          onVerticalDragStart: (detail) {
            startOffsetY = detail.globalPosition.dy;
          },
          onVerticalDragUpdate: (details) {
            // RenderBox box = context.findRenderObject();
            // Offset offset = box.globalToLocal(details.globalPosition);
            widget.onChange(max(1, (startOffsetY - details.globalPosition.dy) ~/ 20));
            // widget.onChange(max(1, (-offset.dy + 40) ~/ 20));
          },
          onVerticalDragEnd: (details) {
            widget.onRoll();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 35,
                width: 35,
                child: Image.asset(widget.imageId),
              ),
              const SizedBox(
                height: 8,
                width: 0,
              ),
              Text(
                widget.text,
                style: const TextStyle(fontSize: 16),
              )
            ],
          )),
    );
  }
}
