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

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late LocalstorageViewmodel viewmodel;

  @override
  void initState() {
    super.initState();
    viewmodel = LocalstorageViewmodel.instance;
    viewmodel.init();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    viewmodel.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Simple Weather',
      theme: AppTheme.light,
      themeMode: viewmodel.value.theme,
      darkTheme: AppTheme.dark,
      routerConfig: AppRouter().router,
    );
  }

  @override
  void dispose() {
    viewmodel.dispose();
    super.dispose();
  }
}
