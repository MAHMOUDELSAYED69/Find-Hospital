import 'package:find_hospital/utils/helper/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/theme_cubit/theme_cubit.dart';
import '../../utils/constant/color.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: context.height / 4,
              width: context.width,
              child: Card(
                color: ColorManager.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                        color: ColorManager.grey.withOpacity(0.5), width: 0.6)),
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    BlocBuilder<ThemeCubit, ThemeState>(
                      builder: (context, state) {
                        return Card(
                          margin: EdgeInsets.all(10.w),
                          color: state == ThemeState.green
                              ? ColorManager.green
                              : ColorManager.red,
                          child: SwitchListTile(
                            title: Text('Theme Mode',
                                style: context.textTheme.bodyLarge
                                    ?.copyWith(fontSize: 14.sp)),
                            value: state == ThemeState.green,
                            onChanged: (_) =>
                                context.bloc<ThemeCubit>().toggleTheme(),
                          ),
                        );
                      },
                    ),
                    const Spacer(flex: 2),
                    Text(
                      context.bloc<ThemeCubit>().themeTitle(),
                      style: context.textTheme.displaySmall
                          ?.copyWith(fontSize: 24.sp),
                    ),
                    const Spacer(flex: 3),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
