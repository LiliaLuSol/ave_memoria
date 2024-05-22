import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

Widget no_internet() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Spacer(),
      Image.asset(
        'assets/images/no-internet.png',
      ),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Text('О нет! Великий интернет пропал!',
              style: CustomTextStyles.semiBold18TextGray,
              textAlign: TextAlign.center)),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Text(
              'Вы можете продолжать играть в мини-игры, но мы не можем гарантировать сохраность новых рекордов и денег',
              style: CustomTextStyles.regular16Text,
              textAlign: TextAlign.center)),
      SizedBox(height: 8.v),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Text('＞︿＜',
              style: CustomTextStyles.regular16Text,
              textAlign: TextAlign.center)),
      const Spacer(),
    ],
  );
}
