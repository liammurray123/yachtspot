import 'package:flutter/material.dart';
import 'package:yachtspot/constants.dart';

class WelcomeButton extends StatelessWidget {
  WelcomeButton({this.label, this.color, this.onPressed});
  final String label;
  final Color color;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: color,
          ),
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Text(
              label,
              style: kWelcomeButtonLabelStyle,
            ),
          ),
        ),
      ),
    );
  }
}
