import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

class ThemeHelper {
  final _appTheme = PrefUtils().getThemeData();

  final Map<String, PrimaryColors> _supportedCustomColor = {
    'primary': PrimaryColors()
  };

  final Map<String, ColorScheme> _supportedColorScheme = {
    'primary': ColorSchemes.primaryColorScheme
  };

  PrimaryColors _getThemeColors() {
    if (!_supportedCustomColor.containsKey(_appTheme)) {
      throw Exception("$_appTheme не найден");
    }
    return _supportedCustomColor[_appTheme] ?? PrimaryColors();
  }

  ThemeData _getThemeData() {
    if (!_supportedColorScheme.containsKey(_appTheme)) {
      throw Exception("$_appTheme не найден");
    }

    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.primaryColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: appTheme.background,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(
            color: appTheme.gray.withOpacity(0.8),
            width: 1.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.onSurface;
        }),
        side: const BorderSide(
          width: 1,
        ),
        visualDensity: const VisualDensity(
          vertical: -4,
          horizontal: -4,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: appTheme.gray,
      ),
    );
  }

  PrimaryColors themeColor() => _getThemeColors();

  ThemeData themeData() => _getThemeData();
}

class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        headlineLarge: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 32.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w800,
        ),
        titleMedium: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 18.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 14.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
      );
}

class ColorSchemes {
  static const primaryColorScheme = ColorScheme.light(
    primary: Color(0XFF3498DB),
    surface: Color(0XFFF0F0F0),
    //text
    onPrimary: Color(0XFF333333),
    onPrimaryContainer: Color(0XFFFFFFFF),
  );
}

class PrimaryColors {
  Color get black => const Color(0XFF000000);

  Color get white => const Color(0XFFFFFFFF);

  Color get lightGray => const Color(0XFFD9D9D9);

  Color get turquoise => const Color(0XFF48949B);

  Color get background => const Color(0XFFF0F0F0);

  Color get gray => const Color(0XFF4F4F4F);

  Color get gray80 => const Color(0XCC4F4F4F);

  Color get onPrimary50 => const Color(0X80333333);

  Color get orange => const Color(0XFFF3D36B);

  Color get green => const Color(0XFF64D677);

  Color get yellow => const Color(0XFFFFD43B);

  Color get flipCard => const Color(0xFF83B0C8);
}

PrimaryColors get appTheme => ThemeHelper().themeColor();

ThemeData get theme => ThemeHelper().themeData();
