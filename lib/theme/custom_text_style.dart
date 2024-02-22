import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

class CustomTextStyles {
  static get headlineLargeWhiteExtraBold32 =>
      theme.textTheme.headlineLarge!.openSans.copyWith(
        fontSize: 32.fSize,
        fontWeight: FontWeight.w800,
      );

  static get headlineLargeOrangeExtraBold32 =>
      theme.textTheme.headlineLarge!.openSans.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 32.fSize,
        fontWeight: FontWeight.w800,
      );

  static get headlineLargeWhiteSemiBold32 =>
      theme.textTheme.headlineLarge!.openSans.copyWith(
        fontSize: 32.fSize,
        fontWeight: FontWeight.w600,
      );

  static get headlineLargeOrangeSemiBold32 =>
      theme.textTheme.headlineLarge!.openSans.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 32.fSize,
        fontWeight: FontWeight.w600,
      );

  static get appBarActiveSemiBold =>
      theme.textTheme.headlineLarge!.openSans.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w600,
      );

  static get appBarSemiBold => theme.textTheme.headlineLarge!.openSans.copyWith(
     //   color: appTheme.gray4F4F4F,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w600,
      );

  static get titleSemiBoldWhite14 =>
      theme.textTheme.headlineLarge!.openSans.copyWith(
        color: appTheme.white,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w600,
      );

  static get BoldBlack14 => theme.textTheme.headlineLarge!.openSans.copyWith(
        color: appTheme.black,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w800,
      );

  static get titleRegularOrange14 =>
      theme.textTheme.headlineLarge!.openSans.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 14.fSize,
      );

  static get RegularBlack12 => theme.textTheme.headlineLarge!.openSans.copyWith(
        color: appTheme.black,
        fontSize: 12.fSize,
      );

  static get bodyLargeWhite => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.white,
        fontSize: 16.fSize,
      );

  static get bodyLargeOrage => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 16.fSize,
      );

  static get bodyLargeBlack => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.black.withOpacity(0.5),
      );

  static get bodyMediumPrimary => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primary,
      );

  static get bodyMediumWhite => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.white.withOpacity(0.7),
      );

  static get bodySmallWhiteLight => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.white,
        fontWeight: FontWeight.w300,
      );

  static get bodySmallWhiteLight12 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.white,
        fontSize: 12.fSize,
        fontWeight: FontWeight.w300,
      );

  static get titleMedium16 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 16.fSize,
      );

  static get titleRus => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.white,
        fontSize: 20.fSize,
      );

  static get boldWhite20 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.white,
        fontSize: 20.fSize,
        fontWeight: FontWeight.w700,
      );

  static get bodyLargeWhite18 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.white.withOpacity(0.75),
        fontSize: 18.fSize,
      );

  static get titleMediumWhite => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.white.withOpacity(0.7),
        fontSize: 16.fSize,
      );

  static get titleSmallGray => theme.textTheme.titleSmall!.copyWith(
    //    color: appTheme.gray7C,
      );

  static get amoutSemiBoldOrange20 => theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 20.fSize,
        fontWeight: FontWeight.w600,
      );

  static get amoutSemiBoldWhite20 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.white,
        fontSize: 20.fSize,
        fontWeight: FontWeight.w600,
      );
}

extension on TextStyle {
  TextStyle get openSans {
    return copyWith(
      fontFamily: 'Open Sans',
    );
  }
}
