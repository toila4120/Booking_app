import 'package:flutter/material.dart';

class Buttontime extends StatelessWidget {
  Buttontime({super.key, required this.time, required this.color1});
  final String time;
  final Color color1;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(time),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(color1),
      ),
    );
  }
}
