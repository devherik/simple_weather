import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:simple_weather_app/domain/entities/weather_entity.dart';
import 'package:simple_weather_app/presentation/controllers/weather_controller.dart';
import 'package:simple_weather_app/presentation/features/my_widgets.dart';
import 'package:simple_weather_app/utils/constant/my_util.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required wcontroll})
      : _weatherController = wcontroll;
  final WeatherController _weatherController;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchTextController = TextEditingController();
  late MyUtil _util;
  late MyWidgets _widgets;
  @override
  void initState() {
    super.initState();
    _searchTextController.addListener(() => setState(() {}));
    _util = MyUtil.instance;
    _widgets =
        MyWidgets(parentContext: context, wcontroll: widget._weatherController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: TextFormField(
          controller: _searchTextController,
          maxLines: 1,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.labelMedium,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              label: Text('Pesquise aqui...',
                  style: Theme.of(context).textTheme.labelLarge)),
        ),
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: Builder(
            builder: (context) => IconButton(
                icon: Icon(
                  Iconsax.add,
                  color: Theme.of(context).colorScheme.primary,
                  size: 36,
                ),
                onPressed: () {})),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder(
            future: widget._weatherController
                .getWeatherByCity(_searchTextController.text.trim()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _widgets.detailedWeather(snapshot.data!);
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }

  Widget weatherCard(WeatherEntity weather) {
    final filteredForecast = <WeatherEntity>[weather.forecast[0]];
    int day = weather.forecast[0].dateTime!.day;
    for (var w in weather.forecast) {
      if (w.dateTime!.day != day) {
        filteredForecast.add(w);
        day = w.dateTime!.day;
      }
    }
    return Card(
      elevation: 2,
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(weather.cityName!,
                        style: Theme.of(context).textTheme.bodyLarge),
                    Text(weather.country!,
                        style: Theme.of(context).textTheme.labelLarge),
                    Text(
                        '${weather.dateTime!.day.toString()}/${weather.dateTime!.month.toString()}',
                        style: Theme.of(context).textTheme.labelLarge)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _util.withWeatherIcon(weather.condition!),
                        Text(' ${weather.temp!.toStringAsFixed(0)}°',
                            style: Theme.of(context).textTheme.titleMedium)
                      ],
                    ),
                    Text(
                        '${weather.minTemp!.toStringAsFixed(0)}°/${weather.maxTemp!.toStringAsFixed(0)}°',
                        style: Theme.of(context).textTheme.labelLarge)
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
