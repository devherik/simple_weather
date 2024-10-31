import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:simple_weather_app/core/constant/globals.dart' as global;

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
            ? 'assets/animations/clear.json'
            : 'assets/animations/clear_night.json';
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
        return const Icon(Iconsax.cloud_lightning, color: global.blue);
      case >= 300 && < 400:
        return const Icon(Iconsax.cloud_minus, color: global.blue);
      case >= 500 && < 600:
        return const Icon(Iconsax.cloud_minus, color: global.blue);
      case >= 600 && < 700:
        return const Icon(Iconsax.cloud_snow, color: Colors.grey);
      case 701:
        return const Icon(Iconsax.cloud_fog, color: Colors.grey);
      case 800:
        return Icon(Iconsax.sun_1, color: Colors.yellow.shade200);
      case >= 800 && < 900:
        return const Icon(Iconsax.cloud_fog, color: Colors.grey);
      default:
        return Icon(Iconsax.cloud_sunny, color: Colors.yellow.shade200);
    }
  }

  loaderBoxAnimation(BuildContext context, double heigh, double widght) =>
      SizedBox(
          width: widght,
          child: LinearProgressIndicator(
            minHeight: 20,
            color: Theme.of(context).colorScheme.primary,
          ));
}
