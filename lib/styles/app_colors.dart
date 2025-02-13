import 'package:flutter/material.dart';

class AppColors {
  static RadialGradient myGradient = RadialGradient(
    colors: [
      Color.fromARGB(255, 152, 114, 97),
      Color.fromARGB(255, 40, 38, 38),
      Color.fromARGB(255, 12, 12, 12)
    ], // Define your gradient colors
    center: Alignment.center,
    radius: 1.2,
  );
  static LinearGradient linearGradient = LinearGradient(
      colors: [
        Color.fromARGB(255, 40, 38, 38),
        Color.fromARGB(255, 40, 38, 38),
        Color.fromARGB(255, 152, 114, 97),
        Color.fromARGB(255, 59, 49, 44),
        // Color.fromARGB(255, 12, 12, 12)
      ], // Define your gradient colors
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
}
