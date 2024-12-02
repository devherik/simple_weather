import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:simple_weather_app/presentation/features/my_widgets.dart';
import 'package:simple_weather_app/utils/constant/my_util.dart';
import 'package:simple_weather_app/domain/entities/weather_entity.dart';
import 'package:simple_weather_app/presentation/controllers/weather_controller.dart';
import 'package:simple_weather_app/utils/constant/globals.dart' as global;

class HomeWidgets {
  HomeWidgets({required parentContext, required wcontroll, final mywidgets})
      : context = parentContext,
        _weatherController = wcontroll,
        myWidgets = mywidgets;

  final BuildContext context;
  final WeatherController _weatherController;
  final MyUtil util = MyUtil.instance;
  final MyWidgets myWidgets;

  Widget userWeathersLocation() {
    return ValueListenableBuilder(
      valueListenable: _weatherController.userWeathers$,
      builder: (context, value, child) {
        if (value.isEmpty) {
          return Center(
              child: Text(
                  'Acompanhe o tempo em outras cidades\nFaça uma pesquisa acima',
                  style: Theme.of(context).textTheme.labelMedium));
        } else {
          return ListView.builder(
              itemCount: value.length,
              physics: NeverScrollableScrollPhysics(),
              itemExtent: 80,
              itemBuilder: (context, index) =>
                  locationWeatherButton(value[index]));
        }
      },
    );
  }

  Widget locationWeatherButton(WeatherEntity weather) => MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return weatherPresentationModal(weather);
              });
        },
        splashColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Icon(
              Iconsax.location,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            Text(
              ' ${weather.cityName!} | ${weather.temp!.toStringAsFixed(0)}° ',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  letterSpacing: 3,
                  fontSize: 16),
            ),
            util.withWeatherIcon(weather.condition!),
          ],
        ),
      );

  Widget weatherCard(WeatherEntity weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${weather.maxTemp!.toStringAsFixed(0)}° ',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            util.withWeatherIcon(weather.condition!),
          ],
        ),
        Text(
          util.weekDay(weather.dateTime!.weekday),
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }

  Widget weatherPresentationModal(WeatherEntity weather) {
    //TODO: add a pinned buttom to save it
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 30,
              child: Divider(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  thickness: 3),
            ),
            global.smallBoxSpace,
            Expanded(child: myWidgets.detailedWeather(weather)),
          ],
        ),
      ),
    );
  }
}
