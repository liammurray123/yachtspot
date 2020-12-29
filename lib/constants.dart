import 'package:flutter/material.dart';

const kRedColor = Color(0xffF86D5C);
const kDarkRedColor = Color(0xffE85C4B);
const kBlueColor = Color(0xFF05293C);
const kLightBlueColor = Color(0xff09354B);

const kLogoStyle = TextStyle(
  fontFamily: 'Hind',
  fontSize: 60,
  fontWeight: FontWeight.w700,
  color: Colors.white,
);

const kWelcomeButtonLabelStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);

const ktopWelcomeTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w400,
  fontSize: 34,
  color: kBlueColor,
);
const kbottomWelcomeTextStyle = TextStyle(
  height: .7,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w600,
  fontSize: 34,
  color: kBlueColor,
);

const kOnboardingSubtitleStyle = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w300,
  fontSize: 16,
  color: kBlueColor,
);
const kTextFieldStyle = InputDecoration(
  hintText: 'Enter Value',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: kRedColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
