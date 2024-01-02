import 'package:flutter/material.dart';

class TcTextTheme {
  static TextTheme lightTextTheme = Typography.blackMountainView.copyWith(
    /// Headlines of screens
    headline1: TextStyle(
      fontFamily: 'OpenSans',
      color: Color(0xFF363636),
      fontWeight: FontWeight.bold,
    ),

    /// title of blue buttons
    button: TextStyle(
      fontFamily: 'OpenSans',
      color: Color(0xFFFFFFFF),
      fontWeight: FontWeight.w300,
    ),

    /// To be used in TextFormFields, Google SignIn Buttons and Verification
    /// page's body
    caption: TextStyle(
      fontFamily: 'OpenSans',
      color: Color(0xFF363636),
      fontWeight: FontWeight.w300,
    ),

    /// Main body text
    bodyText1: TextStyle(
      fontFamily: 'OpenSans',
      color: Color(0xFF5E5E5E),
      fontWeight: FontWeight.w600,
    ),

    /// Bottom nav-bar and top-card (you are owed/ you owe) text
    bodyText2: TextStyle(
      fontFamily: 'OpenSans',
      color: Color(0xFFFFFFFF),
      fontSize: 10,
    ),

    /// top card text
    headline2: TextStyle(
      fontFamily: 'OpenSans',
      color: Color(0xFFFFFFFF),
      fontWeight: FontWeight.w600,
    ),

    /// Red Font (you owe)
    subtitle1: TextStyle(
      fontFamily: 'OpenSans',
      color: Colors.red,
      fontWeight: FontWeight.w600,
    ),

    /// Green font (you are owed)
    subtitle2: TextStyle(
      fontFamily: 'OpenSans',
      color: Colors.green,
      fontWeight: FontWeight.w600,
    ),

    /// Credits text (made by)
    headline3: TextStyle(
      fontFamily: 'OpenSans',
      color: Color(0xFF7D7D7D),
      fontWeight: FontWeight.w600,
    ),

    /// TimeStamp text (in notes page) and "or connect with" text
    headline4: TextStyle(
      fontFamily: 'OpenSans',
      color: Color(0xFF525252),
    ),

    /// Title of "Settle Up" button in profile page
    headline5: TextStyle(
      fontFamily: 'OpenSans',
      color: Color(0xFF3389FF),
    ),

    /// "Sign Up", "FORGET PASSWORD", "Sign In" texts
    headline6: TextStyle(
      fontFamily: 'OpenSans',
      color: Color(0xFF3389FF),
      fontWeight: FontWeight.w600,
    ),
  );

  static TextTheme darkTextTheme = Typography.blackMountainView.copyWith(
    /// Headlines of screens
    headline1: TextStyle(
      fontFamily: 'OpenSans',
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),

    /// title of blue buttons
    button: TextStyle(
      fontFamily: 'OpenSans',
      color: Colors.white,
      fontWeight: FontWeight.w300,
    ),

    /// To be used in TextFormFields, Google SignIn Buttons and Verification
    /// page's body
    caption: TextStyle(
      fontFamily: 'OpenSans',
      color: Colors.white.withOpacity(0.90),
      fontWeight: FontWeight.w300,
    ),

    /// Main body text
    bodyText1: TextStyle(
      fontFamily: 'OpenSans',
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),

    /// Bottom nav-bar and top-card (you are owed/ you owe) text
    bodyText2: TextStyle(
      fontFamily: 'OpenSans',
      color: Colors.white,
      fontSize: 10,
    ),

    /// top card text
    headline2: TextStyle(
      fontFamily: 'OpenSans',
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),

    /// Red Font (you owe)
    subtitle1: TextStyle(
      fontFamily: 'OpenSans',
      color: Color(0xFFff555d),
      fontWeight: FontWeight.w600,
    ),

    /// Green font (you are owed)
    subtitle2: TextStyle(
      fontFamily: 'OpenSans',
      color: Color(0xff0affef),
      fontWeight: FontWeight.w600,
    ),

    /// Credits text (made by)
    headline3: TextStyle(
      fontFamily: 'OpenSans',
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),

    /// TimeStamp text (in notes page) and "or connect with" text
    headline4: TextStyle(
      fontFamily: 'OpenSans',
      color: Colors.white.withOpacity(0.85),
    ),

    /// Title of "Settle Up" button in profile page
    headline5: TextStyle(
      fontFamily: 'OpenSans',
      color: Color(0xff5468FF),
    ),

    /// "Sign Up", "FORGET PASSWORD", "Sign In" texts
    headline6: TextStyle(
      fontFamily: 'OpenSans',
      color: Color(0xff5468FF),
      fontWeight: FontWeight.w600,
    ),
  );
}