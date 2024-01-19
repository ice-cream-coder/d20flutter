import 'package:flutter/material.dart';

class SideScrollHandle extends StatelessWidget {
  const SideScrollHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: 4,
        height: 30,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(2)),
      ),
    );
  }
}
