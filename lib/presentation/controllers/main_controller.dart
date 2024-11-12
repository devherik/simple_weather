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

  var themeMode$ = ValueNotifier<ThemeMode>(ThemeMode.system);
  var weatherUnit$ = ValueNotifier<String>('Celcius');
  bool darkThemeOn = false;

  initController() async {
    await dotenv.load(fileName: '.env');
    await _locationApi.initAPI();
    await _localstorageController.initController();
    setTheme();
    setWeatherUnit();
  }

  setWeatherUnit() =>
      weatherUnit$.value = _localstorageController.getWeatherUnit();
  changeWeatherUnit(String value) {
    weatherUnit$.value = value;
    _localstorageController.setWeatherUnit(value);
  }

  setTheme() {
    themeMode$.value = _localstorageController.getDefaultTheme();
    switch (themeMode$.value) {
      case ThemeMode.light:
        darkThemeOn = false;
        break;
      case ThemeMode.dark:
        darkThemeOn = true;
        break;
      default:
        darkThemeOn = false;
        break;
    }
  }

  ThemeMode getTheme() => themeMode$.value;

  changeTheme() {
    darkThemeOn = !darkThemeOn;
    if (darkThemeOn) {
      themeMode$.value = ThemeMode.dark;
      _localstorageController.setDefaultTheme('dark');
    } else {
      themeMode$.value = ThemeMode.light;
      _localstorageController.setDefaultTheme('light');
    }
  }

  eraseAllInformation() async {}
}
