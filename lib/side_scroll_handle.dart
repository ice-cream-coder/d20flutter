import 'package:flutter/material.dart';

class SideScrollHandle extends StatelessWidget {
  const SideScrollHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4, 
      height: 30,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7), 
        borderRadius: BorderRadius.circular(2)
      ),
    );
  }
}