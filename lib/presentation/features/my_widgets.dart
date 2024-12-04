import 'package:flutter/material.dart';
import 'package:simple_weather_app/domain/entities/weather_entity.dart';
import 'package:simple_weather_app/utils/constant/my_util.dart';

import 'package:simple_weather_app/utils/constant/globals.dart' as global;

class MyWidgets {
  MyWidgets({required parentContext, required wcontroll})
      : context = parentContext;

  final BuildContext context;
  final MyUtil util = MyUtil.instance;

  Widget detailedWeather(WeatherEntity weather, bool isFixed) {
    return Stack(children: <Widget>[
      Positioned(
        top: 0,
        right: 10,
        child: MaterialButton(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
          splashColor: Theme.of(context).colorScheme.secondary,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              Icon(Icons.pin_drop),
              Text(
                isFixed ? 'Fixado' : 'Fixar',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
          onPressed: () {},
        ),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                    style:
                                        Theme.of(context).textTheme.labelLarge),
                                Icon(
                                  Icons.arrow_upward,
                                  color: global.red,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text('${weather.minTemp!.toStringAsFixed(0)}°',
                                    style:
                                        Theme.of(context).textTheme.labelLarge),
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
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: weather.forecast.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              util.weekDay(
                                  weather.forecast[index].dateTime!.weekday),
                              style: Theme.of(context).textTheme.labelLarge),
                          Row(
                            children: <Widget>[
                              Row(
                                children: [
                                  util.withWeatherIcon(
                                      weather.forecast[index].condition!),
                                  Text(
                                      '  ${weather.forecast[index].maxTemp!.toStringAsFixed(0)}°',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                  Icon(
                                    Icons.arrow_upward,
                                    color: global.red,
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                      ' | ${weather.forecast[index].minTemp!.toStringAsFixed(0)}°',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
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
              )
            ],
          ),
        ),
      )
    ]);
  }
}
