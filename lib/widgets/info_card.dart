import 'package:ave_memoria/other/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

Widget info_card(String title, String info) {
  return Container(
    child: Column(
      children: [
        Text(title, style: CustomTextStyles.light20Text, maxLines: 1),
        SizedBox(
          height: 6.v,
        ),
        Text(
          info,
          style: CustomTextStyles.light20Text,
        ),
      ],
    ),
  );
}
