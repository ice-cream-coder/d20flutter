import 'package:flutter/material.dart';

class HeaderRow extends StatefulWidget {
  @override
  State<HeaderRow> createState() => _HeaderRowState();
}

class _HeaderRowState extends State<HeaderRow> {
  var _showSettings = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
                width: 44,
                height: 44,
                child: IconButton(
                    onPressed: _gearPressed,
                    icon: Image.asset('images/gear.png'))),
          ),
          if (_showSettings)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 44,
                    height: 44,
                    child: IconButton(
                        onPressed: _statsPressed,
                        icon: Image.asset('images/stats.png'))),
                const SizedBox(width: 8),
                SizedBox(
                    width: 44,
                    height: 44,
                    child: IconButton(
                        onPressed: _colorPressed,
                        icon: Image.asset('images/color.png'))),
              ],
            )
        ],
      ),
    );
  }

  void _gearPressed() {
    setState(() {
      _showSettings = !_showSettings;
    });
  }

  void _statsPressed() {}

  void _colorPressed() {}
}
