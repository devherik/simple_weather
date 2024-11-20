import 'package:simple_weather_app/infra/port/input/weather_api.dart';
import 'package:weather/weather.dart';

class WeatherApiImp implements WeatherApi {
  WeatherApiImp._privateConstructor();
  static final WeatherApiImp instance = WeatherApiImp._privateConstructor();
  WeatherFactory? _factory;

  @override
  initAPI(String key) async {
    try {
      _factory = WeatherFactory(key);
    } on Exception {
      rethrow;
    }
  }

  @override
  getWeatherByCity(String city) async {
    try {
      final Weather value = await _factory!.currentWeatherByCityName(city);
      return value;
    } on Exception {
      rethrow;
    }
  }

  @override
  getWeatherByLocation(double lat, double lon) async {
    try {
      final Weather value = await _factory!.currentWeatherByLocation(lat, lon);
      return value;
    } on Exception {
      rethrow;
    }
  }

  @override
  getForecastByCity(String city) async {
    try {
      final List<Weather> values =
          await _factory!.fiveDayForecastByCityName(city);
      return values;
    } on Exception {
      rethrow;
    }
  }

  @override
  getForecastByLocation(double lat, double lon) async {
    try {
      final List<Weather> values =
          await _factory!.fiveDayForecastByLocation(lat, lon);
      return values;
    } on Exception {
      rethrow;
    }
  }
}
