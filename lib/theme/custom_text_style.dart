import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

class CustomTextStyles {
  static get extraBold32Primary => theme.textTheme.headlineLarge!.copyWith(
        color: theme.colorScheme.primary,
      );

  static get extraBold32Text => theme.textTheme.headlineLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
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
      .copyWith(color: theme.colorScheme.onPrimary, fontSize: 16.fSize);

  static get regular16TextHint => theme.textTheme.bodyMedium!
      .copyWith(color: appTheme.onPrimary50, fontSize: 16.fSize);

  static get regular16Primary => theme.textTheme.bodyMedium!
      .copyWith(color: theme.colorScheme.primary, fontSize: 16.fSize);

  static get regular16White => theme.textTheme.bodyMedium!
      .copyWith(color: appTheme.white, fontSize: 16.fSize);

  static get regular16LightGray => theme.textTheme.bodyMedium!
      .copyWith(color: appTheme.lightGray, fontSize: 16.fSize);

  static get semiBold14Primary => theme.textTheme.bodyMedium!
      .copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w600);

  static get semiBold14Text => theme.textTheme.bodyMedium!.copyWith(
      color: theme.colorScheme.onPrimary, fontWeight: FontWeight.w600);
}

extension on TextStyle {
  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }
}
