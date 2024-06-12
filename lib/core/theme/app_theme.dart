import 'package:find_hospital/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTheme {
  //!! RED THEME
  static ThemeData get redTheme {
    return ThemeData(
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: WidgetStatePropertyAll(3),
          backgroundColor: WidgetStatePropertyAll(ColorManager.red),
          splashFactory: InkRipple.splashFactory,
          foregroundColor: WidgetStatePropertyAll(ColorManager.white),
        ),
      ),
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
            fontWeight: FontWeight.w500),
        bodySmall: TextStyle(
          fontSize: 12.spMin,
          fontWeight: FontWeight.w500,
          color: ColorManager.black,
        ),
        displayLarge: TextStyle(
            fontSize: 16.sp,
            color: ColorManager.red,
            fontWeight: FontWeight.bold),
        displayMedium: TextStyle(
            fontSize: 14.sp,
            color: ColorManager.red,
            fontWeight: FontWeight.w500),
        displaySmall: TextStyle(
          fontSize: 12.spMin,
          fontWeight: FontWeight.w500,
          color: ColorManager.red,
        ),
        labelLarge: TextStyle(
            fontSize: 16.sp,
            color: ColorManager.green,
            fontWeight: FontWeight.bold),
        labelMedium: TextStyle(
            fontSize: 14.sp,
            color: ColorManager.green,
            fontWeight: FontWeight.w500),
        labelSmall: TextStyle(
          fontSize: 12.spMin,
          fontWeight: FontWeight.w500,
          color: ColorManager.green,
        ),
      ),
    );
  }

  //* Green THEME
  static ThemeData get greenTheme {
    return ThemeData(
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: WidgetStatePropertyAll(3),
          backgroundColor: WidgetStatePropertyAll(ColorManager.green),
          splashFactory: InkRipple.splashFactory,
          foregroundColor: WidgetStatePropertyAll(ColorManager.white),
        ),
      ),
      iconTheme: const IconThemeData(color: ColorManager.black),
      fontFamily: 'Poppins',
      useMaterial3: true,
      brightness: Brightness.light,
      // primarySwatch: ColorManager.green ,
      scaffoldBackgroundColor: ColorManager.white,
      appBarTheme: AppBarTheme(
        color: ColorManager.green,
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
            fontWeight: FontWeight.w500),
        bodySmall: TextStyle(
          fontSize: 12.spMin,
          fontWeight: FontWeight.w500,
          color: ColorManager.black,
        ),
        displayLarge: TextStyle(
            fontSize: 16.sp,
            color: ColorManager.green,
            fontWeight: FontWeight.bold),
        displayMedium: TextStyle(
            fontSize: 14.sp,
            color: ColorManager.green,
            fontWeight: FontWeight.w500),
        displaySmall: TextStyle(
          fontSize: 12.spMin,
          fontWeight: FontWeight.w500,
          color: ColorManager.green,
        ),
        labelLarge: TextStyle(
          fontSize: 16.sp,
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
        labelMedium: TextStyle(
          fontSize: 14.sp,
          color: Colors.blue,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          fontSize: 12.spMin,
          fontWeight: FontWeight.w500,
          color: Colors.blue,
        ),
      ),
    );
  }
}
