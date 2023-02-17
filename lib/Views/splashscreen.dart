import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:audio_adventure/Views/home.dart';
import 'package:flutter/material.dart';

import '../Consts/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedSplashScreen(
      splashIconSize: 160,
      splash: Image.asset(
        logo,
        width: 300,
        height: 300,
      ),
      nextScreen: const Home(),
      splashTransition: SplashTransition.rotationTransition,
      backgroundColor: bgDarkColor,
      duration: 2000,
      animationDuration: const Duration(seconds: 3),
    ));
  }
}
