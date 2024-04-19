import 'package:ave_memoria/other/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget info_card(String title, String info) {

  List<Widget> hearts = List.generate(3, (index) {
    if (index < int.parse(info)) {
      return Icon(CupertinoIcons.heart_fill,
              color: Color.fromRGBO(230, 70, 70, 100));
    } else {
      return Icon(Icons.heart_broken_outlined,
              color: Color.fromRGBO(230, 70, 70, 100));
    }
  });

  return Container(
    child: Column(
      children: [
        Text(title, style: CustomTextStyles.light20Text, maxLines: 1),
        SizedBox(
          height: 6.v,
        ),
        if (title == "Жизни")
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          ...hearts])
        else
          Text(
            info,
            style: CustomTextStyles.light20Text,
          ),
      ],
    ),
  );
}

