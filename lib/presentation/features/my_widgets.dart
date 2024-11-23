import 'package:flutter/material.dart';
import 'package:simple_weather_app/domain/entities/weather_entity.dart';
import 'package:simple_weather_app/utils/constant/my_util.dart';

import 'package:simple_weather_app/utils/constant/globals.dart' as global;

class MyWidgets {
  MyWidgets({required parentContext, required wcontroll})
      : context = parentContext;

  final BuildContext context;
  final MyUtil util = MyUtil.instance;

  Widget detailedWeather(WeatherEntity weather) {
    final filteredForecast = <WeatherEntity>[weather.forecast[0]];
    int day = weather.forecast[0].dateTime!.day;
    for (var w in weather.forecast) {
      if (w.dateTime!.day != day) {
        filteredForecast.add(w);
        day = w.dateTime!.day;
      }
    }
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${weather.cityName!} - ${weather.country!}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              global.verySmallBoxSpace,
              Row(
                children: <Widget>[
                  Text(
                    '${weather.temp!.toStringAsFixed(0)}°  ',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Text('${weather.maxTemp!.toStringAsFixed(0)}°',
                              style: Theme.of(context).textTheme.labelLarge),
                          Icon(
                            Icons.arrow_upward,
                            color: global.red,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text('${weather.minTemp!.toStringAsFixed(0)}°',
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
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Divider(
              thickness: .5,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: filteredForecast.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                        util.weekDay(filteredForecast[index].dateTime!.weekday),
                        style: Theme.of(context).textTheme.labelLarge),
                    Row(
                      children: <Widget>[
                        Row(
                          children: [
                            util.withWeatherIcon(
                                filteredForecast[index].condition!),
                            Text(
                                '  ${filteredForecast[index].maxTemp!.toStringAsFixed(0)}°',
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
                                ' | ${filteredForecast[index].minTemp!.toStringAsFixed(0)}°',
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
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
