import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFF99BC85),// top rectangle ,arrow, icons
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFBFD8AF), // Button color
      background: Color(0xFFE1F0DA), // backgroundColor
      tertiary: Color(0xFFD4E7C5), // container color
      error: Colors.red, //  errorColor
      onPrimary: Color(0xFF6FA94E),// textColor
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize:55,
        fontStyle: FontStyle.italic, // main page heading
        color: Color(0xFF6FA94E),
      ),
      displayMedium: TextStyle(
        fontSize: 35,
        fontStyle:
            FontStyle.italic, // accounting page, calendar, money_bag  heading
        color: Color(0xFF6FA94E),
      ),
      bodyLarge: TextStyle(
        color: Color(0xFF6FA94E),
        fontSize: 20, // all the text in the body
      ),
      bodyMedium: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: Color(0xFF6FA94E), // Button text 
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: const Color(0xff5b8fb9),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xff5b8fb9), // Button color
      background: Color(0xFF03001C), // backgroundColor
      tertiary: Color(0xff301e67), // container color
      error: Colors.red, //  errorColor
      onPrimary: Color(0xffb6eada),//textColor
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 60,
        fontStyle: FontStyle.italic, // main page heading
        color: Color(0xffb6eada),
      ),
      displayMedium: TextStyle(
        fontSize: 35,
        fontStyle:
            FontStyle.italic, // accounting page, calendar, money_bag  heading
        color: Color(0xffb6eada),
      ),
      bodyLarge: TextStyle(
        color: Color(0xffb6eada),
        fontSize: 20,
        fontWeight: FontWeight.bold, // all the text in the body
      ),
      bodyMedium: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: Color(0xffb6eada), // Button text color
      ),
    ),
  );
}
