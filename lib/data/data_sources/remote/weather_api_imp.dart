import 'dart:developer';

import 'package:simple_weather_app/infra/port/input/weather_api.dart';
import 'package:weather/weather.dart';

class WeatherApiImp implements WeatherApi {
  WeatherApiImp._();
  static final WeatherApiImp instance = WeatherApiImp._();

  late WeatherFactory _factory;
  bool _status = false;

  @override
  Future<void> initApi(String key) async {
    if (!_status) {
      _factory = WeatherFactory(key);
      _status = true;
    } else {
      log('WeatherApiImp already initialized');
    }
  }

  @override
  Future<Weather> getWeatherByCity(String city) async {
    final Weather value = await _factory.currentWeatherByCityName(city);
    return value;
  }

  @override
  Future<Weather> getWeatherByLocation(double lat, double lon) async {
    final Weather value = await _factory.currentWeatherByLocation(lat, lon);
    return value;
  }

  @override
  Future<List<Weather>> getForecastByCity(String city) async {
    final List<Weather> values = await _factory.fiveDayForecastByCityName(city);
    return values;
  }

  @override
  Future<List<Weather>> getForecastByLocation(double lat, double lon) async {
    final List<Weather> values =
        await _factory.fiveDayForecastByLocation(lat, lon);
    return values;
  }
}
