import 'package:geolocator/geolocator.dart';
import 'package:simple_weather_app/data/data_sources/remote/location_api_imp.dart';
import 'package:simple_weather_app/data/data_sources/remote/weather_api_imp.dart';
import 'package:simple_weather_app/domain/entities/weather_entity.dart';
import 'package:simple_weather_app/infra/port/input/location_api.dart';
import 'package:simple_weather_app/infra/port/input/weather_api.dart';
import 'package:weather/weather.dart';

class Controller {
  Controller._privateController();
  static final Controller instance = Controller._privateController();

  final LocationApi _locationApi = LocationApiImp.instance;
  final WeatherApi _weatherApi = WeatherApiImp.instance;

  final String _weatherApiKey = '41bdaa6c0895ca108bf29a888bdf885e';

  initController() async {
    await _weatherApi.initAPI(_weatherApiKey);
  }

  Future<WeatherEntity> getWeatherByLocation() async {
    final Position location = await _locationApi.getCurrentLocation();
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
