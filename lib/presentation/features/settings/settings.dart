import 'package:flutter/material.dart';
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
        //TODO: will be based on toogle buttuns
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
                        const Icon(Iconsax.cloud),
                        Text(
                          '  Unidade de tempo',
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
                        const Icon(Iconsax.profile_delete),
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
                          inactiveTrackColor:
                              Theme.of(context).colorScheme.tertiary,
                          activeColor:
                              Theme.of(context).colorScheme.inversePrimary,
                          onChanged: (bool value) => setState(() {
                                mainController.changeTheme();
                              })),
                    ],
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
                          const Icon(Icons.bug_report_outlined),
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
                ))
          ],
        ),
      ),
    );
  }
}
