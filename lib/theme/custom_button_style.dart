import 'package:ave_memoria/other/app_export.dart';
import 'package:flutter/material.dart';

class CustomButtonStyles {
  //серая кнопка
  static ButtonStyle get fillGray => ElevatedButton.styleFrom(
     //   backgroundColor: appTheme.gray4F4F4F,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.h),
        ),
      );
}
