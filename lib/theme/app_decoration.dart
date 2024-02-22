import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

class AppDecoration {

  static BoxDecoration get fillOnPrimary => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(0.75),
      );

  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: appTheme.white,
      );
}

class BorderRadiusStyle {
  static BorderRadius get roundedBorder12 => BorderRadius.circular(
        12.h,
      );

  static BorderRadius get roundedBorder15 => BorderRadius.circular(
        15.h,
      );
}
