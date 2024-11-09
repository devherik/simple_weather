import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:simple_weather_app/presentation/controllers/main_controller.dart';

import 'package:simple_weather_app/utils/constant/globals.dart' as global;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final MainController mainController = MainController.instance;
  @override
  void initState() {
    super.initState();
    mainController.weatherUnit$.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text('Configurações',
            style: Theme.of(context).textTheme.titleSmall),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'GERAL',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  global.smallBoxSpace,
                  MaterialButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Iconsax.sun_1),
                        Text(
                          '  Unidade de tempo - ${mainController.weatherUnit$.value}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      ],
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => modalBottomSheetUnities(),
                      );
                    },
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Divider(
                      thickness: .1,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  MaterialButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Iconsax.eraser),
                        Text(
                          '  Limpar suas informações',
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      ],
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Divider(
                      thickness: .1,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'FEEDBACK',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    global.smallBoxSpace,
                    MaterialButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(Iconsax.message_remove),
                          Text(
                            '  Informe um problema',
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ],
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Divider(
                        thickness: .1,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    MaterialButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(Iconsax.message_2),
                          Text(
                            '  Envie seu feedback',
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ],
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Divider(
                        thickness: .1,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    )
                  ],
                )),
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Feito por Herik Colares',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Iconsax.box,
                          size: 8,
                        ),
                        Text(
                          '  devherik',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    )
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Tema escuro: ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Switch(
                    value: mainController.darkThemeOn,
                    inactiveThumbColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    inactiveTrackColor: Theme.of(context).colorScheme.tertiary,
                    activeColor: Theme.of(context).colorScheme.inversePrimary,
                    onChanged: (bool value) => setState(() {
                          mainController.changeTheme();
                        })),
              ],
            ),
          ],
        ),
      ),
    );
  }

  modalBottomSheetUnities() {
    return Container(
      height: 250,
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
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: MaterialButton(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () {
                  mainController.changeWeatherUnit('Celcius');
                  context.pop();
                },
                splashColor: Theme.of(context).colorScheme.secondary,
                elevation: 0,
                color: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Celcius',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          letterSpacing: 3,
                          fontSize: 16),
                    ),
                    Icon(
                      mainController.weatherUnit$.value == 'Celcius'
                          ? Iconsax.toggle_on_circle5
                          : Iconsax.toggle_off_circle,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: MaterialButton(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () {
                  mainController.changeWeatherUnit('Farenheid');
                  context.pop();
                },
                splashColor: Theme.of(context).colorScheme.secondary,
                elevation: 0,
                color: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Farenheid',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          letterSpacing: 3,
                          fontSize: 16),
                    ),
                    Icon(
                      mainController.weatherUnit$.value == 'Farenheid'
                          ? Iconsax.toggle_on_circle5
                          : Iconsax.toggle_off_circle,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: MaterialButton(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () {
                  mainController.changeWeatherUnit('Kelvin');
                  context.pop();
                },
                splashColor: Theme.of(context).colorScheme.secondary,
                elevation: 0,
                color: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Kelvin',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          letterSpacing: 3,
                          fontSize: 16),
                    ),
                    Icon(
                      mainController.weatherUnit$.value == 'Kelvin'
                          ? Iconsax.toggle_on_circle5
                          : Iconsax.toggle_off_circle,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
