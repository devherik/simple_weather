class WeatherEntity {
  String? cityName;
  String? country;
  DateTime? dateTime;
  String? weather;
  double? temp;
  double? maxTemp;
  double? minTemp;
  double? feelsTemp;
  DateTime? sunRise;
  DateTime? sunSet;
  List<WeatherEntity> forecast = [];

  WeatherEntity(
      this.cityName,
      this.country,
      this.dateTime,
      this.weather,
      this.temp,
      this.maxTemp,
      this.minTemp,
      this.feelsTemp,
      this.sunRise,
      this.sunSet);

  @override
  String toString() {
    return '$cityName, $dateTime\n$weather\n$temp\nMax: $maxTemp\nMin: $minTemp';
  }
}
