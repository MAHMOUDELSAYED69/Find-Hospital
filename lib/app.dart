import 'package:find_hospital/core/constant/routes.dart';
import 'package:find_hospital/core/router/app_router.dart';
import 'package:flutter/material.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Find Hospital',
      initialRoute: RouteManager.splash,
     onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
