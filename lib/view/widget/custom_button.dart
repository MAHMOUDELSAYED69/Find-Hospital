import 'package:find_hospital/core/helper/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.title,
      this.onPressed,
      this.isLoading = false,
      this.iconData,
      this.bgColor});
  final String title;
  final void Function()? onPressed;
  final bool isLoading;
  final IconData? iconData;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor ?? ColorManager.red,
        elevation: 3,
        splashFactory: InkRipple.splashFactory,
        foregroundColor: ColorManager.grey,
        fixedSize: Size(context.width - 40.w, 50),
      ),
      onPressed: isLoading == false ? onPressed : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          Text(title, style:context.textTheme.bodyMedium),
          const SizedBox(width: 10),
          Icon(
            iconData ?? Icons.location_on,
            color: ColorManager.black,
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
