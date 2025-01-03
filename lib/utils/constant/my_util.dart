import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:simple_weather_app/utils/constant/globals.dart' as global;
import 'package:weather_icons/weather_icons.dart';

class MyUtil {
  MyUtil._privateConstructor();
  static final instance = MyUtil._privateConstructor();

  String weekDay(int day) {
    switch (day) {
      case 1:
        return 'Segunda';
      case 2:
        return 'Terça';
      case 3:
        return 'Quarta';
      case 4:
        return 'Quinta';
      case 5:
        return 'Sexta';
      case 6:
        return 'Sábado';
      case 7:
        return 'Domingo';
      default:
        return 'não sei';
    }
  }

  String withWeatherAnimation(int code) {
    switch (code) {
      case >= 200 && < 300:
        return 'assets/animations/thunder.json';
      case >= 300 && < 400:
        return 'assets/animations/partly_rain.json';
      case >= 500 && < 600:
        return DateTime.now().hour > 18 || DateTime.now().hour < 6
            ? 'assets/animations/rainy_night.json'
            : 'assets/animations/rainy.json';
      case >= 600 && < 700:
        return DateTime.now().hour > 18 || DateTime.now().hour < 6
            ? 'assets/animations/snow_day.json'
            : 'assets/animations/snow_night.json';
      case 701:
        return 'assets/animations/mist.json';
      case 800:
        return DateTime.now().hour > 18 || DateTime.now().hour < 6
            ? 'assets/animations/clear_night.json'
            : 'assets/animations/clear.json';
      case >= 800 && < 900:
        return DateTime.now().hour > 18 || DateTime.now().hour < 6
            ? 'assets/animations/cloud_night.json'
            : 'assets/animations/cloud.json';
      default:
        return 'assets/animations/clear.json';
    }
  }

  Icon withWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return const Icon(WeatherIcons.thunderstorm, color: global.blue);
      case >= 300 && < 400:
        return const Icon(WeatherIcons.raindrops, color: global.blue);
      case >= 500 && < 600:
        return const Icon(WeatherIcons.rain, color: global.blue);
      case >= 600 && < 700:
        return const Icon(WeatherIcons.snow, color: Colors.grey);
      case 701:
        return const Icon(WeatherIcons.fog, color: Colors.grey);
      case 800:
        return const Icon(WeatherIcons.day_sunny, color: global.red);
      case >= 800 && < 900:
        return const Icon(WeatherIcons.cloud, color: Colors.grey);
      default:
        return const Icon(Iconsax.cloud_sunny, color: global.red);
    }
  }

  String withWeather(int code) {
    switch (code) {
      case >= 200 && < 300:
        return 'Chuva intensa';
      case >= 300 && < 400:
        return 'Chuva leve';
      case >= 500 && < 600:
        return 'Chuva';
      case >= 600 && < 700:
        return 'Neve';
      case 701:
        return 'Nevoeiro';
      case 800:
        return 'Tempo limpo';
      case >= 800 && < 900:
        return 'Nublado';
      default:
        return '';
    }
  }

  void notificationToast(BuildContext context, String label, Color color) {
    final snack = SnackBar(
      content: Text(
        label,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      backgroundColor: color.withOpacity(.5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  loaderBoxAnimation(BuildContext context, double heigh, double widght) =>
      SizedBox(
          width: widght,
          child: LinearProgressIndicator(
            minHeight: 20,
            color: Theme.of(context).colorScheme.tertiary,
            backgroundColor: Theme.of(context).colorScheme.primary,
          ));
}
