import 'package:flutter/material.dart';
import 'package:simple_weather_app/domain/entities/weather_entity.dart';
import 'package:simple_weather_app/presentation/controllers/weather_controller.dart';
import 'package:simple_weather_app/utils/constant/my_util.dart';

import 'package:simple_weather_app/utils/constant/globals.dart' as global;

class DetailedPage extends StatefulWidget {
  DetailedPage(
      {super.key,
      required parentContext,
      required wcontroll,
      required weatherData})
      : context = parentContext,
        weatherController = wcontroll,
        weather = weatherData;

  final BuildContext context;
  final WeatherController weatherController;
  final MyUtil util = MyUtil.instance;
  final WeatherEntity weather;

  @override
  State<DetailedPage> createState() => _DetailedPageState();
}

class _DetailedPageState extends State<DetailedPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(children: <Widget>[
        Flexible(
          flex: 5,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                locationWeatherPanel(),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Divider(
                    thickness: .5,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                forecastWeatherPanel()
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget locationWeatherPanel() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '${widget.weather.cityName!} - ${widget.weather.country!}',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          global.verySmallBoxSpace,
          Row(
            children: <Widget>[
              Text(
                '${widget.weather.temp!.toStringAsFixed(0)}°  ',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: [
                      Text('${widget.weather.maxTemp!.toStringAsFixed(0)}°',
                          style: Theme.of(context).textTheme.labelLarge),
                      Icon(
                        Icons.arrow_upward,
                        color: global.red,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text('${widget.weather.minTemp!.toStringAsFixed(0)}°',
                          style: Theme.of(context).textTheme.labelLarge),
                      Icon(
                        Icons.arrow_downward,
                        color: global.blue,
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      );

  Widget forecastWeatherPanel() => Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: widget.weather.forecast.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                      widget.util.weekDay(
                          widget.weather.forecast[index].dateTime!.weekday),
                      style: Theme.of(context).textTheme.labelLarge),
                  Row(
                    children: <Widget>[
                      Row(
                        children: [
                          widget.util.withWeatherIcon(
                              widget.weather.forecast[index].condition!),
                          Text(
                              '  ${widget.weather.forecast[index].maxTemp!.toStringAsFixed(0)}°',
                              style: Theme.of(context).textTheme.bodyLarge),
                          Icon(
                            Icons.arrow_upward,
                            color: global.red,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                              ' | ${widget.weather.forecast[index].minTemp!.toStringAsFixed(0)}°',
                              style: Theme.of(context).textTheme.bodyLarge),
                          Icon(
                            Icons.arrow_downward,
                            color: global.blue,
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      );
}
