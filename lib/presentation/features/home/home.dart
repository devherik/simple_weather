import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
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
  late MainController mainController;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    _weatherController = WeatherController.instance;
    mainController = MainController.instance;
    util = MyUtil.instance;
    homeWidgets =
        HomeWidgets(classContext: context, classController: _weatherController);
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..stop();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String day = util.weekDay(DateTime.now().weekday);
    final Animation<double> turnController =
        CurvedAnimation(parent: animationController, curve: Curves.easeOutCirc);

    return Scaffold(
        appBar: AppBar(
          leading: Builder(
              builder: (context) => IconButton(
                    icon: Icon(
                      Iconsax.menu_board,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (context) =>
                          homeWidgets.modalBottomSheetLocations(),
                    ),
                  )),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Switch(
                  value: mainController.darkThemeOn,
                  activeColor: Theme.of(context).colorScheme.tertiary,
                  activeThumbImage:
                      const AssetImage('assets/images/icons/moon.png'),
                  inactiveThumbImage:
                      const AssetImage('assets/images/icons/sun.png'),
                  inactiveTrackColor: Theme.of(context).colorScheme.tertiary,
                  activeTrackColor: Theme.of(context).colorScheme.tertiary,
                  onChanged: (bool value) => setState(() {
                        mainController.changeTheme();
                      })),
            ),
          ],
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
                                  Text(
                                    value.cityName!,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '$day - ${value.getHour()}',
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
                                    '${util.withWeather(value.condition!)} - ${value.condition}',
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
                                  'Próximas horas',
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
                                      itemCount: 9,
                                      itemExtent:
                                          MediaQuery.of(context).size.width *
                                              .20,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        try {
                                          return homeWidgets.weatherCard(
                                              value.forecast[index]);
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
}
