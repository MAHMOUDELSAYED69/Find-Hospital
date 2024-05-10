import 'package:find_hospital/core/constant/animation.dart';
import 'package:find_hospital/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // goToNextScreen();
  }

  Future<void> goToNextScreen() async =>
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/home');
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Spacer(
          flex: 6,
        ),
        Text('Find Hospital', style: Theme.of(context).textTheme.titleLarge),
        const Spacer(flex: 5),
        Lottie.asset(LottieManager.loading),
      ],
    ));
  }
}
