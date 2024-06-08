// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:find_hospital/core/helper/location.dart';
import 'package:find_hospital/data/models/hospital_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/services/find_hospital.dart';

part 'find_hospital_state.dart';

class FindHospitalCubit extends Cubit<FindHospitalState> {
  FindHospitalCubit() : super(FindHospitalInitial());
  Position? location;

  Future<void> getCurrentLocation(context) async {
    while (location == null) {
      location = await LocationHelper.determineCurrentPosition(context);
    }
  }

  void openMaps({required double? lat, required double? lng}) async {
    if (lat != null && lng != null) {
      emit(OpenMapsLoading());
      final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
      if (await canLaunch(url)) {
        await launch(url);
        emit(OpenMapsSuccess());
      } else {
        log('Could not launch $url');
        emit(OpenMapsFailure(message: "Hospital location is not available"));
      }
    } else {
      log('Hospital location is not available');
    }
  }

  Future<void> getNearestHospitals({double? radius}) async {
    if (location == null) {
      emit(FindHospitalFailure(message: 'Location is not determined.'));
      return;
    }

    try {
      log('Loading nearest hospitals...');
      emit(FindHospitalLoading());

      final List<Map<String, dynamic>> hospitalsData =
          await FindHospitalWebService.getNearestHospital(
              location!.latitude, location!.longitude, radius);

      final List<PlaceInfo> hospitalsList = hospitalsData
          .map((item) {
            try {
              return PlaceInfo.fromJson(item);
            } catch (err) {
              log('Error parsing item: $item, error: $err');
              return null;
            }
          })
          .where((item) => item != null)
          .cast<PlaceInfo>()
          .toList();

      if (hospitalsList.isEmpty) {
        emit(FindHospitalFailure(message: 'No hospitals found.'));
      } else {
        log("Loaded nearest hospitals: $hospitalsList");
        emit(FindHospitalSuccess(hospitalsList: hospitalsList));
        log('Success: Loaded nearest hospitals.');
      }
    } catch (e) {
      log('Error: $e');
      emit(FindHospitalFailure(message: e.toString()));
    }
  }
}
