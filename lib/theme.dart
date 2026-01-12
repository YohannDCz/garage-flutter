import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  // Couleur principale
  primaryColor: const Color(0xFF4b39ef),

  // Thème de texte
  primaryTextTheme: const TextTheme(
    titleLarge: TextStyle(
        color: Color(0xFF57636C),
        fontSize: 22.0,
        fontWeight: FontWeight.normal,
        fontFamily: 'Montserrat'), // Title Large
    titleMedium: TextStyle(
        color: Color(0xFF57636C),
        fontSize: 18.0,
        fontWeight: FontWeight.normal,
        fontFamily: 'Montserrat'), // Title Medium
    titleSmall: TextStyle(
        color: Color(0xFF57636C),
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        fontFamily: 'Montserrat'), // Title Small
    bodyLarge: TextStyle(
        color: Color(0xFF000000),
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        fontFamily: 'Source Sans Pro'), // Body Large
    bodyMedium: TextStyle(
        color: Color(0xFF000000),
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        fontFamily: 'Source Sans Pro'), // Body Medium
    bodySmall: TextStyle(
        color: Color(0xFF000000),
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        fontFamily: 'Source Sans Pro'), // Body Small
  ),

  // Couleurs de fond
  scaffoldBackgroundColor: const Color(0xFFf1f4f8),

  useMaterial3: true,
  tabBarTheme: TabBarThemeData(indicatorColor: AppColors.warning),
);

class TextStyles {
  static TextStyle headlineLarge = const TextStyle(
      color: Color(0xFF57636C),
      fontSize: 22.0,
      fontWeight: FontWeight.normal,
      fontFamily: 'Montserrat'); // Title Large
  static TextStyle headlineMedium = const TextStyle(
      color: Color(0xFF57636C),
      fontSize: 18.0,
      fontWeight: FontWeight.normal,
      fontFamily: 'Montserrat'); // Title Medium
  static TextStyle headlineSmall = const TextStyle(
      color: Color(0xFF57636C),
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      fontFamily: 'Montserrat'); // Title Small
  static TextStyle bodyLarge = const TextStyle(
      color: Color(0xFF000000),
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      fontFamily: 'Source Sans Pro'); // Body Large
  static TextStyle bodyMedium = const TextStyle(
      color: Color(0xFF000000),
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      fontFamily: 'Source Sans Pro'); // Body Medium
  static TextStyle bodySmall = const TextStyle(
      color: Color(0xFF000000),
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      fontFamily: 'Source Sans Pro'); // Body Small
}

class AppColors {
  static Color primary = const Color(0xFF4b39ef);
  static Color secondary = const Color(0xFF007aff);
  static Color tertiary = const Color(0xFFf80d0d);
  static Color alternate = const Color(0xFFe0e3e7);

  static Color primaryText = const Color(0xFF000000);
  static Color secondaryText = const Color(0xFF57636C);
  static Color primaryBackground = const Color(0xFFf1f4f8);
  static Color secondaryBackground = const Color(0xFFFFFFFF);

  static Color white = const Color(0xFFFFFFFF);
  static Color accent1 = const Color(0x4C4B39EF);
  static Color accent2 = const Color(0x4D007AFF);
  static Color accent3 = const Color(0x4CF80D0D);

  static Color success = const Color(0xFF249689);
  static Color warning = const Color(0xFFF9CF58);
  static Color error = const Color(0xFFFF5963);
  static Color info = const Color(0xFF197DDF);

  static LinearGradient gradient = LinearGradient(
    colors: [primary, tertiary],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

SizedBox width4 = const SizedBox(width: 4.0);
SizedBox width8 = const SizedBox(width: 8.0);
SizedBox width16 = const SizedBox(width: 16.0);
SizedBox width24 = const SizedBox(width: 24.0);
SizedBox width32 = const SizedBox(width: 32.0);

SizedBox height4 = const SizedBox(height: 4.0);
SizedBox height6 = const SizedBox(height: 6.0);
SizedBox height8 = const SizedBox(height: 8.0);
SizedBox height16 = const SizedBox(height: 16.0);
SizedBox height24 = const SizedBox(height: 24.0);
SizedBox height32 = const SizedBox(height: 32.0);
SizedBox height40 = const SizedBox(height: 40.0);
SizedBox height64 = const SizedBox(height: 64.0);
