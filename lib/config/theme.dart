import 'package:flutter/material.dart';
import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    // scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    // scaffoldBackgroundColor: Colors.grey.shade50,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme(
      primary: primary,
      secondary: secondary,
      background: background,
      surface: surface,
      error: error,
      brightness: Brightness.light,
      onPrimary: onPrimary,
      onSecondary: onSecondary,
      onError: onError,
      onBackground: onBackground,
      onSurface: onSurface,
    ),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(
      elevation: 0,
      titleSpacing: 0,
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 20,
      ),
      titleTextStyle: textDecorationTextStyle(
        Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      actionsIconTheme: const IconThemeData(size: 20),
    ),
    iconTheme: const IconThemeData(size: 20),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      errorMaxLines: 1,
      helperMaxLines: 0,
      filled: true,
      fillColor: Colors.white,
      alignLabelWithHint: true,
      errorStyle: const TextStyle(height: 0),
      hintStyle: textDecorationTextStyle(Colors.grey),
      labelStyle: textDecorationTextStyle(Colors.grey),
      prefixStyle: textDecorationTextStyle(primary),
      helperStyle: textDecorationTextStyle(Colors.blue),
      counterStyle: textDecorationTextStyle(Colors.purple),
      floatingLabelStyle: textDecorationTextStyle(Colors.green),
      suffixStyle: textDecorationTextStyle(Colors.grey),
      contentPadding: const EdgeInsets.all(16),
      border: outlineInputBorder(Colors.white),
      enabledBorder: outlineInputBorder(primary),
      focusedBorder: outlineInputBorder(primary),
      focusedErrorBorder: outlineInputBorder(error),
      disabledBorder: outlineInputBorder(Colors.grey),
      errorBorder: outlineInputBorder(error),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      titleTextStyle: const TextStyle(
        fontSize: 15,
        color: textColor,
        letterSpacing: .5,
        fontWeight: FontWeight.w500,
      ),
      contentTextStyle: const TextStyle(
        fontSize: 13,
        color: textColor,
        letterSpacing: .5,
      ),
      actionsPadding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 12,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      clipBehavior: Clip.antiAlias,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),
      ),
    ),
    tabBarTheme: TabBarTheme(
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 2.0,
          color: primary,
        ),
      ),
      labelColor: primary,
      labelStyle: textDecorationTextStyle(
        primary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelColor: textColor,
      unselectedLabelStyle: textDecorationTextStyle(
        textColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primary,
      selectedIconTheme: const IconThemeData(
        size: 20,
        color: primary,
      ),
      unselectedItemColor: textColor,
      unselectedIconTheme: const IconThemeData(
        size: 20,
        color: textColor,
      ),
      selectedLabelStyle: textDecorationTextStyle(
        primary,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: textDecorationTextStyle(
        textColor,
        fontWeight: FontWeight.w500,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      shape: CircleBorder(),
    ),
  );
}

TextStyle textDecorationTextStyle(Color color, {
  FontWeight fontWeight = FontWeight.w400,
  double fontSize = 13,
  bool underline = false,
}) => TextStyle(
  color: color,
  letterSpacing: .5,
  fontSize: fontSize,
  fontWeight: fontWeight,
  decoration: underline ? TextDecoration.underline : TextDecoration.none,
);

OutlineInputBorder outlineInputBorder(Color color) => OutlineInputBorder(
  borderSide: BorderSide(
    width: 1,
    color: color,
  ),
  borderRadius: const BorderRadius.all(Radius.circular(8)),
);