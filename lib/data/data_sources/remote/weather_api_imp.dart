import 'package:simple_weather_app/domain/entities/weather_entity.dart';
import 'package:simple_weather_app/infra/port/input/weather_api.dart';
import 'package:weather/weather.dart';

class WeatherApiImp implements WeatherApi {
  WeatherApiImp({required this.key});
  @override
  final String key;
  WeatherFactory? _factory;

  @override
  getWeatherByCity(String city) async {
    final Weather value = await _factory!.currentWeatherByCityName(city);
    final WeatherEntity weather = WeatherEntity(
        value.areaName,
        value.country,
        value.date,
        value.weatherDescription,
        value.tempMax!.celsius,
        value.tempMin!.celsius,
        value.tempFeelsLike!.celsius,
        value.sunrise,
        value.sunset);
    return weather;
  }

  @override
  getWeatherByLocation(double lat, double lon) async {
    final Weather value = await _factory!.currentWeatherByLocation(lat, lon);
    final WeatherEntity weather = WeatherEntity(
        value.areaName,
        value.country,
        value.date,
        value.weatherDescription,
        value.tempMax!.celsius,
        value.tempMin!.celsius,
        value.tempFeelsLike!.celsius,
        value.sunrise,
        value.sunset);
    return weather;
  }

  @override
  getForecastByCity(String city) async {
    final List<Weather> values =
        await _factory!.fiveDayForecastByCityName(city);
    final List<WeatherEntity> forecast = [];
    for (var value in values) {
      final WeatherEntity weather = WeatherEntity(
          value.areaName,
          value.country,
          value.date,
          value.weatherDescription,
          value.tempMax!.celsius,
          value.tempMin!.celsius,
          value.tempFeelsLike!.celsius,
          value.sunrise,
          value.sunset);
      forecast.add(weather);
    }
    return forecast;
  }

  @override
  initAPI() {
    _factory = WeatherFactory(key);
  }
}
