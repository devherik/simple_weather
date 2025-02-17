abstract class WeatherApi<T> {
  /* this model defines the way a weather api will be handle for the app
  if you change the api, the new one will work properly because it uses this
  model as reference*/
  Future<void> initApi(String key);
  Future<T> getWeatherByCity(String city);
  Future<T> getWeatherByLocation(double lat, double lon);
  Future<T> getForecastByCity(String city);
  Future<List<T>> getForecastByLocation(double lat, double lon);
}
