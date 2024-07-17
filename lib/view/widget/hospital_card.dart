import 'package:find_hospital/utils/helper/extentions.dart';
import 'package:find_hospital/view/widget/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constant/color.dart';

class HospitalRatingCard extends StatelessWidget {
  const HospitalRatingCard({
    super.key,
    required this.totalHospital,
  });

  final int totalHospital;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
              color: ColorManager.grey.withOpacity(0.5), width: 0.5)),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Row(
                children: [
                  Text(
                    "Total hospital Founded: ",
                    style: context.textTheme.bodyMedium,
                  ),
                  Text(
                    totalHospital.toString(),
                    style: context.textTheme.displayMedium,
                  ),
                ],
              ),
            ),
            const Expanded(flex: 2, child: MyDropDownMenuButton()),
          ],
        ),
      ),
    );
  }
}
