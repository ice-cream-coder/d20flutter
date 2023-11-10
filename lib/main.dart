// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import "package:flutter/widgets.dart";
import "package:flutter/material.dart";
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'dart:math';

void main() {
  runApp(new App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    return new WidgetsApp(
      builder: (BuildContext context, Widget child) {
        return AppContainer();
      },
      textStyle: const TextStyle(fontFamily: 'BasicSans', color: Colors.white),
      color: Color(0xFF0000FF),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: SafeArea(child: MainWidget()));
  }
}

class MainWidget extends StatefulWidget {
  @override
  MainController createState() => MainController();
}

class MainController extends State<MainWidget> with TickerProviderStateMixin {
  Roll roll = EmptyRoll();
  AnimationController controller;
  Animation<double> boom;

  @override
  void initState() {
    super.initState();
    this.controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    this.controller.forward();
    this.boom = Tween<double>(begin: 1.3, end: 1).animate(this.controller);
  }

  @override
  Widget build(BuildContext context) {
    if (this.boom == null) {
      return Container();
    }
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
              child: CustomMultiChildLayout(
            delegate: ResultLayoutDelegate(),
            children: <Widget>[
              LayoutId(
                id: ResultLayoutKeys.roll,
                child: Text(Roll.render(this.roll),
                    style: TextStyle(
                      fontSize: 38,
                    )),
              ),
              LayoutId(
                  id: ResultLayoutKeys.result,
                  child: Transform.scale(
                    scale: 1,
                    child: AnimatedResult(
                      value: this.roll.result(),
                      listenable: this.boom,
                    ),
                  )),
            ],
          )),
        ),
        Container(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                DiceButton(
                  text: "D4",
                  imageId: "images/D4.png",
                  onChange: this.onChangeFactory(4),
                  onRoll: this.onRoll,
                  rollOneMore: this.rollOneMore,
                ),
                DiceButton(
                  text: "D6",
                  imageId: "images/D6.png",
                  onChange: this.onChangeFactory(6),
                  onRoll: this.onRoll,
                  rollOneMore: this.rollOneMore,
                ),
                DiceButton(
                  text: "D8",
                  imageId: "images/D8.png",
                  onChange: this.onChangeFactory(8),
                  onRoll: this.onRoll,
                  rollOneMore: this.rollOneMore,
                ),
                DiceButton(
                  text: "D10",
                  imageId: "images/D10.png",
                  onChange: this.onChangeFactory(10),
                  onRoll: this.onRoll,
                  rollOneMore: this.rollOneMore,
                ),
                DiceButton(
                  text: "D12",
                  imageId: "images/D12.png",
                  onChange: this.onChangeFactory(12),
                  onRoll: this.onRoll,
                  rollOneMore: this.rollOneMore,
                ),
                DiceButton(
                  text: "D20",
                  imageId: "images/D20.png",
                  onChange: this.onChangeFactory(20),
                  onRoll: this.onRoll,
                  rollOneMore: this.rollOneMore,
                ),
              ],
            ))
      ],
    );
  }

  Function onChangeFactory(int sides) {
    return (int count) {
      this.setState(() {
        this.roll = Roll(count, sides);
      });
    };
  }

  void onRoll() {
    this.setState(() {
      this.roll.roll();
      this.controller.reset();
      this.controller.forward();
    });
  }

  void rollOneMore() {
    this.setState(() {
      this.roll.oneMore();
    });
  }
}

class AnimatedResult extends AnimatedWidget {
  final String value;

  AnimatedResult({@required this.value, @required listenable})
      : super(listenable: listenable);

