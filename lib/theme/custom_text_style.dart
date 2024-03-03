import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

class CustomTextStyles {
  static get extraBold32Primary => theme.textTheme.headlineLarge!.copyWith(
        color: theme.colorScheme.primary,
      );

  static get semiBold32Text => theme.textTheme.headlineLarge!.copyWith(
      color: theme.colorScheme.onPrimary, fontWeight: FontWeight.w600);

  static get semiBold32Primary => theme.textTheme.headlineLarge!
      .copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w600);

  static get semiBold18Text =>
      theme.textTheme.titleMedium!.copyWith(color: theme.colorScheme.onPrimary);

  static get semiBold18TextGray =>
      theme.textTheme.titleMedium!.copyWith(color: appTheme.gray);

  static get semiBold18TextWhite =>
      theme.textTheme.titleMedium!.copyWith(color: appTheme.white);

  static get bold30Text => theme.textTheme.headlineLarge!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontSize: 30.fSize,
      fontWeight: FontWeight.w800);

  static get bodyMediumPrimary =>
      theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.primary);

  static get regular16Text => theme.textTheme.bodyMedium!
      .copyWith(color: theme.colorScheme.onPrimary,
      fontSize: 16.fSize);

  static get regular16TextHint => theme.textTheme.bodyMedium!
      .copyWith(color: appTheme.onPrimary50,
      fontSize: 16.fSize);
}

extension on TextStyle {
  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }
}
