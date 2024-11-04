import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_weather_app/config/router/router.dart';
import 'package:simple_weather_app/config/theme/theme.dart';
import 'package:simple_weather_app/presentation/controllers/main_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  final MainController mainController = MainController.instance;
  await mainController.initController();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MainController mainController = MainController.instance;
  @override
  void initState() {
    super.initState();
    mainController.themeMode$.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Simple Weather',
      theme: AppTheme.light,
      themeMode: mainController.getTheme(),
      darkTheme: AppTheme.dark,
      routerConfig: AppRouter().router,
    );
  }
}
