import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_weather_app/presentation/features/home/home.dart';
import 'package:simple_weather_app/presentation/features/settings/settings.dart';

class AppRouter {
  final router = GoRouter(routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'home',
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
          name: 'settings',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const SettingsPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: animation,
              child: child,
            ),
          ),
        ),
      ],
    ),
  ], initialLocation: '/');
}
