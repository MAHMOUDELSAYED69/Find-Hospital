import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:find_hospital/core/constant/api_url.dart';
import 'package:uuid/uuid.dart';

import '../models/hospital_model.dart';

class FindHospitalWebService {
  static final Dio dio = Dio();

  static Future<List<PlaceInfo>> getNearestHospital(
      double latitude, double longitude, double? radius) async {
    final String sessionToken = const Uuid().v4();
    List<PlaceInfo> hospitals = [];
    String? nextPageToken;

    do {
      try {
        final response = await dio.get(
          ApiUrlManager.nearestHospital,
          queryParameters: {
            'location': '$latitude,$longitude',
            'radius': radius?.toString() ?? '5000',
            'type': 'hospital',
            'key': ApiUrlManager.googleMap,
            'sessiontoken': sessionToken,
            if (nextPageToken != null) 'pagetoken': nextPageToken,
          },
        );

        if (response.data == null || response.data['results'] == null) {
          log('Response data is null or missing results key');
          return hospitals;
        }

        final List<dynamic> results = response.data['results'];
        for (var item in results) {
          final placeId = item['place_id'];
          final details = await _getPlaceDetails(placeId);
          if (details != null) {
            hospitals.add(details);
          }
        }

        nextPageToken = response.data['next_page_token'];
        await Future.delayed(const Duration(seconds: 2));
      } catch (err) {
        log('Error: $err');
        return hospitals;
      }
    } while (hospitals.length < 60 && nextPageToken != null);

    return hospitals;
  }

  static Future<PlaceInfo?> _getPlaceDetails(String placeId) async {
    try {
      final response =
          await dio.get(ApiUrlManager.placeDetails, queryParameters: {
        'place_id': placeId,
        'key': ApiUrlManager.googleMap,
      });

      if (response.statusCode == 200 && response.data['status'] == 'OK') {
        return PlaceInfo.fromJson(response.data['result']);
      } else {
        log('Failed to load place details: ${response.data['status']}');
        return null;
      }
    } catch (err) {
      log('Error fetching place details: $err');
      return null;
    }
  }
}
