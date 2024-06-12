
import 'package:find_hospital/core/helper/extentions.dart';
import 'package:flutter/material.dart';


void customSnackBar(BuildContext context,
    [String? message, Color? color, int? seconds]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      duration: Duration(seconds: seconds ?? 3),
      backgroundColor: (color ?? context.appBarTheme.backgroundColor)!.withOpacity(0.9),
      behavior: SnackBarBehavior.floating,
      content: Center(
        child: Text(
          message ?? "there was an error please try again later!",
          style:
           context.textTheme.bodyMedium,
        ),
      )));
}
