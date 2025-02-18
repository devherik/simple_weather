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

  factory AppPreferencesEntity.fromJson(Map<String, dynamic> json) {
    return AppPreferencesEntity(
      theme: json['theme'],
      weatherUnit: json['weatherUnit'],
      language: json['language'],
    );
  }

  factory AppPreferencesEntity.toJson(Map<String, dynamic> json) {
    return AppPreferencesEntity(
      theme: json['theme'],
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

  Map<String, dynamic> toJson() {
    return {
      'theme': theme,
      'weatherUnit': weatherUnit,
      'language': language,
    };
  }

  void changeTheme(String newTheme) {
    switch (newTheme) {
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
  }

  void changeWeatherUnit() {
    weatherUnit = weatherUnit == 'Celcius' ? 'Fahrenheit' : 'Celcius';
  }

  void changeLanguage() {
    language = language == 'pt-br' ? 'en' : 'pt-br';
  }
}
