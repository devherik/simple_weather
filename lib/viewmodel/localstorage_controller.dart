import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class LocalstorageController {
  LocalstorageController._privateConstructor();
  static final instance = LocalstorageController._privateConstructor();

  Map<String, String> lastLocation = {'latitude': '', 'longitude': ''};

  Future<void> initController() async {
    await initLocalStorage().whenComplete(
      () {
        localStorage.setItem('WEATHER_UNIT', 'Celcius');
        retrieveLastLocation();
      },
    );
  }

  void retrieveLastLocation() {
    if (localStorage.getItem('LAST_LOCATION_LATITUDE') != null) {
      lastLocation['latitude'] =
          localStorage.getItem('LAST_LOCATION_LATITUDE')!;
    } else {
      localStorage.setItem('LAST_LOCATION_LATITUDE', '');
      lastLocation['latitude'] = '';
    }
    if (localStorage.getItem('LAST_LOCATION_LONGITUDE') != null) {
      lastLocation['longitude'] =
          localStorage.getItem('LAST_LOCATION_LONGITUDE')!;
    } else {
      localStorage.setItem('LAST_LOCATION_LONGITUDE', '');
      lastLocation['longitude'] = '';
    }
  }

  void setLastLocation(String lat, String lon) {
    lastLocation = {'latitude': lat, 'longitude': lon};
  }

  String getWeatherUnit() {
    if (localStorage.getItem('WEATHER_UNIT') != null) {
      return localStorage.getItem('WEATHER_UNIT')!;
    } else {
      localStorage.setItem('WEATHER_UNIT', 'Celcius');
      return 'Celcius';
    }
  }

  void setWeatherUnit(String value) =>
      localStorage.setItem('WEATHER_UNIT', value);

  ThemeMode getDefaultTheme() {
    ThemeMode theme;
    if (localStorage.getItem('DEFAULT_THEME') != null) {
      final defaultTheme = localStorage.getItem('DEFAULT_THEME');
      switch (defaultTheme) {
        case 'light':
          theme = ThemeMode.light;
          break;
        case 'dark':
          theme = ThemeMode.dark;
          break;
        default:
          theme = ThemeMode.light;
          break;
      }
      return theme;
    } else {
      localStorage.setItem('DEFAULT_THEME', 'light');
      theme = ThemeMode.light;
      return theme;
    }
  }

  void setDefaultTheme(String theme) =>
      localStorage.setItem('DEFAULT_THEME', theme);

  void eraseAllData() {
    try {
      localStorage.clear();
    } on Exception catch (e) {
      throw e.toString();
    }
  }
}
