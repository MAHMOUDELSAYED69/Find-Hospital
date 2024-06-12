import 'package:find_hospital/bloc/hospital/find_hospital_cubit.dart';
import 'package:find_hospital/core/constant/routes.dart';
import 'package:find_hospital/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => FindHospitalCubit(),
        child: Builder(
          builder: (_) => ScreenUtilInit(
              designSize: const Size(360, 690),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (_, child) => MaterialApp(
                    builder: (context, widget) {
                      final mediaQueryData = MediaQuery.of(context);
                      final scaledMediaQueryData = mediaQueryData.copyWith(
                        textScaler: TextScaler.noScaling,
                      );
                      return MediaQuery(
                        data: scaledMediaQueryData,
                        child: widget!,
                      );
                    },
                    theme: AppTheme.greenTheme,
                    debugShowCheckedModeBanner: false,
                    title: 'Find Hospital',
                    initialRoute: RouteManager.splash,
                    onGenerateRoute: AppRouter.onGenerateRoute,
                  )),
        ));
  }
}
