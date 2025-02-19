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

  void changeTheme() {
    switch (theme.toString()) {
      case 'light':
        theme = ThemeMode.dark;
        break;
      case 'dark':
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
