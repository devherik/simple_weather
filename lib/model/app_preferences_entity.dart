import 'package:flutter/material.dart';

class AppPreferencesEntity {
  ThemeMode theme;
  String weatherUnit;
  String language;

  AppPreferencesEntity({
    required this.theme,
    required this.weatherUnit,
    required this.language,
  });

  factory AppPreferencesEntity.fromJson(Map<dynamic, dynamic> json) {
    ThemeMode theme;
    switch (json['theme']) {
      case 'ThemeMode.dark':
        theme = ThemeMode.dark;
        break;
      case 'ThemeMode.light':
        theme = ThemeMode.light;
        break;
      default:
        theme = ThemeMode.light;
        break;
    }
    return AppPreferencesEntity(
      theme: theme,
      weatherUnit: json['weatherUnit'],
      language: json['language'],
    );
  }

  factory AppPreferencesEntity.empty() {
    return AppPreferencesEntity(
      theme: ThemeMode.light,
      weatherUnit: 'Celcius',
      language: 'pt-br',
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'theme': theme.toString(),
      'weatherUnit': weatherUnit,
      'language': language,
    };
  }

  void changeTheme() {
    switch (theme.toString()) {
      case 'ThemeMode.dark':
        theme = ThemeMode.dark;
        break;
      case 'ThemeMode.light':
        theme = ThemeMode.light;
        break;
      default:
        theme = ThemeMode.light;
        break;
    }
  }

  void changeWeatherUnit(String unity) {
    weatherUnit = unity;
  }

  void changeLanguage() {
    language = language == 'pt-br' ? 'en' : 'pt-br';
  }
}
