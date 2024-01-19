import 'package:d20flutter_new/custom_theme.dart';
import 'package:d20flutter_new/settings.dart';
import 'package:flutter/material.dart';

class HeaderRow extends StatefulWidget {
  const HeaderRow({super.key});

  @override
  State<HeaderRow> createState() => _HeaderRowState();
}

class _HeaderRowState extends State<HeaderRow> {
  var _showSettings = false;

  @override
  void initState() {
    _showSettings = Settings.showSettings;
    super.initState();
  }

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
                  icon: Image.asset(
                    'images/gear.png',
                    color: Theme.of(context).primaryColor,
                  ),
                )),
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
                        icon: Image.asset(
                          'images/stats.png',
                          color: Theme.of(context).primaryColor,
                        ))),
                const SizedBox(width: 8),
                SizedBox(
                    width: 44,
                    height: 44,
                    child: IconButton(
                        onPressed: _colorPressed,
                        icon: Image.asset(
                          'images/color.png',
                          color: Theme.of(context).primaryColor,
                        ))),
              ],
            )
        ],
      ),
    );
  }

  void _gearPressed() {
    setState(() {
      _showSettings = !_showSettings;
      Settings.showHistory = _showSettings;
    });
  }

  void _statsPressed() {}

  void _colorPressed() {
    Settings.customTheme = Settings.customTheme.toggle();
  }
}
