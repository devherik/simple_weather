import 'package:simple_weather_app/infra/port/input/weather_api.dart';
import 'package:weather/weather.dart';

class WeatherApiImp implements WeatherApi {
  WeatherApiImp._();
  static final WeatherApiImp instance = WeatherApiImp._();
  late WeatherFactory _factory;

  @override
  Future<void> initApi(String key) async {
    try {
      _factory = WeatherFactory(key);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<Weather> getWeatherByCity(String city) async {
    try {
      final Weather value = await _factory.currentWeatherByCityName(city);
      return value;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<Weather> getWeatherByLocation(double lat, double lon) async {
    try {
      final Weather value = await _factory.currentWeatherByLocation(lat, lon);
      return value;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<List<Weather>> getForecastByCity(String city) async {
    try {
      final List<Weather> values =
          await _factory.fiveDayForecastByCityName(city);
      return values;
    } on Exception {
      rethrow;
    }
  }

  @override
  getForecastByLocation(double lat, double lon) async {
    try {
      final List<Weather> values =
          await _factory.fiveDayForecastByLocation(lat, lon);
      return values;
    } on Exception {
      rethrow;
    }
  }
}
