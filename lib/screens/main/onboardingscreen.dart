import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

// Widget Imports
import 'package:introduction_screen/introduction_screen.dart';
import 'package:yachtspot/constants.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pushNamed(context, '/signup');
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Find",
          body: "Easily search for boat info and more",
          image: Icon(
            FeatherIcons.search,
            size: 200,
            color: kBlueColor,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Connect",
          body:
              "With contact info available, get in touch with other boaters around you",
          image: Icon(
            FeatherIcons.user,
            size: 200,
            color: kBlueColor,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "What now?",
          body: "Get started by signing up, and registering your boat",
          image: Icon(
            FeatherIcons.arrowRight,
            size: 200,
            color: kBlueColor,
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(FeatherIcons.arrowRight),
      done:
          const Text('Sign up', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeColor: kRedColor,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
