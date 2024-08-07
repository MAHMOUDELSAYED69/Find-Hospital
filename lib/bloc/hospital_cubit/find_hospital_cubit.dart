// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:find_hospital/utils/cache/cache.dart';
import 'package:find_hospital/utils/helper/location.dart';
import 'package:find_hospital/data/models/hospital_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/constant/color.dart';
import '../../data/services/find_hospital.dart';
import '../../view/widget/custom_dropdown.dart';

part 'find_hospital_state.dart';

class FindHospitalCubit extends Cubit<FindHospitalState> {
  FindHospitalCubit() : super(FindHospitalInitial());
  Position? location;

  Future<void> getCurrentLocation(context) async {
    location ??= await LocationHelper.determineCurrentPosition(context);
  }

  Future<void> getNearestHospitals({double? radius}) async {
    if (location == null) {
      emit(FindHospitalFailure(message: 'Location is not determined.'));
      return;
    }

    try {
      log('Loading nearest hospitals...');
      emit(FindHospitalLoading());

      final List<HospitalsPlaceInfo> hospitalsData =
          await FindHospitalWebService.getNearestHospital(
              location!.latitude, location!.longitude, radius);

      final List<Map<String, dynamic>> hospitalsCacheData =
          hospitalsData.map((hospital) {
        return {
          'name': hospital.name,
          'openNow': hospital.openNow,
          'rate': hospital.rating,
          'userRatingsTotal': hospital.userRatingsTotal,
          'lat': hospital.lat,
          'lng': hospital.lng,
          'businessStatus': hospital.businessStatus,
          'placeId': hospital.placeId,
          'formattedPhoneNumber': hospital.formattedPhoneNumber,
          'internationalPhoneNumber': hospital.internationalPhoneNumber,
          'photos': hospital.photos,
          'distance': hospital.distance,
          'duration': hospital.duration,
        };
      }).toList();

      await CacheData.setLastUpdatedTime('LastUpdated');
      await CacheData.setListOfMaps(
          key: 'nearestHospitals', value: hospitalsCacheData);
      log('Success: Cached nearest hospitals data.');

      if (hospitalsData.isEmpty) {
        emit(FindHospitalFailure(message: 'No hospitals found.'));
      } else {
        emit(FindHospitalSuccess(hospitalsList: hospitalsData));
        log('Success: Loaded nearest hospitals.');
      }
      await CacheData.set(key: 'selectedValue', value: selectedDoubleValue);
    } catch (err) {
      log('Error: $err');
      emit(FindHospitalFailure(message: err.toString()));
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
        emit(OpenMapsFailure(message: "Could not launch Google Maps"));
      }
    } else {
      log('Hospital location is not available');
      emit(OpenMapsFailure(message: "Hospital location is not available"));
    }
  }

  String isHospitalOpen(bool? isOpenNow) {
    return isOpenNow == true ? "Open Now!" : "Close Now!";
  }

  Color ratingChecker({double? rating, int? totalRating}) {
    if (rating != null) {
      return rating > 2.5 ? Colors.green : ColorManager.red;
    }
    if (totalRating != null) {
      return totalRating > 10 ? Colors.green : ColorManager.red;
    }
    return Colors.red;
  }
}
