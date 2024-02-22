import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

class LoadScreen extends StatelessWidget {
  const LoadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return SafeArea(
          child: Scaffold(
              body: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 5.v),
                        Text("AveMemoria",
                      //      style: CustomTextStyles.headlineLargePrimary
                        )
                      ]))));
  }
}
