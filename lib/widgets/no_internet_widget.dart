import 'package:flutter/material.dart';

Widget no_internet() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Spacer(),
      Image.asset(
        'assets/images/no-internet.png',
      ),
      const Spacer(),
    ],
  );
}
