import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:find_hospital/utils/cache/cache.dart';
import 'package:find_hospital/utils/helper/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

double? selectedDoubleValue = CacheData.get(key: 'selectedValue') ?? 1000;

class MyDropDownMenuButton extends StatefulWidget {
  const MyDropDownMenuButton({super.key});

  @override
  State<MyDropDownMenuButton> createState() => _MyDropDownMenuButtonState();
}

class _MyDropDownMenuButtonState extends State<MyDropDownMenuButton> {
  final List<double> _doubleValues = [500, 1000, 1500, 2000, 3000, 5000, 10000];
  @override
  Widget build(BuildContext context) {
    return DropdownButton2<double>(
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      menuItemStyleData: MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
      ),
      isExpanded: false,
      value: selectedDoubleValue,
      onChanged: (double? newValue) {
        setState(() {
          selectedDoubleValue = newValue;
        });
      },
      items: _doubleValues.map((double value) {
        return DropdownMenuItem<double>(
          alignment: Alignment.center,
          value: value,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value.toString(),
                textScaler: TextScaler.noScaling,
                style: context.textTheme.displaySmall,
              ),
              Text(
                " m",
                textScaler: TextScaler.noScaling,
                style: context.textTheme.displaySmall,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
