import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_color.dart';

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = false;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void changeTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData darkTheme = ThemeData(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF151b20),
    ),
    appBarTheme: AppBarTheme(
      color: Color(0xFF151b20),
      actionsIconTheme: IconThemeData(
        color: Color(0xFFFFFFFF),
        size: 24,
      ),
      titleTextStyle: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 20,
      ),
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Color(0xFFdfdfdf),
        fontSize: 25,
      ),
      bodyText1: TextStyle(color: Color(0xFFdfdfdf), fontSize: 14),
    ),
    primaryColor: Color(0xFF000000),
    brightness: Brightness.dark,
    fontFamily: 'Roboto-Regular',
    buttonTheme: ButtonThemeData(
      buttonColor: AppColor.purplishBlue,
    ),
  );
  static ThemeData lightTheme = ThemeData(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFffffff),
    ),
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 20,
      ),
      color: AppColor.purplishBlue,
      actionsIconTheme: IconThemeData(
        color: Color(0xFFFFFFFF),
        size: 24,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
      centerTitle: false,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Color(0xFF000000),
        fontSize: 25,
      ),
      bodyText1: TextStyle(color: Color(0x99000000), fontSize: 14),
    ),
    primaryColor: Color(0xFFFFFFFF),
    brightness: Brightness.light,
    fontFamily: 'Roboto-Regular',
    buttonTheme: ButtonThemeData(
      buttonColor: AppColor.purplishBlue,
    ),
  );
}
