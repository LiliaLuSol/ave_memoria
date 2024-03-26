import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

class AppDecoration {
  static BoxDecoration get fillBlack => BoxDecoration(
        color: appTheme.black.withOpacity(0.2),
      );

  static BoxDecoration get outlineGray => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
        border: Border.all(
          color: appTheme.gray,
          width: 1.h,
        ),
      );

  static BoxDecoration get outlineLightGray => BoxDecoration(
    color: theme.colorScheme.onPrimaryContainer,
    border: Border.all(
      color: appTheme.lightGray,
      width: 1.h,
    ),
  );

}

class BorderRadiusStyle {
  static BorderRadius get circleBorder15 => BorderRadius.circular(
        15.h,
      );
}
