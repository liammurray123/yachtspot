import 'package:flutter/material.dart';
import 'package:yachtspot/constants.dart';

// Firebase Imports

// Widget Imports
import 'package:yachtspot/widgets/welcomebutton.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kRedColor,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/welcome-background-image.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  'Y.',
                  style: kLogoStyle,
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 80),
                child: Column(
                  children: [
                    WelcomeButton(
                      label: 'Sign In',
                      color: kDarkRedColor,
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                    ),
                    WelcomeButton(
                      label: 'Create an account',
                      color: kLightBlueColor,
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
