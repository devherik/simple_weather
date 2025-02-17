import 'package:flutter/material.dart';
import 'package:simple_weather_app/repositories_services/weather/weather_repository.dart';
import 'package:simple_weather_app/repositories_services/weather/weather_repository_imp.dart';
import 'package:weather/weather.dart';

class WeatherViewmodel {
  final WeatherRepositoryImp _weatherRepository;
  final ValueNotifier<Weather?> weatherNotifier = ValueNotifier<Weather?>(null);
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<String?> errorMessage = ValueNotifier<String?>(null);

  WeatherViewmodel(this._weatherRepository);

  Future<void> fetchWeather(String city) async {
    isLoading.value = true;
    final result = await _weatherRepository.getWeatherByCity(city);
    result.fold(
      success: (weather) {
        weatherNotifier.value = weather;
        isLoading.value = false;
      },
      failure: (error) {
        errorMessage.value = error.toString();
        isLoading.value = false;
      },
    );
  }

  Future<void> fetchForecast(String city) async {
    isLoading.value = true;
    final result = await _weatherRepository.getForecastByCity(city);
    result.fold(
      success: (forecast) {
        weatherNotifier.value = forecast.first;
        isLoading.value = false;
      },
      failure: (error) {
        errorMessage.value = error.toString();
        isLoading.value = false;
      },
    );
  }
}
