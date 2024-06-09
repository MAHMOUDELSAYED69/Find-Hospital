import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:find_hospital/core/constant/color.dart';
import 'package:flutter/material.dart';

double? selectedDoubleValue = 5000;

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
        borderRadius: BorderRadius.circular(16),
      )),
      barrierColor: ColorManager.red.withOpacity(0.1),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 5),
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
              Text(value.toString(),
                  textScaler: TextScaler.noScaling,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorManager.red)),
              const Text(
                " m",
                textScaler: TextScaler.noScaling,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.red,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
