import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheData {
  static late SharedPreferences sharedpref;

  static Future<void> cacheDataInit() async {
    sharedpref = await SharedPreferences.getInstance();
  }

  static Future<bool> set({required String key, required dynamic value}) async {
    if (value is String) {
      return await sharedpref.setString(key, value);
    }
    if (value is double) {
      return await sharedpref.setDouble(key, value);
    }
    if (value is int) {
      return await sharedpref.setInt(key, value);
    }
    if (value is bool) {
      return await sharedpref.setBool(key, value);
    }
    return false;
  }

  static Future<bool> setMap({required String key, required Map value}) async {
    String jsonString = jsonEncode(value);
    return await sharedpref.setString(key, jsonString);
  }

  static Map<String, dynamic> getMapData({required String key}) {
    String jsonString = sharedpref.getString(key) ?? '{}';
    return jsonDecode(jsonString);
  }

  static Future<bool> setListOfMaps({required String key, required List<Map<String, dynamic>> value}) async {
    String jsonString = jsonEncode(value);
    return await sharedpref.setString(key, jsonString);
  }

  static List<Map<String, dynamic>> getListOfMaps({required String key}) {
    String jsonString = sharedpref.getString(key) ?? '[]';
    List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((e) => e as Map<String, dynamic>).toList();
  }

  static dynamic get({required String key}) {
    return sharedpref.get(key);
  }

  static Future<void> delete({required String key}) async {
    await sharedpref.remove(key);
  }

  static Future<bool> clear({required bool clearData}) async {
    if (clearData == true) {
      await sharedpref.clear();
      return true;
    }
    return false;
  }
}
