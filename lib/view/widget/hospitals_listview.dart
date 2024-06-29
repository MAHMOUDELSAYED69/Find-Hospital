import 'package:find_hospital/core/helper/extentions.dart';
import 'package:flutter/material.dart';

import '../../bloc/hospital_cubit/find_hospital_cubit.dart';
import '../../core/constant/color.dart';
import '../../core/constant/routes.dart';
import '../../data/models/hospital_model.dart';

class HopitalsListViewBuilder extends StatelessWidget {
  const HopitalsListViewBuilder({
    super.key,
    required List<HospitalsPlaceInfo?> hospitalList,
    required this.cubit,
  }) : _hospitalList = hospitalList;

  final List<HospitalsPlaceInfo?> _hospitalList;
  final FindHospitalCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _hospitalList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                final HospitalsPlaceInfo? placeInfo = _hospitalList[index];
                Navigator.pushNamed(context, RouteManager.details,
                    arguments: placeInfo);
              },
              title: Text(
                _hospitalList[index]?.name ?? '',
                style: context.textTheme.bodyMedium,
              ),
              subtitle: Text(
                cubit.isHospitalOpen(_hospitalList[index]?.openNow),
                style: context.textTheme.bodyMedium?.copyWith(
                    color: _hospitalList[index]?.openNow == true
                        ? Colors.green
                        : ColorManager.red),
              ),
              trailing: const Icon(Icons.chevron_right),
              leading:  const Icon(Icons.emergency),
            ),
          );
        },
      ),
    );
  }
}
