import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_weather_app/domain/entities/weather_entity.dart';
import 'package:simple_weather_app/presentation/controllers/main_controller.dart';
import 'package:simple_weather_app/presentation/features/my_widgets.dart';
import 'package:simple_weather_app/utils/constant/my_util.dart';
import 'package:simple_weather_app/presentation/features/home/home_widgets.dart';
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
  late HomeWidgets homeWidgets;
  late MyWidgets myWidgets;
  late MainController _mainController;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    _weatherController = WeatherController.instance;
    _mainController = MainController.instance;
    _weatherController.initController();
    util = MyUtil.instance;
    myWidgets =
        MyWidgets(parentContext: context, wcontroll: _weatherController);
    _mainController.weatherUnit$.addListener(
        () => setState(() async => await _weatherController.updateWeather()));
    homeWidgets = HomeWidgets(
        parentContext: context,
        wcontroll: _weatherController,
        mywidgets: myWidgets);
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..stop();
  }

  @override
  Widget build(BuildContext context) {
    final String today = util.weekDay(DateTime.now().weekday);
    final Animation<double> turnController =
        CurvedAnimation(parent: animationController, curve: Curves.easeOutCirc);

    return FutureBuilder(
        future: _weatherController.initController(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final WeatherEntity weatherEntity = snapshot.data!;
            return Scaffold(
                appBar: AppBar(
                  toolbarHeight: 100,
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '${weatherEntity.cityName!} ',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Icon(
                            Iconsax.location5,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ],
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
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
                  leading: Builder(
                      builder: (context) => IconButton(
                          icon: Icon(
                            Iconsax.setting,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          onPressed: () => context.push('/settings', extra: {
                                'weather': _weatherController,
                                'main': _mainController
                              }))),
                ),
                body: SingleChildScrollView(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${weatherEntity.temp!.toStringAsFixed(0)}°',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        util.withWeather(
                                            weatherEntity.condition!),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Text(
                                                  '  ${weatherEntity.maxTemp!.toStringAsFixed(0)}°',
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
                                                  ' | ${weatherEntity.minTemp!.toStringAsFixed(0)}°',
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
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Flexible(
                                child: Lottie.asset(
                                    util.withWeatherAnimation(
                                        weatherEntity.condition!),
                                    alignment: Alignment.center),
                              ),
                            ],
                          )),
                          global.smallBoxSpace,
                          Card(
                            color: Theme.of(context).colorScheme.secondary,
                            elevation: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Próximos dias',
                                      textAlign: TextAlign.start,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    global.smallBoxSpace,
                                    SizedBox(
                                        height: 2,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .7,
                                        child: Divider(
                                          thickness: .5,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary,
                                        )),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .10,
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView.builder(
                                          padding: const EdgeInsets.all(8),
                                          itemCount:
                                              weatherEntity.forecast.length,
                                          itemExtent: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .20,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            try {
                                              return homeWidgets.weatherCard(
                                                  weatherEntity
                                                      .forecast[index]);
                                            } catch (e) {
                                              throw e.toString();
                                            }
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          global.verySmallBoxSpace,
                          Card(
                              color: Theme.of(context).colorScheme.secondary,
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .40,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Minhas cidades',
                                              textAlign: TextAlign.start,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge),
                                          Builder(
                                              builder: (context) => IconButton(
                                                  icon: Icon(
                                                    Iconsax.search_normal,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .inversePrimary,
                                                  ),
                                                  onPressed: () => context.push(
                                                          '/search',
                                                          extra: {
                                                            'weather':
                                                                _weatherController
                                                          }))),
                                        ],
                                      ),
                                      global.verySmallBoxSpace,
                                      SizedBox(
                                          height: 2,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .7,
                                          child: Divider(
                                            thickness: .5,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary,
                                          )),
                                      global.verySmallBoxSpace,
                                      Expanded(
                                        child:
                                            homeWidgets.userWeathersLocation(),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          global.verySmallBoxSpace,
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'License by OpenWeatherMap',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          )
                        ],
                      )),
                ));
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            );
          }
        });
  }
}
