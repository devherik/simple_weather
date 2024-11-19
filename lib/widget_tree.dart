import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:simple_weather_app/presentation/features/error/error.dart';
import 'package:simple_weather_app/presentation/features/home/home.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ConnectivityResult>>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.contains(ConnectivityResult.wifi) ||
                snapshot.data!.contains(ConnectivityResult.mobile)) {
              return HomePage(
                key: widget.key,
              );
            } else {
              return ErrorPage(errorMSG: 'Sem internet');
            }
          } else {
            return HomePage(
              key: widget.key,
            );
          }
        });
  }
}
