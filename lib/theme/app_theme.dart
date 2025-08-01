import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme => ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.brightBlue,
      secondary: AppColors.lightGray,
      onPrimary: Colors.white,
      surface: AppColors.surface,
    ),
  );
}
