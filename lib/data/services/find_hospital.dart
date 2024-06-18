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
      log('call getNearestHospital');
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
          final details = await _getPlaceDetails(placeId, latitude, longitude);
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

  static Future<PlaceInfo?> _getPlaceDetails(
      String placeId, double originLat, double originLng) async {
    log('call _getPlaceDetails');
    try {
      final response =
          await dio.get(ApiUrlManager.placeDetails, queryParameters: {
        'place_id': placeId,
        'key': ApiUrlManager.googleMap,
      });

      final placeDetails = response.data['result'];
      final distanceAndDuration = await _getDistanceAndDuration(
        originLat,
        originLng,
        placeDetails['geometry']['location']['lat'],
        placeDetails['geometry']['location']['lng'],
      );

      return PlaceInfo.fromJson({
        ...placeDetails,
        'distance': distanceAndDuration['distance'],
        'duration': distanceAndDuration['duration'],
      });
    } catch (err) {
      log('Error fetching place details: $err');
      return null;
    }
  }

  static Future<Map<String, String>> _getDistanceAndDuration(double originLat,
      double originLng, double destLat, double destLng) async {
    log('call _getDistanceAndDuration');
    try {
      final response = await dio.get(
        "https://maps.googleapis.com/maps/api/distancematrix/json",
        queryParameters: {
          'origins': '$originLat,$originLng',
          'destinations': '$destLat,$destLng',
          'key': ApiUrlManager.googleMap,
        },
      );

      final element = response.data['rows'][0]['elements'][0];
      return {
        'distance': element['distance']['text'],
        'duration': element['duration']['text'],
      };
    } catch (err) {
      log('Error fetching distance matrix: $err');
      return {};
    }
  }
}
