import 'package:d20flutter_new/horizontal_item_scroll_physics.dart';
import 'package:d20flutter_new/side_scroll_handle.dart';
import 'package:flutter/material.dart';
import 'dice_button.dart';

class DiceRow extends StatefulWidget {
  const DiceRow({super.key, required this.createOnChangeCallback, required this.onRoll, required this.rollOneMore});

  final Function createOnChangeCallback;
  final Function onRoll;
  final Function rollOneMore;

  @override
  State<DiceRow> createState() => _DiceRowState();
}

class _DiceRowState extends State<DiceRow> {
  final ScrollController _scrollController = ScrollController();
  bool _showLeftHandle = false;
  bool _showRightHandle = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateHandles);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateHandles);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 150,
          child: SingleChildScrollView(
            controller: _scrollController,
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
                  onChange: widget.createOnChangeCallback(4),
                  onRoll: widget.onRoll,
                  rollOneMore: widget.rollOneMore,
                ),
                DiceButton(
                  text: "D6",
                  imageId: "images/D6.png",
                  onChange: widget.createOnChangeCallback(6),
                  onRoll: widget.onRoll,
                  rollOneMore: widget.rollOneMore,
                ),
                DiceButton(
                  text: "D8",
                  imageId: "images/D8.png",
                  onChange: widget.createOnChangeCallback(8),
                  onRoll: widget.onRoll,
                  rollOneMore: widget.rollOneMore,
                ),
                DiceButton(
                  text: "D10",
                  imageId: "images/D10.png",
                  onChange: widget.createOnChangeCallback(10),
                  onRoll: widget.onRoll,
                  rollOneMore: widget.rollOneMore,
                ),
                DiceButton(
                  text: "D12",
                  imageId: "images/D12.png",
                  onChange: widget.createOnChangeCallback(12),
                  onRoll: widget.onRoll,
                  rollOneMore: widget.rollOneMore,
                ),
                DiceButton(
                  text: "D20",
                  imageId: "images/D20.png",
                  onChange: widget.createOnChangeCallback(20),
                  onRoll: widget.onRoll,
                  rollOneMore: widget.rollOneMore,
                ),
                DiceButton(
                  text: "D100",
                  imageId: "images/D100.png",
                  onChange: widget.createOnChangeCallback(100),
                  onRoll: widget.onRoll,
                  rollOneMore: widget.rollOneMore,
                ),
              ],
            ),
          )),
          Align(
            alignment: Alignment.centerLeft,
            child: AnimatedOpacity(
              opacity: _showLeftHandle ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: const SideScrollHandle()),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: AnimatedOpacity(
              opacity: _showRightHandle ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: const SideScrollHandle()),
          ),
      ]
    );
  }

  void _updateHandles() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    setState(() {
      _showLeftHandle = currentScroll > 0;
      _showRightHandle = currentScroll < maxScroll - 10;
    });
  }
}
