import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:simple_weather_app/presentation/controllers/main_controller.dart';

import 'package:simple_weather_app/utils/constant/globals.dart' as global;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required MainController mcontroll})
      : _mainController = mcontroll;
  final MainController _mainController;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'GERAL',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  global.smallBoxSpace,
                  MaterialButton(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 12),
                    minWidth: MediaQuery.of(context).size.width,
                    splashColor: Theme.of(context).colorScheme.secondary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Iconsax.sun_1),
                        ValueListenableBuilder(
                          valueListenable: widget._mainController.weatherUnit$,
                          builder: (context, value, child) => Text(
                            '  Unidade de tempo - $value',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 12),
                    minWidth: MediaQuery.of(context).size.width,
                    splashColor: Theme.of(context).colorScheme.secondary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Iconsax.color_swatch),
                        ValueListenableBuilder(
                          valueListenable: widget._mainController.weatherUnit$,
                          builder: (context, value, child) => Text(
                            '  Tema do aplicativo',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        )
                      ],
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => modalBottomSheetTheme(),
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 12),
                    minWidth: MediaQuery.of(context).size.width,
                    splashColor: Theme.of(context).colorScheme.secondary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
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
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => modalBottomSheetEraseAll(),
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
                ],
              ),
              global.veryLargeBoxSpace,
              Column(
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 12),
                    minWidth: MediaQuery.of(context).size.width,
                    splashColor: Theme.of(context).colorScheme.secondary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
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
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            alertDialogSheetSendMSG('Problema'),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 12),
                      minWidth: MediaQuery.of(context).size.width,
                      splashColor: Theme.of(context).colorScheme.secondary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
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
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              alertDialogSheetSendMSG('Feedback'),
                        );
                      }),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Divider(
                      thickness: .1,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  )
                ],
              ),
              global.veryLargeBoxSpace,
              Column(
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
                      SizedBox(
                          height: 15,
                          width: 15,
                          child: Center(
                              child: Image.asset(
                                  'assets/icons/github_light.png'))),
                      Text(
                        ' devherik',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
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
                  widget._mainController.changeWeatherUnit('Celcius');
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
                      widget._mainController.weatherUnit$.value == 'Celcius'
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
                  widget._mainController.changeWeatherUnit('Fahrenheit');
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
                      'Fahrenheit',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          letterSpacing: 3,
                          fontSize: 16),
                    ),
                    Icon(
                      widget._mainController.weatherUnit$.value == 'Fahrenheit'
                          ? Iconsax.toggle_on_circle5
                          : Iconsax.toggle_off_circle,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  modalBottomSheetTheme() {
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
                  widget._mainController.changeTheme();
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
                      'Tema claro',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          letterSpacing: 3,
                          fontSize: 16),
                    ),
                    Icon(
                      !widget._mainController.darkThemeOn
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
                  widget._mainController.changeTheme();
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
                      'Tema escuro',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          letterSpacing: 3,
                          fontSize: 16),
                    ),
                    Icon(
                      widget._mainController.darkThemeOn
                          ? Iconsax.toggle_on_circle5
                          : Iconsax.toggle_off_circle,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  alertDialogSheetSendMSG(String title) {
    final TextEditingController controller = TextEditingController();
    bool sended = false;
    bool error = false;
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Builder(
            builder: (context) => IconButton(
                onPressed: () => context.pop(),
                icon: Icon(
                  Iconsax.close_circle,
                  color: global.red,
                )),
          )
        ],
      ),
      content: TextFormField(
        controller: controller,
        maxLines: 5,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
            hintText: 'Digite aqui',
            hintStyle: Theme.of(context).textTheme.labelMedium,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                    width: 0.5,
                    color: Theme.of(context).colorScheme.inversePrimary)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                    width: 1.0,
                    color: Theme.of(context).colorScheme.inversePrimary)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                    width: 1.0,
                    color: Theme.of(context).colorScheme.inversePrimary))),
      ),
      actions: <Widget>[
        Flexible(
          child: MaterialButton(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            onPressed: () async {
              sended = true;
              try {} catch (e) {
                sended = false;
                error = true;
                log(e.toString());
              } finally {}
            },
            splashColor: Theme.of(context).colorScheme.secondary,
            elevation: 1,
            color: global.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Iconsax.send_2),
                Text(
                  ' Enviar',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  modalBottomSheetEraseAll() {
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
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Apagar informações',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    global.verySmallBoxSpace,
                    Text(
                      'Deseja apagar todas as suas \nconfigurações do aplicativo?',
                      style: Theme.of(context).textTheme.labelLarge,
                      textAlign: TextAlign.center,
                    )
                  ],
                )),
            Flexible(
              flex: 2,
              fit: FlexFit.loose,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 12),
                    minWidth: MediaQuery.of(context).size.width * .3,
                    onPressed: () {
                      context.pop();
                    },
                    splashColor: Theme.of(context).colorScheme.secondary,
                    elevation: 0,
                    color: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Text(
                      'Não, mantenha.',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          letterSpacing: 3,
                          fontSize: 16),
                    ),
                  ),
                  MaterialButton(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 12),
                    minWidth: MediaQuery.of(context).size.width * .3,
                    onPressed: () async {
                      try {
                        await widget._mainController.eraseAllInformation();
                      } on Exception catch (e) {
                        log(e.toString());
                      } finally {
                        setState(() {});
                        // ignore: use_build_context_synchronously
                        context.push('/');
                      }
                    },
                    splashColor: Theme.of(context).colorScheme.secondary,
                    elevation: 0,
                    color: global.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Text(
                      'Sim, apague.',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          letterSpacing: 3,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
