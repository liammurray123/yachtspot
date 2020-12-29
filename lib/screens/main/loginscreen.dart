import 'package:flutter/material.dart';

import 'package:yachtspot/constants.dart';

// Firebase Imports
import 'package:firebase_auth/firebase_auth.dart';

// Widget Imports
import 'package:yachtspot/widgets/welcomebutton.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background-image.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ahoy', style: ktopWelcomeTextStyle),
                    Text('Matey', style: kbottomWelcomeTextStyle),
                  ],
                ),
                Container(
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: kTextFieldStyle.copyWith(
                          hintText: 'Enter your email',
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        obscureText: true,
                        onChanged: (value) {
                          password = value;
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: kTextFieldStyle.copyWith(
                          hintText: 'Enter a password',
                        ),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      WelcomeButton(
                        label: 'Log In',
                        color: kRedColor,
                        onPressed: () async {
                          try {
                            setState(() {
                              showSpinner = true;
                            });
                            final returningUser =
                                await _auth.signInWithEmailAndPassword(
                                    email: email, password: password);
                            if (returningUser != null) {
                              Navigator.pushNamed(context, '/home');
                            }
                          } catch (e) {
                            Navigator.pop(context);
                            print(e);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
