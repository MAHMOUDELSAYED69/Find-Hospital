import 'package:flutter/material.dart';

import '../../core/constant/color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.title,
      this.onPressed,
      this.isLoading = false,
      this.iconData});
  final String title;
  final void Function()? onPressed;
  final bool isLoading;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 3,
        splashFactory: InkRipple.splashFactory,
        foregroundColor: ColorManager.grey,
        fixedSize: const Size(double.infinity, 50),
      ),
      onPressed: isLoading == false ? onPressed : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          Text(title, style: const TextStyle(color: ColorManager.black)),
          const SizedBox(width: 10),
          Icon(
            iconData ?? Icons.location_on,
            color: ColorManager.red,
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
