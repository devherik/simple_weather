import 'package:flutter/material.dart';
import 'package:simple_weather_app/domain/entities/weather_entity.dart';
import 'package:simple_weather_app/presentation/controllers/weather_controller.dart';
import 'package:simple_weather_app/presentation/features/my_widgets.dart';

class DetailedWeatherPage extends StatefulWidget {
  const DetailedWeatherPage({super.key, required wcontroll, required wentity})
      : _weatherController = wcontroll,
        _weather = wentity;
  final WeatherController _weatherController;
  final WeatherEntity _weather;

  @override
  State<DetailedWeatherPage> createState() => _DetailedWeatherPageState();
}

class _DetailedWeatherPageState extends State<DetailedWeatherPage> {
  late MyWidgets _widgets;
  @override
  void initState() {
    super.initState();
    _widgets =
        MyWidgets(parentContext: context, wcontroll: widget._weatherController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: _widgets.detailedWeather(widget._weather)),
    );
  }
}
