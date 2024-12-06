import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class LocalstorageController {
  LocalstorageController._privateConstructor();
  static final instance = LocalstorageController._privateConstructor();

  final userLocations = <String>[];
  Map<String, String> lastLocation = {'latitude': '', 'longitude': ''};

  initController() async {
    await initLocalStorage().whenComplete(
      () {
        localStorage.setItem('WEATHER_UNIT', 'Celcius');
        getLastLocation();
        restoreUserLocations();
      },
    );
  }

  getLastLocation() {
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

  setLastLocation(String lat, String lon) {
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

  setWeatherUnit(String value) => localStorage.setItem('WEATHER_UNIT', value);

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

  setDefaultTheme(String theme) => localStorage.setItem('DEFAULT_THEME', theme);

  restoreUserLocations() {
    int index = 0;
    while (localStorage.getItem('LOCATION_$index') != null && index < 3) {
      userLocations.add(localStorage.getItem('LOCATION_$index') ?? '');
      index++;
    }
  }

  updateUserLocations() {
    removeAllUserLocations();
    int index = 0;
    for (var location in userLocations) {
      localStorage.setItem('LOCATION_$index', location);
      index++;
    }
  }

  addLocation(String name) {
    userLocations.add(name);
    updateUserLocations();
  }

  removeUserLocation(String name) {
    final index = userLocations.indexOf(name);
    localStorage.removeItem('LOCATION_$index');
    userLocations.removeWhere((element) => element == name);
    updateUserLocations();
  }

  removeAllUserLocations() {
    for (var i = 0; i < 3; i++) {
      localStorage.removeItem('LOCATION_$i');
    }
  }

  eraseAllData() {
    localStorage.clear();
  }
}
