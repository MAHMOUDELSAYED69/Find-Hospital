import 'dart:developer';

import 'package:find_hospital/core/helper/scaffold_snackbar.dart';
import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static Future<Position> determineCurrentPosition(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log('Location services are disabled.');
      customSnackBar(context, "Location services are disabled.");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log('Location permissions are denied.');
      customSnackBar(context, "Location permissions are denied.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      log('Location permissions are permanently denied.');
          customSnackBar(context, "Location permissions are permanently denied.");
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
