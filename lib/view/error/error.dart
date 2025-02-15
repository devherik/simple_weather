import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_weather_app/utils/constant/globals.dart' as global;

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required errorMSG}) : _error = errorMSG;
  final String _error;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: global.red,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Center(
        child: Text(
          _error,
          style: GoogleFonts.ubuntu(
              fontSize: 48,
              letterSpacing: 1.5,
              color: global.primaryLightColor),
        ),
      ),
    );
  }
}
