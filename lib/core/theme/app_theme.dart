import 'package:find_hospital/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTheme {
  //!! LIGHT THEME
  static ThemeData get lightTheme {
    return ThemeData(
      iconTheme: const IconThemeData(color: ColorManager.black),
      fontFamily: 'Poppins',
      useMaterial3: true,
      brightness: Brightness.light,
      // primarySwatch: ColorManager.green ,
      scaffoldBackgroundColor: ColorManager.white,
      appBarTheme: AppBarTheme(
        color: ColorManager.red,
        iconTheme: const IconThemeData(color: ColorManager.black),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: ColorManager.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
            fontSize: 16.sp,
            color: ColorManager.black,
            fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(
          fontSize: 14.sp,
          color: ColorManager.black,
         fontWeight: FontWeight.w500
        ),
        bodySmall: TextStyle(
          fontSize: 12.spMin,
          color: ColorManager.black,
        ),
      ),
    );
  }
}
