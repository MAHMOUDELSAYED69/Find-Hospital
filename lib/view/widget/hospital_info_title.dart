
import 'package:find_hospital/utils/helper/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/hospital_cubit/find_hospital_cubit.dart';
import '../../utils/constant/color.dart';

class HospitalInfoTitle extends StatelessWidget {
  const HospitalInfoTitle({
    super.key,
    this.name,
    this.isOpen,
  });

  final String? name;
  final bool? isOpen;

  @override
  Widget build(BuildContext context) {
    final cubit = context.bloc<FindHospitalCubit>();
    return Column(
      children: [
        Text(
          name ?? 'Unknown Hospital',
          textAlign: TextAlign.center,
          style: context.textTheme.bodyLarge?.copyWith(fontSize: 20.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          cubit.isHospitalOpen(isOpen),
          style: context.textTheme.bodyLarge?.copyWith(
            color: cubit.isHospitalOpen(isOpen) == "Open Now!"
                ? Colors.green
                : ColorManager.red,
          ),
        ),
      ],
    );
  }
}