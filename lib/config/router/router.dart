import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_weather_app/view/error/error.dart';
import 'package:simple_weather_app/view/home/home.dart';
import 'package:simple_weather_app/view/search/search.dart';
import 'package:simple_weather_app/view/settings/settings.dart';
import 'package:simple_weather_app/view/widget_tree.dart';

class AppRouter {
  final router = GoRouter(routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'homePage',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
      routes: <RouteBase>[
        GoRoute(
          path: 'settings',
          name: 'settingsPage',
          builder: (context, state) {
            Map<String, dynamic> map = state.extra! as Map<String, dynamic>;
            return SettingsPage(mcontroll: map['main']);
          },
        ),
        GoRoute(
          path: 'search',
          name: 'searchPage',
          builder: (context, state) {
            Map<String, dynamic> map = state.extra! as Map<String, dynamic>;
            return SearchPage(wcontroll: map['weather']);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/error',
      name: 'errorPage',
      builder: (context, state) {
        //Map<String, dynamic> map = state.extra! as Map<String, dynamic>;
        return const ErrorPage(
            errorMSG: 'Um erro aconteceu. Estamos trabalhando para resolver.');
      },
    ),
    GoRoute(
      path: '/tree',
      name: 'widgetTree',
      builder: (context, state) {
        //Map<String, dynamic> map = state.extra! as Map<String, dynamic>;
        return const WidgetTree();
      },
    ),
  ], initialLocation: '/tree');
}
