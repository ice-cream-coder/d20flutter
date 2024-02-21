import 'package:d20flutter_new/model/roll_model.dart';
import 'package:flutter/material.dart';

class HistoryWidget extends StatelessWidget {
  final List<RollModel> rollHistory;

  const HistoryWidget(this.rollHistory, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 300,
      decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor, width: 1)),
      child: ListView.builder(
          itemCount: rollHistory.length,
          itemBuilder: (context, index) {
            final isLast = index == rollHistory.length - 1;
            final roll = rollHistory[index];
            return Row(
              children: [
                HistoryCell(
                  text: roll.render(),
                  isLast: isLast,
                  textColor: Theme.of(context).backgroundColor,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                HistoryCell(
                  text: roll.result(),
                  isLast: isLast,
                  textColor: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).backgroundColor,
                ),
              ],
            );
          }),
    );
  }
}

class HistoryCell extends StatelessWidget {
  final String text;
  final bool isLast;
  final Color textColor;
  final Color backgroundColor;

  const HistoryCell({
    super.key,
    required this.text,
    required this.isLast,
    required this.textColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: backgroundColor,
        child: Column(
          children: [
            SizedBox(
              height: 32,
              child: Center(child: Text(text, style: TextStyle(fontSize: 16, color: textColor))),
            ),
            if (!isLast) Container(height: 1, color: textColor)
          ],
        ),
      ),
    );
  }
}
