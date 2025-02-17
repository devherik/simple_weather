import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:result_dart/result_dart.dart';
import 'package:simple_weather_app/data/data_sources/remote/weather_api_imp.dart';
import 'package:simple_weather_app/infra/port/input/weather_api.dart';
import 'package:simple_weather_app/model/weather_entity.dart';
import 'package:simple_weather_app/repositories_services/weather/weather_repository.dart';

class WeatherRepositoryImp implements WeatherRepository {
  late WeatherApi _weatherApi;
  late String _weatherApiKey;

  @override
  Future<Result<List<WeatherEntity>>> getFilterdedForecastByLocation(
      double lat, double lon) async {
    try {
      final List<WeatherEntity> forecast = [];
      final List values = await _weatherApi.getForecastByLocation(lat, lon);
      for (final value in values) {
        forecast.add(WeatherEntity.fromJson(value));
      }
      return Success(forecast);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<List<WeatherEntity>>> getFilteredForecastByCity(
      String city) async {
    try {
      final List<WeatherEntity> forecast = [];
      final List values = await _weatherApi.getForecastByCity(city);
      for (final value in values) {
        forecast.add(WeatherEntity.fromWeather(value));
      }
      return Success(forecast);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<WeatherEntity>> getWeatherByCity(String city) async {
    try {
      final value = await _weatherApi.getWeatherByCity(city);
      return Success(WeatherEntity.fromWeather(value));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<WeatherEntity>> getWeatherByLocation(
      double lat, double lon) async {
    try {
      final value = await _weatherApi.getWeatherByLocation(lat, lon);
      return Success(WeatherEntity.fromWeather(value));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<bool>> init() async {
    try {
      _weatherApi = WeatherApiImp.instance;
      _weatherApiKey = dotenv.env['WEATHER_KEY']!;
      await _weatherApi.initApi(_weatherApiKey);
      return Success(true);
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
