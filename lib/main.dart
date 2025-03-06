import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_weather_app/config/router/router.dart';
import 'package:simple_weather_app/config/theme/theme.dart';
import 'package:simple_weather_app/viewmodel/localstorage_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static MyAppState? of(BuildContext context) {
    return context.findAncestorStateOfType<MyAppState>()!;
  }

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late LocalstorageViewmodel viewmodel;
  ThemeMode _themeMode = ThemeMode.light;

  @override
  void initState() {
    super.initState();
    viewmodel = LocalstorageViewmodel.instance;
    viewmodel.init().whenComplete(() {
      setState(() {
        _themeMode = viewmodel.value.theme;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Simple Weather',
      theme: AppTheme.light,
      themeMode: _themeMode,
      darkTheme: AppTheme.dark,
      routerConfig: AppRouter().router,
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() => _themeMode = themeMode);
  }
}
