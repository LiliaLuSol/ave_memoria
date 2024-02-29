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
                        Text("AveMemoria",
                            style: CustomTextStyles.extraBold32Primary
                        )
                      ]))));
  }
}
