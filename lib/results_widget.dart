import 'package:flutter/material.dart';
import 'model/roll_model.dart';
import 'result_layout_delegate.dart';

class ResultsWidget extends StatelessWidget {
  const ResultsWidget({
    super.key,
    required this.roll,
    required Animation<double> boom,
  }) : _boom = boom;

  final RollModel roll;
  final Animation<double> _boom;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomMultiChildLayout(
        delegate: ResultLayoutDelegate(),
        children: <Widget>[
          LayoutId(
            id: ResultLayoutKeys.roll,
            child: Text(roll.render(),
                style: const TextStyle(
                  fontSize: 38,
                )),
          ),
          LayoutId(
              id: ResultLayoutKeys.result,
              child: ScaleTransition(
                  scale: _boom,
                  child: Text(
                    roll.result(),
                    style: const TextStyle(
                      fontSize: 132,
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
        ],
      ),
    );
  }
}
