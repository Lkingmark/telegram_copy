import 'package:flutter/material.dart';

/// Единые настройки оформления приложения.
///
/// Подключение к MaterialApp:
/// theme: AppTheme.light,
/// darkTheme: AppTheme.dark,
/// themeMode: AppTheme.mode,
///
/// Цвета, заданные непосредственно в экранах, имеют приоритет над темой.
abstract final class AppTheme {
  /// Material 3 Teal: остальные цвета генерируются из этого seed.
  static const Color primaryColor = Color(0xFF00796B);

  /// system — тема устройства; light / dark — фиксированная тема.
  static const ThemeMode mode = ThemeMode.system;

  static final ThemeData light = _build(Brightness.light);
  static final ThemeData dark = _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final colors = ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colors,
      primaryColor: colors.primary,
      scaffoldBackgroundColor: colors.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        elevation: 0,
        centerTitle: false,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surfaceContainerHighest,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.primary,
        selectionColor: colors.primary.withValues(alpha: 0.25),
        selectionHandleColor: colors.primary,
      ),
    );
  }
}
