
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ApiUrlManager {
  ApiUrlManager._();
  static String googleMap = dotenv.env['mapApiKey']!;
  static String nearestHospital = dotenv.env['nearestHospitalBaseUrl']!;
  static String placeDetails = dotenv.env['placeDetailsBaseUrl']!;
  static String distanceAndTime = dotenv.env['distanceAndTimeBaseUrl']!;
}
