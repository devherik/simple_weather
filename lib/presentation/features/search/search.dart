import 'package:flutter/material.dart';
import 'package:simple_weather_app/domain/entities/weather_entity.dart';
import 'package:simple_weather_app/presentation/controllers/weather_controller.dart';
import 'package:simple_weather_app/presentation/features/detailed/detailed.dart';
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
  @override
  void initState() {
    super.initState();
    _searchTextController.addListener(() => setState(() {}));
    _util = MyUtil.instance;
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
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              label: Text('Pesquise aqui...',
                  style: Theme.of(context).textTheme.labelLarge)),
        ),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
              future: widget._weatherController
                  .getWeatherByCity(_searchTextController.text.trim()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DetailedPage(
                    parentContext: context,
                    wcontroll: widget._weatherController,
                    weatherData: snapshot.data,
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ),
      ),
    );
  }

  Widget weatherCard(WeatherEntity weather) {
    return Card(
      elevation: 2,
      color: Colors.transparent.withOpacity(.5),
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
