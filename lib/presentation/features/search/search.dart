import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:simple_weather_app/domain/entities/weather_entity.dart';
import 'package:simple_weather_app/presentation/controllers/weather_controller.dart';
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
          style: Theme.of(context).textTheme.labelMedium,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              label: Text('Pesquise aqui...',
                  style: Theme.of(context).textTheme.labelLarge)),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 200,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Builder(
                  builder: (context) => IconButton(
                      icon: Icon(
                        Iconsax.close_circle,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      onPressed: () => {})),
              Builder(
                  builder: (context) => IconButton(
                      icon: Icon(
                        Iconsax.save_2,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      onPressed: () {})),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
              future: widget._weatherController
                  .getForecastByCity(_searchTextController.text.trim()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data!.length,
                    itemExtent: MediaQuery.of(context).size.width * .20,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) =>
                        weatherCard(snapshot.data![index]),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ),
      ),
    );
  }

  Widget weatherCard(WeatherEntity weather) => Card(
        elevation: 1,
        color: Theme.of(context).colorScheme.tertiary,
        child: Row(
          children: [
            Column(
              children: <Widget>[
                Text(weather.cityName!,
                    style: Theme.of(context).textTheme.titleSmall),
                Text(weather.country!,
                    style: Theme.of(context).textTheme.labelMedium),
                Text(weather.getHour(),
                    style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _util.withWeatherIcon(weather.condition!),
                    Text(weather.temp!.toString(),
                        style: Theme.of(context).textTheme.titleMedium)
                  ],
                ),
                Text('${weather.minTemp!} / ${weather.maxTemp!}',
                    style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
          ],
        ),
      );
}
