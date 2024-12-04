import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:simple_weather_app/domain/entities/weather_entity.dart';
import 'package:simple_weather_app/presentation/controllers/weather_controller.dart';
import 'package:simple_weather_app/utils/constant/my_util.dart';

import 'package:simple_weather_app/utils/constant/globals.dart' as global;

class MyWidgets {
  MyWidgets({required parentContext, required wcontroll})
      : context = parentContext,
        weatherController = wcontroll;

  final BuildContext context;
  final WeatherController weatherController;
  final MyUtil util = MyUtil.instance;

  Widget detailedWeather(WeatherEntity weather, bool isFixed) {
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
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerRight,
                        child: Builder(
                            builder: (context) => IconButton(
                                tooltip: isFixed
                                    ? 'Remover dos favoritos'
                                    : 'Adcionar aos favoritos',
                                icon: Icon(
                                  isFixed
                                      ? Iconsax.save_minus5
                                      : Iconsax.save_add5,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                                onPressed: () {
                                  isFixed
                                      ? weatherController
                                          .removeUserCity(weather.cityName!)
                                      : weatherController
                                          .addUserCity(weather.cityName!);
                                })),
                      ),
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
                                  Text(
                                      '${weather.maxTemp!.toStringAsFixed(0)}°',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge),
                                  Icon(
                                    Icons.arrow_upward,
                                    color: global.red,
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                      '${weather.minTemp!.toStringAsFixed(0)}°',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge),
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
      ]),
    );
  }
}
