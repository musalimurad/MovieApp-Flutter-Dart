import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/screens/Home_screen.dart';
import 'package:movieapp/style/theme.dart' as Style;
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      home: const SplashScreen(),

      
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
          // ignore: unnecessary_new
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              child: Image.asset(
                "assets/images/logo.jpg",
                fit: BoxFit.cover,
                width: 200,
                height: 200,
              ),
            ),
          ]),
      backgroundColor: Style.Colors.mainColor,
      splashIconSize: 300.0,
      pageTransitionType: PageTransitionType.rightToLeftWithFade,
      splashTransition: SplashTransition.decoratedBoxTransition,
      centered: true,
      duration: 2000,
      nextScreen: const HomeScreen(),
    );
  }
}
