import 'package:flutter/material.dart';
import 'package:simple_weather_app/core/theme/theme.dart';
import 'package:simple_weather_app/data/data_sources/remote/location_api_imp.dart';
import 'package:simple_weather_app/features/home.dart';
import 'package:simple_weather_app/infra/port/input/location_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final LocationApi locationAPI = LocationApiImp.instance;
  await locationAPI.initAPI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Weather',
      theme: AppTheme.light,
      home: const HomePage(),
    );
  }
}
