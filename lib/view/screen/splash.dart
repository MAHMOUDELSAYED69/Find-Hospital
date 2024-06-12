import 'package:find_hospital/core/constant/animation.dart';
import 'package:find_hospital/core/constant/color.dart';
import 'package:find_hospital/core/constant/routes.dart';
import 'package:find_hospital/core/helper/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    goToNextScreen();
  }

  Future<void> goToNextScreen() async =>
      Future.delayed(const Duration(milliseconds: 3300), () {
        Navigator.pushReplacementNamed(context, RouteManager.home);
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: context.width,
      height: context.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              bottom: 50.h,
              child: Lottie.asset(
                LottieManager.location,
              frameRate: const FrameRate(60)
              )),
          _buildTitleAndIcon(),
        ],
      ),
    ));
  }

  Widget _buildTitleAndIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Find',
          style: context.textTheme.bodyLarge?.copyWith(
            fontSize: 30.sp,
            fontStyle: FontStyle.italic,
          ),
        ),
        Text(
          ' Hospital',
          style: context.textTheme.bodyLarge?.copyWith(
            fontSize: 30.sp,
            fontStyle: FontStyle.italic,
            color: ColorManager.red,
          ),
        ),
        SizedBox(width: 10.w),
        Icon(Icons.healing, color: ColorManager.red, size: 30.sp),
      ],
    );
  }
}
