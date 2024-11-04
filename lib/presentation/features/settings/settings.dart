import 'package:flutter/material.dart';
import 'package:simple_weather_app/presentation/controllers/main_controller.dart';

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
        title: const Text(
          'Configurações',
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        //TODO: will be based on toogle buttuns
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Tema escuro: ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Switch(
                      value: mainController.darkThemeOn,
                      inactiveThumbColor:
                          Theme.of(context).colorScheme.inversePrimary,
                      inactiveTrackColor:
                          Theme.of(context).colorScheme.tertiary,
                      activeColor: Theme.of(context).colorScheme.inversePrimary,
                      onChanged: (bool value) => setState(() {
                            mainController.changeTheme();
                          })),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
