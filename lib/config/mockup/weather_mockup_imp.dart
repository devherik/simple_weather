import 'package:simple_weather_app/infra/port/input/weather_api.dart';
import 'package:weather/weather.dart';

class WeatherMockupImp implements WeatherApi {
  WeatherMockupImp._privateConstructor();
  static final WeatherMockupImp instance =
      WeatherMockupImp._privateConstructor();
  final Weather _weatherData = Weather({
    "coord": {"lon": 7.367, "lat": 45.133},
    "weather": [
      {"id": 501, "main": "Rain", "description": "moderate rain", "icon": "10d"}
    ],
    "base": "stations",
    "main": {
      "temp": 284.2,
      "feels_like": 282.93,
      "temp_min": 283.06,
      "temp_max": 286.82,
      "pressure": 1021,
      "humidity": 60,
      "sea_level": 1021,
      "grnd_level": 910
    },
    "visibility": 10000,
    "wind": {"speed": 4.09, "deg": 121, "gust": 3.47},
    "rain": {"1h": 2.73},
    "clouds": {"all": 83},
    "dt": 1726660758,
    "sys": {
      "type": 1,
      "id": 6736,
      "country": "IT",
      "sunrise": 1726636384,
      "sunset": 1726680975
    },
    "timezone": 7200,
    "id": 3165523,
    "name": "Province of Turin",
    "cod": 200
  });

  @override
  getForecastByCity(String city) {
    final List<Weather> forecast = [_weatherData, _weatherData];
    return forecast;
  }

  @override
  getForecastByLocation(double lat, double lon) {
    final List<Weather> forecast = [_weatherData, _weatherData];
    return forecast;
  }

  @override
  getWeatherByCity(String city) {
    return _weatherData;
  }

  @override
  getWeatherByLocation(double lat, double lon) {
    return _weatherData;
  }

  @override
  initAPI(String key) {}
}
