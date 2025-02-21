import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:result_dart/result_dart.dart';
import 'package:simple_weather_app/config/mockup/weather_mockup_imp.dart';
import 'package:simple_weather_app/data/data_sources/remote/weather_api_imp.dart';
import 'package:simple_weather_app/infra/port/input/weather_api.dart';
import 'package:simple_weather_app/model/weather_entity.dart';
import 'package:simple_weather_app/repositories_services/weather/weather_repository.dart';

class WeatherRepositoryImp implements WeatherRepository {
  WeatherRepositoryImp._();
  static final instance = WeatherRepositoryImp._();

  late WeatherApi _weatherApi;
  late String _weatherApiKey;

  bool _status = false;

  @override
  Future<Result<List<WeatherEntity>>> getFilterdedForecastByLocation(
      double lat, double lon) async {
    try {
      final List<WeatherEntity> forecast = [];
      final List values = await _weatherApi.getForecastByLocation(lat, lon);
      for (final value in values) {
        forecast.add(WeatherEntity.fromWeather(value));
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
    if (!_status) {
      try {
        _weatherApi = WeatherMockupImp.instance;
        //_weatherApi = WeatherApiImp.instance;
        await dotenv.load();
        _weatherApiKey = dotenv.env['WEATHER_KEY']!;
        await _weatherApi.initApi(_weatherApiKey);
        _status = true;
        return Success(_status);
      } on Exception catch (e) {
        return Failure(e);
      }
    } else {
      return Success(_status);
    }
  }
}
