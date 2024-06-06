
import 'package:flutter/material.dart';

import '../constant/color.dart';

void customSnackBar(BuildContext context,
    [String? message, Color? color, int? seconds]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      duration: Duration(seconds: seconds ?? 3),
      backgroundColor: (color ?? ColorManager.red).withOpacity(0.9),
      behavior: SnackBarBehavior.floating,
      content: Center(
        child: Text(
          message ?? "there was an error please try again later!",
          style:
            const TextStyle(color: ColorManager.white),
        ),
      )));
}
