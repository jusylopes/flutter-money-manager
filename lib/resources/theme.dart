import 'package:flutter/material.dart';

Map<int, Color> color = {
  50: const Color.fromRGBO(97, 47, 116, .1),
  100: const Color.fromRGBO(97, 47, 116, .2),
  200: const Color.fromRGBO(97, 47, 116, .3),
  300: const Color.fromRGBO(97, 47, 116, .4),
  400: const Color.fromRGBO(97, 47, 116, .5),
  500: const Color.fromRGBO(97, 47, 116, .6),
  600: const Color.fromRGBO(97, 47, 116, .7),
  700: const Color.fromRGBO(97, 47, 116, .8),
  800: const Color.fromRGBO(97, 47, 116, .9),
  900: const Color.fromRGBO(97, 47, 116, 1),
};

MaterialColor colorCustom = MaterialColor(0xFF612F74, color);

ThemeData myTheme = ThemeData(
  primarySwatch: colorCustom,
  fontFamily: 'Roboto',
  textTheme: ThemeData.light().textTheme.copyWith(
          headline6: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      )),
);
