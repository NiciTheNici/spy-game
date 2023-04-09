import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardState extends StatefulWidget {
  const CardState({super.key});

  @override
  State<CardState> createState() => _CardState();
}

Color color = Color(0xFFFFE306);

class _CardState extends State<CardState> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => setState(() {
              color = color.withGreen(color.green + 5);
            }),
        child: Container(color: color));
  }
}
