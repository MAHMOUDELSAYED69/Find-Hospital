import 'package:find_hospital/view/screen/find_hospital_screen.dart';
import 'package:find_hospital/view/screen/hospital_details.dart';
import 'package:find_hospital/view/screen/splash.dart';
import 'package:flutter/material.dart';

import '../constant/routes.dart';
import 'page_transition.dart';

abstract class AppRouter {
  AppRouter._();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteManager.splash:
        return PageTransitionManager.fadeTransition(const SplashScreen());
      case RouteManager.home:
        return PageTransitionManager.fadeTransition(const FindHospitalScreen());
      case RouteManager.details:
        return PageTransitionManager.slideTransition(
            const HospitalDetailScreen());

      default:
        return null;
    }
  }
}
