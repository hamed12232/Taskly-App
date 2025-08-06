import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/Constant/ColorPlatte.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(_lightTheme);

  static final _lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: ColorPalette.primary,
      secondary: ColorPalette.secondary,
      surface: ColorPalette.lightSurface,
      background: ColorPalette.lightBackground,
      error: ColorPalette.error,
    ),
    scaffoldBackgroundColor: ColorPalette.lightBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorPalette.lightSurface,
      elevation: 0,
      iconTheme: IconThemeData(color: ColorPalette.lightTextPrimary),
      titleTextStyle: TextStyle(
        color: ColorPalette.lightTextPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    
  );

  static final _darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: ColorPalette.primary,
      secondary: ColorPalette.secondary,
      surface: ColorPalette.darkSurface,
      background: ColorPalette.darkBackground,
      error: ColorPalette.errorDark,
    ),
    scaffoldBackgroundColor: ColorPalette.darkBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorPalette.darkSurface,
      elevation: 0,
      iconTheme: IconThemeData(color: ColorPalette.darkTextPrimary),
      titleTextStyle: TextStyle(
        color: ColorPalette.darkTextPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  void toggleTheme() {
    emit(state.brightness == Brightness.dark ? _lightTheme : _darkTheme);
  }
}
