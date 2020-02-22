import 'package:flutter/material.dart';

const Color primaryColor = Colors.redAccent;
const Color secondaryColor = Color(0xFFF78D12);
const Color widgetColor = Colors.deepOrange;

Animatable<Color> loadingColor = TweenSequence<Color>([
  TweenSequenceItem(
    weight: 1.0,
    tween: ColorTween(
      begin: primaryColor,
      end: secondaryColor,
    ),
  ),
  TweenSequenceItem(
    weight: 1.0,
    tween: ColorTween(
      begin: secondaryColor,
      end: primaryColor,
    ),
  ),
]);

final Shader linearGradient = LinearGradient(
  colors: <Color>[primaryColor, secondaryColor],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

ThemeData buildThemeData() {
  return ThemeData(
    fontFamily: 'OpenSans',
    primaryColor: primaryColor,
    accentColor: secondaryColor,
    accentColorBrightness: Brightness.dark,
    textTheme: TextTheme(
      headline: TextStyle(fontSize: 36),
      subtitle: TextStyle(fontSize: 16),
      title: TextStyle(fontSize: 24),
      caption: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
      body1: TextStyle(fontSize: 16),
      body2: TextStyle(fontSize: 14),
      overline: TextStyle(fontSize: 11),
      display1: TextStyle(
          fontSize: 15, color: primaryColor, fontWeight: FontWeight.w700),
      display2: TextStyle(
          fontSize: 15, color: Colors.white, fontWeight: FontWeight.w700),
      display3: TextStyle(fontSize: 11, color: Colors.white70),
      display4: TextStyle(
          fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}
