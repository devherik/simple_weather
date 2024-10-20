import 'package:simple_weather_app/infra/port/input/weather_api.dart';
import 'package:weather/weather.dart';

class WeatherApiImp implements WeatherApi {
  WeatherApiImp._privateConstructor();
  static final WeatherApiImp instance = WeatherApiImp._privateConstructor();
  WeatherFactory? _factory;

  @override
  initAPI(String key) async {
    _factory = WeatherFactory(key);
  }

  @override
  getWeatherByCity(String city) async {
    final Weather value = await _factory!.currentWeatherByCityName(city);
    return value;
  }

  @override
  getWeatherByLocation(double lat, double lon) async {
    final Weather value = await _factory!.currentWeatherByLocation(lat, lon);
    return value;
  }

  @override
  getForecastByCity(String city) async {
    final List<Weather> values =
        await _factory!.fiveDayForecastByCityName(city);
    return values;
  }

  @override
  getForecastByLocation(double lat, double lon) async {
    final List<Weather> values =
        await _factory!.fiveDayForecastByLocation(lat, lon);
    return values;
  }
}
