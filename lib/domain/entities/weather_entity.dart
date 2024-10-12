class WeatherEntity {
  String? cityName;
  String? country;
  DateTime? dateTime;
  String? weather;
  double? maxTemp;
  double? minTemp;
  double? feelsTemp;
  DateTime? sunRise;
  DateTime? sunSet;

  WeatherEntity(this.cityName, this.country, this.dateTime, this.weather,
      this.maxTemp, this.minTemp, this.feelsTemp, this.sunRise, this.sunSet);

  @override
  String toString() {
    return '$cityName, $dateTime\n$weather\nMax: $maxTemp\nMin: $minTemp';
  }
}
