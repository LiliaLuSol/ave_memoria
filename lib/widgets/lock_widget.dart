import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

Widget lock() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Spacer(),
      Image.asset(
        'assets/images/lock.png',
      ),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Text('Ограниченный доступ для анонимного пользователя!',
              style: CustomTextStyles.semiBold18TextGray,
              textAlign: TextAlign.center)),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Text(
              'В этом режиме Вам недоступны сетевые функции, но мини-игры всегда доступны',
              style: CustomTextStyles.regular16Text,
              textAlign: TextAlign.center)),
      SizedBox(height: 8.v),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Text('¯\\_(ツ)_/¯',
              style: CustomTextStyles.regular16Text,
              textAlign: TextAlign.center)),
      const Spacer(),
    ],
  );
}
