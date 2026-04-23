import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mymotorcycle/core/constants/app_colors.dart';

class AppTheme {
  const AppTheme._();

  /// Theme “light” cho widget (chữ/icon tối trên nền sáng trong form…),
  /// nhưng **ép system bars tối** để khớp dashboard toàn màn đen.
  static ThemeData light() {
    const darkBars = SystemUiOverlayStyle(
      statusBarColor: Color(0xFF000000),
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xFF000000),
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarContrastEnforced: false,
    );

    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: darkBars,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      textTheme: base.textTheme.apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.textPrimary,
        size: 20,
      ),
    );
  }
}
