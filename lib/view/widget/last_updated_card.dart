import 'package:find_hospital/core/helper/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/cache/cache.dart';

class LastUpdatedCard extends StatelessWidget {
  const LastUpdatedCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String? lastUpdated = CacheData.getLastUpdatedTime('LastUpdated');
    return Positioned(
        left: 5.w,
        bottom: 5.h,
        child: Card(
          color: context.appBarTheme.backgroundColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
            child: Text("Last Updated: $lastUpdated",
                style: context.textTheme.bodySmall),
          ),
        ));
  }
}
