import 'package:flutter/material.dart';

import '../../core/constant/color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.title, this.onPressed});
  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 3,
        splashFactory: InkRipple.splashFactory,
        foregroundColor: ColorManager.grey,
        fixedSize: const Size(double.infinity, 50),
      ),
      onPressed: onPressed,
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 10),
          Text("GET NEAREST HOSPITAL",
              style: TextStyle(color: ColorManager.black)),
          SizedBox(width: 10),
          Icon(
            Icons.location_on,
            color: ColorManager.red,
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
