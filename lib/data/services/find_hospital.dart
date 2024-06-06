import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:find_hospital/core/constant/api_url.dart';
import 'package:uuid/uuid.dart';

class FindHospitalWebService {
  static Dio dio = Dio();

  static Future<List<dynamic>> getNearestHospital(
      double latitude, double longitude, double? radius) async {
    List<dynamic> allResults = [];
    String? nextPageToken;
    num totalResults = 0;

    do {
      String sessionToken = const Uuid().v4();
      final queryParameters = {
        'location': '$latitude,$longitude',
        'radius': radius ?? '5000',
        'type': 'hospital',
        'key': ApiUrlManager.googleMap,
        'sessiontoken': sessionToken,
        if (nextPageToken != null) 'pagetoken': nextPageToken,
      };

      try {
        final response = await dio.get(
            ApiUrlManager.nearestHospital,
            queryParameters: queryParameters);
        List data = response.data['results'];
        allResults.addAll(data);
        nextPageToken = response.data['next_page_token'];
        totalResults += data.length;
        for (var i = 0; i < data.length; i++) {
          log(data[i]['name']);
        }
        if (nextPageToken != null) {
          await Future.delayed(const Duration(seconds: 2));
        }
      } catch (err) {
        log(err.toString());
        break;
      }
    } while (nextPageToken != null && totalResults < 60);

    return allResults;
  }
}
