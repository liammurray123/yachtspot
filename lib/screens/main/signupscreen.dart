import 'package:flutter/material.dart';
import 'package:yachtspot/constants.dart';

// Firebase Imports
import 'package:firebase_auth/firebase_auth.dart';

// Widget Imports
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:yachtspot/widgets/welcomebutton.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                        label: 'Register',
                        color: kRedColor,
                        onPressed: () async {
                          try {
                            setState(() {
                              showSpinner = true;
                            });
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email, password: password);
                            if (newUser != null) {
                              Navigator.pushNamed(context, '/onboarding');
                            }
                          } catch (e) {
                            setState(() {
                              showSpinner = false;
                              Navigator.pop(context);
                            });
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
