import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_weather_app/domain/entities/weather_entity.dart';
import 'package:simple_weather_app/presentation/controllers/main_controller.dart';
import 'package:simple_weather_app/presentation/features/detailed/detailed.dart';
import 'package:simple_weather_app/utils/constant/my_util.dart';
import 'package:simple_weather_app/presentation/controllers/weather_controller.dart';
import 'package:simple_weather_app/utils/constant/globals.dart' as global;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late WeatherController _weatherController;
  late MyUtil util;
  late MainController _mainController;

  late AnimationController animationController;
  late Animation<double> turnController;

  late String today;

  @override
  void initState() {
    super.initState();
    _weatherController = WeatherController.instance;
    _mainController = MainController.instance;
    util = MyUtil.instance;

    _weatherController.initController();

    _mainController.weatherUnit$.addListener(
        () => setState(() async => await _weatherController.updateWeather()));
    _mainController.themeMode$.addListener(() => setState(() {}));

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..stop();
    turnController =
        CurvedAnimation(parent: animationController, curve: Curves.easeOutCirc);

    today = util.weekDay(DateTime.now().weekday);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FutureBuilder(
                    future: _weatherController.initController(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final WeatherEntity weatherEntity = snapshot.data!;
                        return Column(
                          children: <Widget>[
                            global.smallBoxSpace,
                            currentWeatherDescription(weatherEntity),
                            global.mediumBoxSpace,
                            currentWeatherForecast(weatherEntity),
                            global.smallBoxSpace,
                            Card(
                              color: Theme.of(context).colorScheme.secondary,
                              elevation: 1,
                              child: Flexible(
                                  child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: MaterialButton(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 24, horizontal: 12),
                                  minWidth: MediaQuery.of(context).size.width,
                                  onPressed: () {
                                    context.push('/search',
                                        extra: {'weather': _weatherController});
                                  },
                                  splashColor:
                                      Theme.of(context).colorScheme.secondary,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Iconsax.search_favorite,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                      ),
                                      Text(
                                        ' Pesquisar',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary,
                                            letterSpacing: 3,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                            )
                          ],
                        );
                      } else {
                        return Center();
                      }
                    }),
                // FutureBuilder(
                //   future: _weatherController.getUserCitiesWeather(),
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       final List<WeatherEntity> weathers = snapshot.data!;
                //       return userWeathersLocation(weathers);
                //     } else {
                //       return Center();
                //     }
                //   },
                // ),
                global.smallBoxSpace,
                apiLicenseDescription()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget currentWeatherDescription(WeatherEntity weatherEntity) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Builder(
                builder: (context) => IconButton(
                    icon: Icon(
                      Iconsax.setting,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    onPressed: () => context.push('/settings', extra: {
                          'weather': _weatherController,
                          'main': _mainController
                        }))),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${weatherEntity.cityName!} ',
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '$today | ${weatherEntity.getHour()}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Builder(
                      builder: (context) => IconButton(
                          iconSize: 15,
                          icon: RotationTransition(
                            turns: turnController,
                            child: Icon(
                              Iconsax.refresh,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                          onPressed: () async {
                            await _weatherController.updateWeather();
                            animationController.forward().whenComplete(
                                  () => animationController.reset(),
                                );
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        global.verySmallBoxSpace,
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${weatherEntity.temp!.toStringAsFixed(0)}°',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Column(
                  children: [
                    Text(
                      util.withWeather(weatherEntity.condition!),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Row(
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                                '  ${weatherEntity.maxTemp!.toStringAsFixed(0)}°',
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
                                ' | ${weatherEntity.minTemp!.toStringAsFixed(0)}°',
                                style: Theme.of(context).textTheme.bodyLarge),
                            Icon(
                              Icons.arrow_downward,
                              color: global.blue,
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Flexible(
              child: Lottie.asset(
                  util.withWeatherAnimation(weatherEntity.condition!),
                  alignment: Alignment.center),
            ),
          ],
        )
      ],
    );
  }

  Widget currentWeatherForecast(WeatherEntity weatherEntity) {
    return Card(
      color: Theme.of(context).colorScheme.secondary,
      elevation: 1,
      child: Flexible(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Próximos dias',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              global.smallBoxSpace,
              SizedBox(
                  height: 2,
                  width: MediaQuery.of(context).size.width * .7,
                  child: Divider(
                    thickness: .5,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  )),
              global.verySmallBoxSpace,
              SizedBox(
                height: MediaQuery.of(context).size.height * .30,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: weatherEntity.forecast.length,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: weatherCard(weatherEntity.forecast[index]),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget userWeathersLocation(List<WeatherEntity> weathers) {
    return Card(
      color: Theme.of(context).colorScheme.secondary,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Minhas cidades',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyLarge),
                Builder(
                    builder: (context) => IconButton(
                        icon: Icon(
                          Iconsax.search_normal,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                        onPressed: () => context.push('/search',
                            extra: {'weather': _weatherController}))),
              ],
            ),
            global.verySmallBoxSpace,
            SizedBox(
                height: 2,
                width: MediaQuery.of(context).size.width * .7,
                child: Divider(
                  thickness: .5,
                  color: Theme.of(context).colorScheme.inversePrimary,
                )),
            global.verySmallBoxSpace,
            SizedBox(
              height: MediaQuery.of(context).size.height * .5,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: weathers.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemExtent: 80,
                  itemBuilder: (context, index) =>
                      locationWeatherButton(weathers[index])),
            )
          ],
        ),
      ),
    );
  }

  Widget locationWeatherButton(WeatherEntity weather) => MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              scrollControlDisabledMaxHeightRatio:
                  MediaQuery.of(context).size.height * .8,
              builder: (context) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height * .8,
                    child: weatherPresentationModal(weather));
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              util.weekDay(weather.dateTime!.weekday),
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            util.withWeatherIcon(weather.condition!),
            const SizedBox(
              width: 15,
            ),
            Text('${weather.maxTemp!.toStringAsFixed(0)}°',
                style: Theme.of(context).textTheme.labelLarge),
            Icon(
              Icons.arrow_upward,
              color: global.red,
            ),
            const SizedBox(
              width: 15,
            ),
            Text('${weather.minTemp!.toStringAsFixed(0)}°',
                style: Theme.of(context).textTheme.labelLarge),
            Icon(
              Icons.arrow_downward,
              color: global.blue,
            )
          ],
        ),
      ],
    );
  }

  Widget weatherPresentationModal(WeatherEntity weather) {
    return Scaffold(
      body: Container(
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
              Expanded(
                child: DetailedPage(
                  parentContext: context,
                  wcontroll: _weatherController,
                  weatherData: weather,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget apiLicenseDescription() => Align(
        alignment: Alignment.center,
        child: Text(
          'License by OpenWeatherMap',
          style: Theme.of(context).textTheme.labelSmall,
        ),
      );
}
