import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

class BuildNoInternet extends StatelessWidget {
  const BuildNoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(appBar: CustomAppBar(
        height: 75.v,
        leadingWidth: double.maxFinite,
        leading: Padding(
            padding: EdgeInsets.only(left: 20.h),
            child: Row(children: [
              AppbarIconbutton(
                  svgPath: ImageConstant.imgArrowleft,
                  margin: EdgeInsets.only(bottom: 4.v),
                  onTap: () {
                    Navigator.pop(context, true);
                  }),
              AppbarSubtitle(
                text: "Нет интернета",
                margin: EdgeInsets.only(left: 16.h),
              )
            ])),
        styleType: Style.bgFill,
      ),
          body:
      SizedBox(
        width: mediaQueryData.size.width,
        height: mediaQueryData.size.height,
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Divider(height: 1, color: appTheme.gray),
              const Spacer(),
              Image.asset(
                'assets/images/no-internet.png',
              ),
              const Spacer(),
            ],
          ),
        )));
  }
}
