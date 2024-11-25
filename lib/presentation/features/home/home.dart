import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_weather_app/domain/entities/weather_entity.dart';
import 'package:simple_weather_app/presentation/controllers/main_controller.dart';
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
  late MainController _mainController;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    _weatherController = WeatherController.instance;
    _mainController = MainController.instance;
    util = MyUtil.instance;
    _weatherController.initController();
    _mainController.weatherUnit$.addListener(
        () => setState(() async => await _weatherController.updateWeather()));
    homeWidgets =
        HomeWidgets(parentContext: context, wcontroll: _weatherController);
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..stop();
  }

  @override
  Widget build(BuildContext context) {
    final String today = util.weekDay(DateTime.now().weekday);
    final Animation<double> turnController =
        CurvedAnimation(parent: animationController, curve: Curves.easeOutCirc);

    return Scaffold(
        appBar: AppBar(
          leading: weatherPresentationModal(),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: FutureBuilder(
              future: _weatherController.initController(),
              builder: (context, snapshot) {
                return ValueListenableBuilder(
                  valueListenable: _weatherController.currentWeather$,
                  builder: (context, value, child) {
                    if (value.condition == 0) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      );
                    } else {
                      final filteredForecast = <WeatherEntity>[
                        value.forecast[0]
                      ];
                      int day = value.forecast[0].dateTime!.day;
                      for (var w in value.forecast) {
                        if (w.dateTime!.day != day) {
                          filteredForecast.add(w);
                          day = w.dateTime!.day;
                        }
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '${value.cityName!} ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                      Icon(
                                        Iconsax.location5,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '$today - ${value.getHour()}',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
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
                                              await _weatherController
                                                  .updateWeather();
                                              animationController
                                                  .forward()
                                                  .whenComplete(
                                                    () => animationController
                                                        .reset(),
                                                  );
                                            }),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${value.temp!.toStringAsFixed(0)}°',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text(
                                    util.withWeather(value.condition!),
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  )
                                ],
                              )),
                          Expanded(
                            flex: 3,
                            child: Lottie.asset(
                                util.withWeatherAnimation(value.condition!),
                                alignment: Alignment.center),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Próximos dias',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                global.verySmallBoxSpace,
                                SizedBox(
                                    height: 2,
                                    width:
                                        MediaQuery.of(context).size.width * .7,
                                    child: Divider(
                                      thickness: .5,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                    )),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .10,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                      padding: const EdgeInsets.all(8),
                                      itemCount: filteredForecast.length,
                                      itemExtent:
                                          MediaQuery.of(context).size.width *
                                              .20,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        try {
                                          return homeWidgets.weatherCard(
                                              filteredForecast[index]);
                                        } catch (e) {
                                          throw e.toString();
                                        }
                                      }),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    }
                  },
                );
              }),
        ));
  }

  Widget weatherPresentationModal() {
    return Builder(
        builder: (context) => IconButton(
            icon: Icon(
              Iconsax.menu_board,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              width: 30,
                              child: Divider(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  thickness: 3),
                            ),
                            global.smallBoxSpace,
                            Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Builder(
                                        builder: (context) => IconButton(
                                            icon: Icon(
                                              Iconsax.setting,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .inversePrimary,
                                            ),
                                            onPressed: () => context
                                                    .push('/settings', extra: {
                                                  'weather': _weatherController,
                                                  'main': _mainController
                                                }))),
                                    Builder(
                                        builder: (context) => IconButton(
                                            icon: Icon(
                                              Iconsax.search_normal,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .inversePrimary,
                                            ),
                                            onPressed: () => context
                                                    .push('/search', extra: {
                                                  'weather': _weatherController
                                                }))),
                                  ],
                                )),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Divider(
                                thickness: .1,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: homeWidgets.modalBottomSheetLocations()),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Divider(
                                thickness: .1,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                            ),
                            homeWidgets.locationsManagerButton()
                          ],
                        ),
                      ),
                    );
                  });
            }));
  }
}
