import 'package:flutter/material.dart';

class Buttonreservar extends StatelessWidget {
  final Function()? onTap;
  // final String text;
  final Color buttonColor;
  const Buttonreservar(
      {super.key, required this.onTap, required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, right: 35, left: 35),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: buttonColor,
        ),
        child: Center(
          child: Text(
            "Reservar >",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
