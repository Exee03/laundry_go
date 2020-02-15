import 'package:flutter/material.dart';

const Color primaryColor = Colors.redAccent;
const Color secondaryColor = Color(0xFFF78D12);

// TextStyle appTitle = TextStyle(fontFamily: 'Quicksand', color: Colors.white, fontWeight: FontWeight.w500, fontSize: 31.0);
// TextStyle appTitleBig = TextStyle(fontFamily: 'Quicksand', color: Colors.white, fontWeight: FontWeight.w500, fontSize: 45.0);
// TextStyle appHeader1 = TextStyle(fontFamily: 'TitilliumWeb', fontWeight: FontWeight.w300, fontSize: 30.0, letterSpacing: 2, color: Colors.black45);
// TextStyle appHeader2 = TextStyle(fontFamily: 'TitilliumWeb', fontWeight: FontWeight.w300, fontSize: 25.0, letterSpacing: 2, color: Colors.black45);
TextStyle cardTitleBig = TextStyle(fontSize: 28.0, letterSpacing: 5);
// TextStyle cardTitleBigInv = TextStyle(fontFamily: 'Exo_2', color: Colors.white, fontWeight: FontWeight.w300, fontSize: 28.0, letterSpacing: 5);
// TextStyle cardTitle = TextStyle(fontFamily: 'Exo_2', fontWeight: FontWeight.w300, fontSize: 20.0, letterSpacing: 5);
// TextStyle cardTitleInv = TextStyle(fontFamily: 'Exo_2', color: Colors.white, fontWeight: FontWeight.w300, fontSize: 20.0, letterSpacing: 5);
// TextStyle cardSmallTitle = TextStyle(fontFamily: 'Exo_2', fontWeight: FontWeight.w300, fontSize: 15.0, letterSpacing: 5);
// TextStyle cardSubtitle = TextStyle(fontFamily: 'Exo_2', fontWeight: FontWeight.w300, fontSize: 15.0, letterSpacing: 3);
// TextStyle cardSmallSubtitle = TextStyle(fontFamily: 'Exo_2', fontWeight: FontWeight.w300, fontSize: 10.0, letterSpacing: 3);
// TextStyle appBarTextStyle = TextStyle(color: Colors.black, fontSize: 24.0);
// TextStyle radioSelectedTextStyle = TextStyle(color: Colors.white, fontSize: 18.0);
// TextStyle radioUnSelectedTextStyle = TextStyle(color: Colors.black, fontSize: 18.0);
// TextStyle extraSmallTextStyle = TextStyle(fontFamily: 'VarelaRound',fontSize: 10.0);
// TextStyle smallTextStyle = TextStyle(fontFamily: 'VarelaRound',fontSize: 12.0);
TextStyle mediumTextStyle = TextStyle(fontFamily: 'OpenSans', fontSize: 17.0);
// TextStyle bigTextStyle = TextStyle(fontFamily: 'VarelaRound', fontSize: 20.0);
// TextStyle smallTextStyleInv = TextStyle(fontFamily: 'VarelaRound',fontSize: 12.0, color: Colors.white);
// TextStyle mediumTextStyleInv = TextStyle(fontFamily: 'VarelaRound', fontSize: 17.0, color: Colors.white);
// TextStyle bigTextStyleInv = TextStyle(fontFamily: 'VarelaRound', fontSize: 20.0, color: Colors.white);
TextStyle smallBoldTextStyle = TextStyle(
    fontFamily: 'OpenSans',
    color: Colors.white,
    fontSize: 16.0,
    fontWeight: FontWeight.w900);
TextStyle bigTextTitleStyle =
    TextStyle(fontFamily: 'OpenSans', color: Colors.white, fontSize: 50.0);

ThemeData buildThemeData() {
  return ThemeData(
    fontFamily: 'OpenSans',
    primaryColor: primaryColor,
    // primaryColorLight: Colors.redAccent[100],
    // primaryColorDark: Colors.redAccent[400],
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
          fontSize: 15,
          color: primaryColor,
          fontWeight: FontWeight.w700),
      display2: TextStyle(
          fontSize: 15, color: Colors.white, fontWeight: FontWeight.w700),
      display3: TextStyle(fontSize: 11, color: Colors.white70),
      display4: TextStyle(
          fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}
