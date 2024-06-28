import 'package:find_hospital/core/helper/extentions.dart';
import 'package:flutter/material.dart';

import '../../bloc/hospital_cubit/find_hospital_cubit.dart';
import '../../core/constant/color.dart';
import '../../core/constant/routes.dart';
import '../../data/models/hospital_model.dart';

class CachedHospitalsListViewBuilder extends StatelessWidget {
  const CachedHospitalsListViewBuilder({
    super.key,
    required List<Map<String, dynamic>> cachedHospitalList,
  }) : _cachedHospitalList = cachedHospitalList;

  final List<Map<String, dynamic>> _cachedHospitalList;

  @override
  Widget build(BuildContext context) {
    final cubit = context.bloc<FindHospitalCubit>();
    return Expanded(
      child: ListView.builder(
        itemCount: _cachedHospitalList.length,
        itemBuilder: (context, index) {
          final hospital = _cachedHospitalList[index];
          final HospitalsPlaceInfo hospitalDetailsList = HospitalsPlaceInfo(
            name: hospital['name'],
            rating: hospital['rate'],
            placeId: hospital['placeId'],
            lat: hospital['lat'],
            lng: hospital['lng'],
            businessStatus: hospital['businessStatus'],
            openNow: hospital['openNow'],
            userRatingsTotal: hospital['userRatingsTotal'],
            photos: hospital['photos'] != null
                ? List<Map<String, dynamic>>.from(hospital['photos'])
                : null,
            formattedPhoneNumber: hospital['formattedPhoneNumber'],
            internationalPhoneNumber: hospital['internationalPhoneNumber'],
            distance: hospital['distance'],
            duration: hospital['duration'],
          );

          //?---------------------------------------- hospitals data
          return Card(
            child: ListTile(
              onTap: () => Navigator.pushNamed(
                context,
                RouteManager.details,
                arguments: hospitalDetailsList,
              ),
              title:
                  Text(hospital['name'], style: context.textTheme.bodyMedium),
              subtitle: Row(
                children: [
                  Text(
                    cubit.isHospitalOpen(
                      hospital['openNow'],
                    ),
                    style: context.textTheme.bodyMedium?.copyWith(
                        color: hospital['openNow'] == true
                            ? Colors.green
                            : ColorManager.red),
                  ),
                ],
              ),
              trailing: const Icon(Icons.chevron_right),
              leading: Icon(
                Icons.emergency,
                color: context.appBarTheme.backgroundColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
