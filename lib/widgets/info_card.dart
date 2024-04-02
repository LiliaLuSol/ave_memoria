import 'package:ave_memoria/other/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

Widget info_card(String title, String info) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 8.v, horizontal: 26.h),
      child: Column(
        children: [
          Text(title, style: CustomTextStyles.light20Text),
          SizedBox(
            height: 6.v,
          ),
          Text(
            info,
            style: CustomTextStyles.light20Text,
          ),
        ],
      ),
    ),
  );
}
