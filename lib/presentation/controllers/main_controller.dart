import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:simple_weather_app/data/data_sources/remote/location_api_imp.dart';
import 'package:simple_weather_app/infra/port/input/location_api.dart';
import 'package:simple_weather_app/presentation/controllers/localstorage_controller.dart';

class MainController {
  // a controller to start the application apis, plugins, themes etc
  MainController._privateConstructor();
  static final MainController instance = MainController._privateConstructor();

  final LocationApi _locationApi = LocationApiImp.instance;
  final LocalstorageController _localstorageController =
      LocalstorageController.instance;

  var themeMode$ = ValueNotifier<ThemeMode>(ThemeMode.light);

  initController() async {
    await dotenv.load(fileName: '.env');
    await _locationApi.initAPI();
    await _localstorageController.initController();
  }

  ThemeMode getTheme() => themeMode$.value;

  changeTheme() {
    switch (themeMode$.value) {
      case ThemeMode.system:
        themeMode$.value = ThemeMode.dark;
        break;
      case ThemeMode.light:
        themeMode$.value = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        themeMode$.value = ThemeMode.light;
        break;
      default:
    }
  }
}
