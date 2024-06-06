import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:find_hospital/core/constant/api_url.dart';
import 'package:uuid/uuid.dart';

import '../models/hospital_model.dart';

class FindHospitalWebService {
  static Dio dio = Dio();

  static Future<List<PlaceInfo>> getNearestHospital(
      double latitude, double longitude, double? radius) async {
    List<PlaceInfo> allResults = [];
    String? nextPageToken;
    num totalResults = 0;

    do {
      String sessionToken = const Uuid().v4();
      final queryParameters = {
        'location': '$latitude,$longitude',
        'radius': radius?.toString() ?? '5000',
        'type': 'hospital',
        'key': ApiUrlManager.googleMap,
        'sessiontoken': sessionToken,
        if (nextPageToken != null) 'pagetoken': nextPageToken,
      };

      try {
        final response = await dio.get(
          ApiUrlManager.nearestHospital,
          queryParameters: queryParameters,
        );
        log("Fetching DATA.....");
        List<dynamic> data = response.data['results'];
        log(data.toString());
        for (var item in data) {
          allResults.add(PlaceInfo.fromJson(item));
        }

        nextPageToken = response.data['next_page_token'];
        totalResults += data.length;

        if (nextPageToken != null) {
          await Future.delayed(const Duration(seconds: 2));
        }
      } catch (err) {
        log(err.toString());
        break;
      }
    } while (nextPageToken != null && totalResults < 60);

    log(allResults.toString());
    return allResults;
  }
}
