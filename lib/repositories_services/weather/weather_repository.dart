import 'package:result_dart/result_dart.dart';
import 'package:simple_weather_app/model/weather_entity.dart';

abstract class WeatherRepository {
  Future<Result<bool>> init();
  Future<Result<WeatherEntity>> getWeatherByLocation(double lat, double lon);
  Future<Result<WeatherEntity>> getWeatherByCity(String city);
  Future<Result<List<WeatherEntity>>> getFilteredForecastByCity(String city);
  Future<Result<List<WeatherEntity>>> getFilterdedForecastByLocation(
      double lat, double lon);
}
