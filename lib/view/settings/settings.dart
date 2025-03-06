import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:simple_weather_app/main.dart';

import 'package:simple_weather_app/utils/constant/globals.dart' as global;
import 'package:simple_weather_app/view/settings/feedback.dart';
import 'package:simple_weather_app/viewmodel/localstorage_viewmodel.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required LocalstorageViewmodel viewmodel})
      : _viewmodel = viewmodel,
        super();
  final LocalstorageViewmodel _viewmodel;

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
      body: ValueListenableBuilder(
          valueListenable: widget._viewmodel,
          builder: (context, value, child) {
            return Container(
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Icon(Iconsax.color_swatch),
                              Text(
                                'Tema do aplicativo',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Icon(Iconsax.message_remove),
                              Text(
                                'Feedback',
                                style: Theme.of(context).textTheme.bodyLarge,
                              )
                            ],
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => FeedbackPage(),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Icon(Iconsax.eraser),
                              Text(
                                'Limpar suas informações',
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
            );
          }),
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
                onPressed: () async {
                  if (widget._viewmodel.value.theme == ThemeMode.light) {
                    setState(
                        () => MyApp.of(context)!.changeTheme(ThemeMode.dark));
                    widget._viewmodel.value.changeTheme();
                  } else {
                    setState(
                        () => MyApp.of(context)!.changeTheme(ThemeMode.light));
                    widget._viewmodel.value.changeTheme();
                  }
                  await widget._viewmodel.savePreferences();
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
                      widget._viewmodel.value.theme.toString() ==
                              'ThemeMode.light'
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
                onPressed: () async {
                  if (widget._viewmodel.value.theme == ThemeMode.dark) {
                    setState(
                        () => MyApp.of(context)!.changeTheme(ThemeMode.light));
                    widget._viewmodel.value.changeTheme();
                  } else {
                    setState(
                        () => MyApp.of(context)!.changeTheme(ThemeMode.dark));
                    widget._viewmodel.value.changeTheme();
                  }
                  await widget._viewmodel.savePreferences();
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
                      widget._viewmodel.value.theme.toString() ==
                              'ThemeMode.dark'
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
                        await widget._viewmodel.clearPreferences();
                      } on Exception catch (e) {
                        log(e.toString());
                      } finally {
                        setState(() {});
                        // ignore: use_build_context_synchronously
                        context.push('/');
                      }
                    },
                    splashColor: Theme.of(context).colorScheme.secondary,
                    elevation: 1,
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
