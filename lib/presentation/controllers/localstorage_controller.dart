import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class LocalstorageController {
  LocalstorageController._privateConstructor();
  static final instance = LocalstorageController._privateConstructor();

  final userLocations = <String>[];

  initController() async {
    await initLocalStorage().whenComplete(
      () {
        localStorage.setItem('LOCATION_0', 'Timóteo');
        localStorage.setItem('LOCATION_1', 'Santana do Paraíso');
        localStorage.setItem('LOCATION_2', 'Belo Horizonte');
        localStorage.setItem('MAIN_LOCATION', 'Timóteo');
        localStorage.setItem('WEATHER_UNIT', 'Celcius');
        restoreUserLocations();
      },
    );
  }

  String getWeatherUnit() {
    if (localStorage.getItem('WEATHER_UNIT') != null) {
      return localStorage.getItem('WEATHER_UNIT')!;
    } else {
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

  String getMainLocation() {
    if (localStorage.getItem('MAIN_LOCATION') != null) {
      return localStorage.getItem('MAIN_LOCATION')!;
    } else {
      return '';
    }
  }

  setMainLocation(String value) => localStorage.setItem('MAIN_LOCATION', value);

  restoreUserLocations() {
    int index = 0;
    while (localStorage.getItem('LOCATION_$index') != null && index < 3) {
      userLocations.add(localStorage.getItem('LOCATION_$index') ?? '');
      index++;
    }
  }

  updateUserLocations() {
    int index = 0;
    for (var location in userLocations) {
      localStorage.setItem('LOCATION_$index', location);
      index++;
    }
  }

  addLocation(String name) {
    userLocations.length < 3 ? userLocations.add(name) : throw 'List is full';
    updateUserLocations();
  }

  removeUserLocation(String name) {
    userLocations.removeWhere((element) => element == name);
    updateUserLocations();
  }

  eraseAllData() {
    localStorage.clear();
  }
}
