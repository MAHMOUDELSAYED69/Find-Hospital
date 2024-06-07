import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:find_hospital/core/constant/api_url.dart';
import 'package:uuid/uuid.dart';

class FindHospitalWebService {
  static final Dio dio = Dio();

  static Future<List<Map<String, dynamic>>> getNearestHospital(
      double latitude, double longitude, double? radius) async {
    final String sessionToken = const Uuid().v4();
    List<Map<String, dynamic>> hospitals = [];
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
        hospitals.addAll(results
            .map((dynamic item) => item as Map<String, dynamic>)
            .toList());

        nextPageToken = response.data['next_page_token'];
        await Future.delayed(const Duration(seconds: 2));
      } catch (err) {
        log('Error: $err');
        return hospitals;
      }
    } while (hospitals.length < 60 && nextPageToken != null);

    return hospitals;
  }
}
