import 'package:flutter/material.dart';
import 'package:yachtspot/constants.dart';

class NextPageButton extends StatelessWidget {
  NextPageButton({this.label, this.goTo, this.onPressed, this.customFunction});
  final String label;
  final String goTo;
  final bool customFunction;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: GestureDetector(
        onTap: customFunction
            ? onPressed
            : () {
                Navigator.pushNamed(context, goTo);
              },
        child: Container(
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
