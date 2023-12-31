import 'package:flutter/material.dart';

class TcOutlinedButtonTheme{
  TcOutlinedButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.black,
      side: BorderSide(color: Colors.blue),
      padding: EdgeInsets.symmetric(vertical: 16,horizontal: 20),
      textStyle: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
  ));

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      side: BorderSide(color: Colors.blueAccent),
      padding: EdgeInsets.symmetric(vertical: 16,horizontal: 20),
      textStyle: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
  ));
}