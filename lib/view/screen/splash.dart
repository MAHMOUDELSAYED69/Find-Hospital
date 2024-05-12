import 'package:find_hospital/core/constant/animation.dart';
import 'package:find_hospital/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    //  goToNextScreen();
  }

  Future<void> goToNextScreen() async =>
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/home');
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(bottom: 50, child: Lottie.asset(LottieManager.location)),
          _buildTitleAndIcon(),
        ],
      ),
    ));
  }

  Widget _buildTitleAndIcon() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Find',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
          ),
        ),
        Text(
          ' Hospital',
          style: TextStyle(
            color: ColorManager.red,
            fontSize: 32,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(width: 10),
        Icon(Icons.healing, color: ColorManager.red, size: 32),
      ],
    );
  }
}
