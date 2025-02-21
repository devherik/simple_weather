import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:result_dart/result_dart.dart';
import 'package:simple_weather_app/model/weather_entity.dart';
import 'package:simple_weather_app/repositories_services/localstorage/localstorage_repository.dart';
import 'package:simple_weather_app/repositories_services/localstorage/localstorage_repository_imp.dart';
import 'package:simple_weather_app/repositories_services/location/location_service.dart';
import 'package:simple_weather_app/repositories_services/location/location_service_imp.dart';
import 'package:simple_weather_app/repositories_services/weather/weather_repository.dart';
import 'package:simple_weather_app/repositories_services/weather/weather_repository_imp.dart';

class WeatherViewmodel extends ValueNotifier<WeatherEntity> {
  WeatherViewmodel._(super._value);
  static final instance = WeatherViewmodel._(WeatherEntity.empty());

  late WeatherEntity lastWeather;
  late WeatherRepository _weatherRepository;
  late LocalstorageRepository _localstorageRepository;
  late LocationService _locationService;

  late Location position;

  bool _status = false;

  Future<bool> init() async {
    if (!_status) {
      _weatherRepository = WeatherRepositoryImp.instance;
      _localstorageRepository = LocalstorageRepositoryImp.instance;
      _locationService = LocationServiceImp();
      await _weatherRepository.init();
      await _localstorageRepository.init().whenComplete(() async {
        await _localstorageRepository
            .getData('lastWeather')
            .onSuccess(
                (success) => lastWeather = WeatherEntity.fromJson(success))
            .onFailure((failure) => log(failure.toString()));
      });
      await _locationService.initApi().whenComplete(() async =>
          await _locationService
              .getCurrentLocation()
              .onSuccess((success) => position = success)
              .onFailure((failure) => log(failure.toString())));
      _status = true;
    } else {
      log('Weather viewmodel already initialized');
    }
    value.cityName == 'Empty' ? await updateCurrentWeather() : null;
    return _status;
  }

  Future<void> updateCurrentWeather() async {
    _locationService
        .getCurrentLocation()
        .onSuccess((success) => position = success)
        .onFailure((failure) => log(failure.toString()));
    await fetchWeatherByLocation(position.latitude, position.longitude);
    await fetchForecastByLocation(position.latitude, position.longitude);
  }

  Future<WeatherEntity> fetchWeatherByCity(String city) async {
    WeatherEntity weatherEntity = WeatherEntity.empty();
    await _weatherRepository
        .getWeatherByCity(city)
        .onSuccess((success) => weatherEntity = success)
        .onFailure((failure) =>
            log(failure.toString())); //TODO: Implementar erro notification
    return weatherEntity;
  }

  Future<void> fetchWeatherByLocation(double lat, double lon) async {
    await _weatherRepository
        .getWeatherByLocation(lat, lon)
        .onSuccess((success) {
      value = success;
      updateLastWeather(value);
    }).onFailure((failure) => log(failure.toString()));
  }

  Future<List<WeatherEntity>> fetchForecastByCity(String city) async {
    List<WeatherEntity> forecast = [];
    await _weatherRepository
        .getFilteredForecastByCity(city)
        .onSuccess((success) => forecast = success)
        .onFailure((failure) =>
            log(failure.toString())); //TODO: Implementar erro notification
    return forecast;
  }

  Future<void> fetchForecastByLocation(double lat, double lon) async {
    await _weatherRepository
        .getFilterdedForecastByLocation(lat, lon)
        .onSuccess((success) => value.forecast = success)
        .onFailure((failure) => log(failure.toString()));
  }

  void updateLastWeather(WeatherEntity weather) {
    _localstorageRepository
        .saveData('lastWeather', weather.toJson())
        .onFailure((failure) => log(failure.toString()));
  }
}
