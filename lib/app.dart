import 'package:find_hospital/bloc/hospital_cubit/find_hospital_cubit.dart';
import 'package:find_hospital/bloc/theme_cubit/theme_cubit.dart';
import 'package:find_hospital/utils/constant/routes.dart';
import 'package:find_hospital/utils/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'utils/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        BlocProvider(
          create: (context) => FindHospitalCubit(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        )
      ],
      child: Builder(
        builder: (_) => ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) => BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, state) {
                    return MaterialApp(
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
                      theme: state == ThemeState.red
                          ? AppTheme.redTheme
                          : AppTheme.greenTheme,
                      debugShowCheckedModeBanner: false,
                      title: 'Find Hospital',
                      initialRoute: RouteManager.splash,
                      onGenerateRoute: AppRouter.onGenerateRoute,
                    );
                  },
                )),
      ),
    );
  }
}
