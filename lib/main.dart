import 'package:find_hospital/core/cache/cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheData.cacheDataInit();
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}
