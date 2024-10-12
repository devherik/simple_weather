import 'package:simple_weather_app/infra/port/input/weather_api.dart';
import 'package:weather/weather.dart';

class WeatherApiImp implements WeatherApi {
  WeatherApiImp({required this.key});
  @override
  final String key;
  WeatherFactory? factory;

  @override
  getWeatherByCity(String city) async {
    final Weather weather = await factory!.currentWeatherByCityName(city);
    return weather;
  }

  @override
  getWeatherByLocation(double lat, double lon) async {
    final Weather weather = await factory!.currentWeatherByLocation(lat, lon);
    return weather;
  }

  @override
  getForecastByCity(String city) async {
    final List<Weather> forecast =
        await factory!.fiveDayForecastByCityName(city);
    return forecast;
  }

  @override
  initAPI() {
    factory = WeatherFactory(key);
  }
}
