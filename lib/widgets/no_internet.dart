import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

class BuildNoInternet extends StatelessWidget {
  const BuildNoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: mediaQueryData.size.width,
        height: mediaQueryData.size.height,
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 75.v,
              ),
              Divider(height: 1, color: appTheme.gray),
              Spacer(),
              Image.asset(
                'assets/images/no-internet.png',
              ),
              Spacer(),
            ],
          ),
        ));
  }
}