  @override
  Widget build(BuildContext context) {
    Animation animation = this.listenable as Animation;
    return Transform.scale(
      scale: animation.value,
      child: Text(
        this.value,
        style: TextStyle(
          fontSize: 132,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

enum ResultLayoutKeys { roll, result }

class DiceButton extends StatefulWidget {
  final String text;
  final String imageId;
  final Function onChange;
  final Function onRoll;
  final Function rollOneMore;

  DiceButton(
      {@required this.text,
      @required this.imageId,
      @required this.onChange,
      @required this.onRoll,
      @required this.rollOneMore});

  @override
  _DiceButtonState createState() => _DiceButtonState();
}

class _DiceButtonState extends State<DiceButton> {
  double startOffsetY = 0;
  DateTime lastTap;

  @override
  build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTapDown: (result) {
              DateTime currentTap = DateTime.now();
              if (lastTap == null ||
                  currentTap.difference(lastTap).inMilliseconds > 333) {
                widget.onChange(1);
              }
            },
            onTapUp: (result) {
              DateTime currentTap = DateTime.now();
              if (lastTap == null ||
                  currentTap.difference(lastTap).inMilliseconds > 333) {
                widget.onChange(1);
                widget.onRoll();
              } else {
                widget.rollOneMore();
              }
              lastTap = currentTap;
            },
            onVerticalDragStart: (detail) {
              this.startOffsetY = detail.globalPosition.dy;
            },
            onVerticalDragUpdate: (details) {
              RenderBox box = context.findRenderObject();
              Offset offset = box.globalToLocal(details.globalPosition);
              widget.onChange(max(
                  1, (this.startOffsetY - details.globalPosition.dy) ~/ 20));
              // widget.onChange(max(1, (-offset.dy + 40) ~/ 20));
            },
            onVerticalDragEnd: (details) {
              widget.onRoll();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    child: Image.asset(widget.imageId), height: 35, width: 35),
                SizedBox(
                  height: 8,
                  width: 0,
                ),
                Text(
                  widget.text,
                  style: TextStyle(fontSize: 16),
                )
              ],
            )));
  }
}

class ResultLayoutDelegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    Size resultSize = Size.zero;
    if (hasChild(ResultLayoutKeys.result)) {
      resultSize =
          layoutChild(ResultLayoutKeys.result, BoxConstraints.loose(size));
      positionChild(
          ResultLayoutKeys.result,
          Offset(size.width / 2 - resultSize.width / 2,
              size.height / 2 - resultSize.height / 2));
    }

    if (hasChild(ResultLayoutKeys.roll)) {
      Size rollSize =
          layoutChild(ResultLayoutKeys.roll, BoxConstraints.loose(size));
      positionChild(
          ResultLayoutKeys.roll,
          Offset(
              size.width / 2 - rollSize.width / 2,
              size.height / 2 -
                  rollSize.height / 2 -
                  resultSize.height / 2 -
                  24));
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => false;
}

class Roll {
  int count;
  final int sides;
  List<int> rolls = [];

  Roll(this.count, this.sides);

  String _render() => this.count == 0
      ? ""
      : this.count.toString() + "d" + this.sides.toString();

  static String render(Roll roll) => roll?._render() ?? "";

  void _roll() {
    rolls.add(Random().nextInt(this.sides) + 1);
  }

  void roll() {
    this.rolls = [];
    for (int i = 0; i < this.count; i++) {
      _roll();
    }
  }

  void oneMore() {
    this.count++;
    _roll();
  }

  String result() {
    if (this.rolls.length == 0) {
      return "--";
    }
    int sum = 0;
    for (int i = 0; i < this.rolls.length; i++) {
      sum += this.rolls[i];
    }
    return sum.toString();
  }
}

class EmptyRoll extends Roll {
  EmptyRoll() : super(0, 0);
}

class OverflowContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.0,
      height: 0.0,
      child: OverflowBox(
        alignment: Alignment.center,
        maxHeight: double.infinity,
        maxWidth: double.infinity,
        child: Container(
          width: 200.0,
          height: 200.0,
          child: Text("Hi! Hello",
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
              textScaleFactor: 2.0),
        ),
      ),
    );
  }
}
