import 'package:flutter/material.dart';

import 'view/screen/splash.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Find Hospital',
      home: SplashScreen(),
    );
  }
}
