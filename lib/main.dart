import 'package:flutter/material.dart';
import 'package:yachtspot/screens/main/onboardingscreen.dart';

// Screen Imports
import 'package:yachtspot/screens/main/welcomescreen.dart';
import 'package:yachtspot/screens/main/loginscreen.dart';
import 'package:yachtspot/screens/main/homescreen.dart';
import 'package:yachtspot/screens/main/signupscreen.dart';
// Firebase Imports
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(Yachtspot());
}

class Yachtspot extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YachtSpot',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/welcome',
      routes: {
        '/onboarding': (context) => OnBoardingPage(),
        '/welcome': (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
