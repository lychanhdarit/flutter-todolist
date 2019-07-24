import 'package:flutter/material.dart';

class CustomBotton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final Color borderColor;

  const CustomBotton(
      {Key key,
      this.buttonText,
      this.onPressed,
      this.color,
      this.textColor,
      this.borderColor = Colors.transparent})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(buttonText),
      color: color,
      textColor: textColor,
      padding: const EdgeInsets.all(14),
      shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(12)),
    );
  }
}
