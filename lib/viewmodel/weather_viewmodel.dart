import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:simple_weather_app/model/weather_entity.dart';
import 'package:simple_weather_app/repositories_services/localstorage/localstorage_repository.dart';
import 'package:simple_weather_app/repositories_services/localstorage/localstorage_repository_imp.dart';
import 'package:simple_weather_app/repositories_services/weather/weather_repository.dart';
import 'package:simple_weather_app/repositories_services/weather/weather_repository_imp.dart';

class WeatherViewmodel extends ValueNotifier<WeatherEntity> {
  WeatherViewmodel._(super._value);
  static final instance = WeatherViewmodel._(WeatherEntity.empty());

  late WeatherEntity lastWeather;
  late WeatherRepository _weatherRepository;
  late LocalstorageRepository _localstorageRepository;

  Future<bool> init() async {
    _weatherRepository = WeatherRepositoryImp();
    _localstorageRepository = LocalstorageRepositoryImp();
    await _weatherRepository.init();
    await _localstorageRepository.init().whenComplete(() async {
      await _localstorageRepository
          .getData('lastWeather')
          .onSuccess((success) => lastWeather = WeatherEntity.fromJson(success))
          .onFailure((failure) => log(failure.toString()));
    });
    return true;
  }

  Future<void> updateCurrentWeather() async {}

  Future<void> fetchWeatherByCity(String city) async {
    await _weatherRepository
        .getWeatherByCity(city)
        .onSuccess((success) => value = success)
        .onFailure((failure) => log(failure.toString()));
  }

  Future<void> fetchWeatherByLocation() async {}

  Future<void> fetchForecastByCity(String city) async {
    await _weatherRepository
        .getFilteredForecastByCity(city)
        .onSuccess((success) => value.forecast = success)
        .onFailure((failure) => log(failure.toString()));
  }

  Future<void> fetchForecastByLocation() async {}

  void updateLastWeather(WeatherEntity weather) {
    _localstorageRepository
        .saveData('lastWeather', weather.toJson())
        .onFailure((failure) => log(failure.toString()));
  }
}
