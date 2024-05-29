import 'package:flutter/material.dart';

import 'view/screen/find_hospital_screen.dart';
import 'view/screen/hospital_details.dart';
import 'view/screen/splash.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Find Hospital',
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
        "/findHospital": (context) => const FindHospitalScreen(),
        "/hospitalDetails": (context) => const HospitalDetailScreen(),
      },
    );
  }
}
