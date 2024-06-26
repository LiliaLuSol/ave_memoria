import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

Widget day_score(String day, int score, bool isToday) {
  return Expanded(
    child: Container(
      height: 55.v,
      width: 45.h,
      decoration: isToday
          ? AppDecoration.outlinePrimary
              .copyWith(borderRadius: BorderRadiusStyle.circleBorder5)
          : AppDecoration.outlineGray
              .copyWith(borderRadius: BorderRadiusStyle.circleBorder5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(day, style: theme.textTheme.bodyMedium),
          Text(
            score.toString(),
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    ),
  );
}
