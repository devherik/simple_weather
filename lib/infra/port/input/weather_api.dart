abstract class WeatherApi<T> {
  /* this model defines the way a weather api will be handle for the app
  if you change the api, the new one will work properly because it uses this
  model as reference*/
  WeatherApi({required this.key});
  final String key;
  T initAPI();
  T getWeatherByCity(String city);
  T getWeatherByLocation(double lat, double lon);
  T getForecastByCity(String city);
}