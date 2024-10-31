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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Simple Weather',
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      darkTheme: AppTheme.dark,
      routerConfig: AppRouter().router,
    );
  }
}
