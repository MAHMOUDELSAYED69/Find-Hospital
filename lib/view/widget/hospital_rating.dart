import 'package:find_hospital/utils/helper/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/hospital_cubit/find_hospital_cubit.dart';

class HospitalRateCard extends StatelessWidget {
  const HospitalRateCard(
      {super.key, required this.rating, required this.userTotalRating});
  final double? rating;
  final int? userTotalRating;

  @override
  Widget build(BuildContext context) {
    final cubit = context.bloc<FindHospitalCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              "Rating",
              style: context.textTheme.bodyMedium,
            ),
            SizedBox(height: 4.h),
            Text(
              rating.toString(),
              style: context.textTheme.bodyMedium?.copyWith(
                color: cubit.ratingChecker(rating: rating),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              "Users Ratings Total",
              style: context.textTheme.bodyMedium,
            ),
            SizedBox(height: 4.h),
            Text(
              '$userTotalRating Users',
              style: context.textTheme.bodyMedium?.copyWith(
                color: cubit.ratingChecker(totalRating: userTotalRating),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
