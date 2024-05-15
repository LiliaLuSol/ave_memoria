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
          child: Text('Ограниченный доступ для анонимного пользователя',
              style: CustomTextStyles.semiBold18TextGray,
              textAlign: TextAlign.center)),
      const Spacer(),
    ],
  );
}
