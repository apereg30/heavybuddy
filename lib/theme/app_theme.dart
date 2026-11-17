import 'package:flutter/material.dart';

/// Paleta definida en la memoria (sección "Sistema Visual Mínimo").
class AppColors {
  static const primary = Color(0xFF6A5AEA);
  static const background = Color(0xFFFFFFFF);
  static const surface = Color(0xFFF4F4F6);
  static const text = Color(0xFF121212);
  static const textSecondary = Color(0xFF4A4A4A);
  static const success = Color(0xFF0E7A0D);
  static const error = Color(0xFFC5221F);
  static const errorSurface = Color(0xFFFDF2F2);
  static const stripe = Color(0xFFF9F9FB);
  static const tint = Color(0xFFEEEBFD); // lavanda suave para tarjetas y campos
  static const tintStrong = Color(0xFFDCD6FA);
  static const successSurface = Color(0xFFE3F4E3);
  static const warnSurface = Color(0xFFFFF1C9);
  static const dangerSurface = Color(0xFFFBDADA);
}

class AppSpacing {
  static const s = 8.0;
  static const m = 16.0;
  static const l = 24.0;
  static const xl = 32.0;
}

/// Tamaño mínimo de objetivo táctil (48x48 dp).
const _minTarget = Size(48, 48);

ThemeData buildAppTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.light,
  ).copyWith(
    primary: AppColors.primary,
    onPrimary: Colors.white,
    surface: AppColors.background,
    onSurface: AppColors.text,
    error: AppColors.error,
  );

  const border = BorderSide(color: AppColors.primary, width: 1.5);

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: 'Roboto',
    materialTapTargetSize: MaterialTapTargetSize.padded,
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.primary),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.text),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.text),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.text),
      bodySmall: TextStyle(fontSize: 12, color: AppColors.textSecondary),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(48, 56),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        backgroundColor: AppColors.tint,
        minimumSize: _minTarget,
        side: border,
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        minimumSize: _minTarget,
      ),
    ),
    dividerTheme: const DividerThemeData(color: Color(0xFFD9D9DE), thickness: 1),
  );
}
