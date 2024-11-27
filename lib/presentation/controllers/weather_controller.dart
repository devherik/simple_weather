import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:simple_weather_app/config/mockup/weather_mockup_imp.dart';
import 'package:simple_weather_app/data/data_sources/remote/location_api_imp.dart';
import 'package:simple_weather_app/data/data_sources/remote/weather_api_imp.dart';
import 'package:simple_weather_app/domain/entities/weather_entity.dart';
import 'package:simple_weather_app/infra/port/input/location_api.dart';
import 'package:simple_weather_app/infra/port/input/weather_api.dart';
import 'package:simple_weather_app/presentation/controllers/localstorage_controller.dart';
import 'package:simple_weather_app/presentation/controllers/main_controller.dart';
import 'package:weather/weather.dart';

class WeatherController {
  WeatherController._privateConstructor();
  static final WeatherController instance =
      WeatherController._privateConstructor();

  final LocationApi _locationApi = LocationApiImp.instance;
  //final WeatherApi _weatherApi = WeatherApiImp.instance;
  final WeatherApi _weatherApi = WeatherMockupImp.instance;
  final MainController _mainController = MainController.instance;
  final LocalstorageController localstorage = LocalstorageController.instance;

  ValueNotifier<WeatherEntity> currentWeather$ = ValueNotifier<WeatherEntity>(
      WeatherEntity('', '', DateTime.now(), '', 0, 20, 20, 20, 20,
          DateTime.now(), DateTime.now()));

  final String _weatherApiKey = dotenv.env['WEATHER_KEY']!;

  initController() async {
    try {
      await _weatherApi.initAPI(_weatherApiKey);
    } on Exception catch (e) {
      log(e.toString());
    }
    try {
      currentWeather$.value = await getWeatherByLocation();
    } on Exception catch (e) {
      log(e.toString());
    }
    return currentWeather$.value;
  }

  Future<void> updateWeather() async {
    try {
      currentWeather$.value = await getWeatherByLocation();
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  List<String> getUserLocations() => localstorage.userLocations;

  Future<WeatherEntity> getWeatherByLocation() async {
    final location = await _locationApi.getCurrentLocation();
    final Weather value = await _weatherApi.getWeatherByLocation(
        location.latitude, location.longitude);
    final WeatherEntity weather = instanceAWeather(value);
    weather.forecast = await getFilterdedForecastByLocation(
        location.latitude, location.longitude);
    return weather;
  }

  Future<WeatherEntity> getWeatherByCity(String city) async {
    final Weather value = await _weatherApi.getWeatherByCity(city);
    final WeatherEntity weather = instanceAWeather(value);
    weather.forecast = await getFilteredForecastByCity(city);
    return weather;
  }

  Future<List<WeatherEntity>> getFilteredForecastByCity(String city) async {
    //TODO: filter isnt working
    final List<Weather> values = await _weatherApi.getForecastByCity(city);
    final List<WeatherEntity> forecast = [];
    double min = 100.0, max = -100.0;
    int day = values[0].date!.day;
    for (var value in values) {
      if (value.date!.day == day) {
        switch (_mainController.weatherUnit$.value) {
          case 'Celcius':
            min < value.tempMin!.celsius!
                ? min = value.tempMin!.celsius!
                : null;
            max > value.tempMax!.celsius!
                ? max = value.tempMax!.celsius!
                : null;

          case 'Fahrenheit':
            min < value.tempMin!.fahrenheit!
                ? min = value.tempMin!.fahrenheit!
                : null;
            max > value.tempMax!.fahrenheit!
                ? max = value.tempMax!.fahrenheit!
                : null;
        }
      } else {
        day = value.date!.day;
        final WeatherEntity weather = instanceAWeather(value);
        weather.maxTemp = max;
        weather.minTemp = min;
        forecast.add(weather);
        min = 100.0;
        max = -100.0;
      }
    }
    return forecast;
  }

  Future<List<WeatherEntity>> getFilterdedForecastByLocation(
      double lat, double lon) async {
    final List<Weather> values =
        await _weatherApi.getForecastByLocation(lat, lon);
    final List<WeatherEntity> forecast = [];
    double min = 100.0, max = -100.0;
    int day = values[0].date!.day;
    for (var value in values) {
      if (value.date!.day == day) {
        switch (_mainController.weatherUnit$.value) {
          case 'Celcius':
            min > value.tempMin!.celsius!
                ? min = value.tempMin!.celsius!
                : null;
            max < value.tempMax!.celsius!
                ? max = value.tempMax!.celsius!
                : null;

          case 'Fahrenheit':
            min > value.tempMin!.fahrenheit!
                ? min = value.tempMin!.fahrenheit!
                : null;
            max < value.tempMax!.fahrenheit!
                ? max = value.tempMax!.fahrenheit!
                : null;
        }
      } else {
        day = value.date!.day;
        final WeatherEntity weather = instanceAWeather(value);
        weather.maxTemp = max;
        weather.minTemp = min;
        forecast.add(weather);
        min = 100.0;
        max = -100.0;
      }
    }
    return forecast;
  }

  WeatherEntity instanceAWeather(Weather value) {
    late WeatherEntity weather;
    switch (_mainController.weatherUnit$.value) {
      case 'Celcius':
        weather = WeatherEntity(
            value.areaName,
            value.country,
            value.date,
            value.weatherDescription,
            value.weatherConditionCode,
            value.temperature!.celsius,
            value.tempMax!.celsius,
            value.tempMin!.celsius,
            value.tempFeelsLike!.celsius,
            value.sunrise,
            value.sunset);
      case 'Fahrenheit':
        weather = WeatherEntity(
            value.areaName,
            value.country,
            value.date,
            value.weatherDescription,
            value.weatherConditionCode,
            value.temperature!.fahrenheit,
            value.tempMax!.fahrenheit,
            value.tempMin!.fahrenheit,
            value.tempFeelsLike!.fahrenheit,
            value.sunrise,
            value.sunset);
    }
    return weather;
  }
}
