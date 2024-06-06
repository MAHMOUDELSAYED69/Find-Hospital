import 'package:find_hospital/bloc/hospital/find_hospital_cubit.dart';
import 'package:find_hospital/core/constant/routes.dart';
import 'package:find_hospital/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FindHospitalCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Find Hospital',
        initialRoute: RouteManager.splash,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
