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
            final result = snapshot.data!.first;
            if (result == ConnectivityResult.vpn) {
              if (snapshot.data!.contains(ConnectivityResult.mobile) ||
                  snapshot.data!.contains(ConnectivityResult.wifi)) {
                print('VPN with internet');
                return HomePage();
              } else {
                return ErrorPage(errorMSG: 'Sem internet');
              }
            } else {
              switch (result) {
                case ConnectivityResult.wifi || ConnectivityResult.mobile:
                  print('Conectado');
                  return HomePage();
                case ConnectivityResult.none:
                  print('Sem conexão');
                  return ErrorPage(errorMSG: result.toString());
                case ConnectivityResult.other:
                  print(ConnectivityResult.values);
                  return ErrorPage(errorMSG: result.toString());
                default:
                  return Center(
                    child: Text(
                      'Loading Page',
                      style: TextStyle(
                        fontSize: 60,
                      ),
                    ),
                  );
              }
            }
          } else {
            return Center(
              child: Text(
                'Loading Page',
                style: TextStyle(
                  fontSize: 60,
                ),
              ),
            );
          }
        });
  }
}
