import 'package:expense_tracker/src/utils/theme/widget_themes/text_themes.dart';
import 'package:flutter/material.dart';

class TcAppTheme {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: Color(0xff3389FF),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: Colors.white,
    ),
    backgroundColor: Colors.grey[400],
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xff3389FF),
      splashColor: Color(0xff3369FF),
    ),
    brightness: Brightness.light,
    primaryColorLight: Color(0xff3359ee),
    splashColor: Color(0xff3359FF).withOpacity(0.5),
    highlightColor: Color(0xff3369FF).withOpacity(0.25),
    primaryColorDark: Colors.grey[600],
    cardColor: Colors.white,
    primaryIconTheme: IconThemeData().copyWith(
      color: Colors.black87,
    ),
    iconTheme: IconThemeData().copyWith(
      color: Colors.white,
    ),
    canvasColor: Colors.white,
    colorScheme: ColorScheme.light().copyWith(
      primary: Color(0xFF41d480),
      // primaryVariant: Color(0xFF42f2ab),
      secondary: Color(0xFFff2323),
      // secondaryVariant: Color(0xFFff5a5a),
      brightness: Brightness.light,
    ),
    textTheme: TcTextTheme.lightTextTheme,
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: Color(0xff5468FF),
    scaffoldBackgroundColor: Color(0xFF181532),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: Color(0xFF181532),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xff4460FF),
      splashColor: Color(0xff4460FF),
    ),
    brightness: Brightness.dark,
    primaryColorLight: Color(0xff3359ee),
    splashColor: Color(0xff5468FF).withOpacity(0.5),
    highlightColor: Color(0xff5468FF).withOpacity(0.25),
    primaryColorDark: Colors.grey[700]?.withAlpha(200),
    cardColor: Color(0xFF181532),
    dialogBackgroundColor: Color(0xFF181532),
    timePickerTheme: TimePickerThemeData().copyWith(
      backgroundColor: Color(0xFF181532).withAlpha(120),
      dialBackgroundColor: Color(0xFF181532).withOpacity(0.85),
      dayPeriodColor: Color(0xFF181532).withOpacity(0.85),
    ),
    backgroundColor: Color(0xFF181545),
    primaryIconTheme: IconThemeData().copyWith(
      color: Colors.white,
    ),
    iconTheme: IconThemeData().copyWith(
      color: Colors.white,
    ),
    canvasColor: Color(0xFF181532),
    colorScheme: ColorScheme.light().copyWith(
      // primaryVariant: Color(0xff0addaa),
      primary: Color(0xFf1adfbb),
      secondary: Color(0xFFff5a5a),
      // secondaryVariant: Color(0xFFff555d),
      onSurface: Colors.white,
      surface: Color(0xFF181532).withAlpha(200),
      background: Color(0xFF181532),
      brightness: Brightness.dark,
    ),
    textTheme: TcTextTheme.darkTextTheme
  );
}