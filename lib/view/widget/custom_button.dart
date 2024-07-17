import 'package:find_hospital/utils/helper/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constant/color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.title,
      this.onPressed,
      this.isLoading = false,
      this.iconData,
      this.width,
      this.height});
  final String title;
  final void Function()? onPressed;
  final bool isLoading;
  final IconData? iconData;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width ?? context.width - 40.w, height ?? 40.h),
      ),
      onPressed: isLoading == false ? onPressed : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 10.w),
          Text(title, style: context.textTheme.bodyMedium),
          SizedBox(width: 10.w),
          Icon(
            iconData ?? Icons.location_on,
            color: ColorManager.black,
          ),
          SizedBox(width: 10.w),
        ],
      ),
    );
  }
}
