import 'package:weather/weather.dart';

class WeatherEntity {
  String? cityName;
  String? country;
  DateTime? dateTime;
  String? weather;
  int? condition;
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
      this.condition,
      this.temp,
      this.maxTemp,
      this.minTemp,
      this.feelsTemp,
      this.sunRise,
      this.sunSet);

  factory WeatherEntity.fromJson(Map<dynamic, dynamic> json) {
    return WeatherEntity(
        json['cityName'],
        json['country'],
        DateTime.parse(json['dateTime']),
        json['weather'],
        json['condition'],
        json['temp'],
        json['maxTemp'],
        json['minTemp'],
        json['feelsTemp'],
        DateTime.parse(json['sunRise']),
        DateTime.parse(json['sunSet']));
  }

  factory WeatherEntity.empty() {
    return WeatherEntity('Empty', 'Empty', DateTime.now(), 'Weather', 0, 0, 0,
        0, 0, DateTime.now(), DateTime.now());
  }

  factory WeatherEntity.fromWeather(Weather weather) {
    return WeatherEntity(
        weather.areaName,
        weather.country,
        weather.date,
        weather.weatherDescription,
        weather.weatherConditionCode,
        weather.temperature!.celsius,
        weather.tempMax!.celsius,
        weather.tempMin!.celsius,
        weather.tempFeelsLike!.celsius,
        weather.sunrise,
        weather.sunset);
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'cityName': cityName,
      'country': country,
      'dateTime': dateTime.toString(),
      'weather': weather,
      'condition': condition,
      'temp': temp,
      'maxTemp': maxTemp,
      'minTemp': minTemp,
      'feelsTemp': feelsTemp,
      'sunRise': sunRise.toString(),
      'sunSet': sunSet.toString()
    };
  }

  String getHour() => '${dateTime!.hour}:${dateTime!.minute}';

  @override
  String toString() {
    return '$cityName, $dateTime\n$weather\n$temp\nMax: $maxTemp\nMin: $minTemp';
  }
}
