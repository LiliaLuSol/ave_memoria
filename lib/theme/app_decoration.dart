import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

class AppDecoration {
  static BoxDecoration get fillBlack => BoxDecoration(
        color: appTheme.black.withOpacity(0.2),
      );

  static BoxDecoration get fillBackground => BoxDecoration(
        color: appTheme.background,
      );

  static BoxDecoration get fillOnPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
      );

  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
      );

  static BoxDecoration get outlineGray => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
        border: Border.all(
          color: appTheme.gray,
          width: 1.h,
        ),
      );

  static BoxDecoration get outlineGray800 => BoxDecoration(
        border: Border.all(
          color: appTheme.gray,
          width: 1.h,
        ),
      );
}

class BorderRadiusStyle {
  static BorderRadius get circleBorder54 => BorderRadius.circular(
        54.h,
      );

  static BorderRadius get roundedBorder10 => BorderRadius.circular(
        10.h,
      );

  static BorderRadius get roundedBorder13 => BorderRadius.circular(
        13.h,
      );
}
