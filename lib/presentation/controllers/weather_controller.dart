import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:simple_weather_app/data/data_sources/remote/location_api_imp.dart';
import 'package:simple_weather_app/data/data_sources/remote/weather_api_imp.dart';
import 'package:simple_weather_app/domain/entities/weather_entity.dart';
import 'package:simple_weather_app/infra/port/input/location_api.dart';
import 'package:simple_weather_app/infra/port/input/weather_api.dart';
import 'package:simple_weather_app/presentation/controllers/localstorage_controller.dart';
import 'package:weather/weather.dart';

class WeatherController {
  WeatherController._privateConstructor();
  static final WeatherController instance =
      WeatherController._privateConstructor();

  final LocationApi _locationApi = LocationApiImp.instance;
  final WeatherApi _weatherApi = WeatherApiImp.instance;
  final LocalstorageController localstorage = LocalstorageController.instance;

  ValueNotifier<WeatherEntity> currentWeather$ = ValueNotifier<WeatherEntity>(
      WeatherEntity('', '', DateTime.now(), '', 0, 20, 20, 20, 20,
          DateTime.now(), DateTime.now()));

  final String _weatherApiKey = dotenv.env['WEATHER_KEY']!;

  initController() async {
    await _weatherApi.initAPI(_weatherApiKey);
    if (localstorage.userAddresses$.value[0].isEmpty) {
      currentWeather$.value = await getWeatherByLocation();
    } else {
      currentWeather$.value =
          await getWeatherByCity(localstorage.userAddresses$.value[0]);
    }
  }

  updateWeather() async {
    currentWeather$.value =
        await getWeatherByCity(_locationApi.getCurrentAddress());
  }

  changeAddressWeather(String address) async {
    await _locationApi.updateCurrentAddress(address);
    await updateWeather();
  }

  String getUserAddress() => _locationApi.getCurrentAddress();

  List<String> getUserAddresses() => localstorage.userAddresses$.value;

  Future<WeatherEntity> getWeatherByLocation() async {
    final location = await _locationApi.getCurrentLocation();
    final Weather value = await _weatherApi.getWeatherByLocation(
        location.latitude, location.longitude);
    final WeatherEntity weather = WeatherEntity(
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
    weather.forecast =
        await getForecastByLocation(location.latitude, location.longitude);
    _locationApi.updateCurrentAddress(weather.cityName);
    return weather;
  }

  Future<WeatherEntity> getWeatherByCity(String city) async {
    final Weather value = await _weatherApi.getWeatherByCity(city);
    final WeatherEntity weather = WeatherEntity(
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
    weather.forecast = await getForecastByCity(city);
    _locationApi.updateCurrentAddress(weather.cityName);
    return weather;
  }

  Future<List<WeatherEntity>> getForecastByCity(String city) async {
    final List<Weather> values = await _weatherApi.getForecastByCity(city);
    final List<WeatherEntity> forecast = [];
    for (var value in values) {
      final WeatherEntity weather = WeatherEntity(
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
      forecast.add(weather);
    }
    return forecast;
  }

  Future<List<WeatherEntity>> getForecastByLocation(
      double lat, double lon) async {
    final List<Weather> values =
        await _weatherApi.getForecastByLocation(lat, lon);
    final List<WeatherEntity> forecast = [];
    for (var value in values) {
      final WeatherEntity weather = WeatherEntity(
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
      forecast.add(weather);
    }
    return forecast;
  }
}
