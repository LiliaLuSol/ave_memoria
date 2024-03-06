import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

class ScreenLayout extends StatelessWidget {
  final Widget child;

  const ScreenLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.h,
              vertical: 4.v,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
