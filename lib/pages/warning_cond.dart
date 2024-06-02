import 'package:ave_memoria/other/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'game_rules.dart';

class WarningCondGame extends StatefulWidget {
  final int cond_start;
  final double currentLevel;

  const WarningCondGame(
      {super.key, required this.cond_start, required this.currentLevel});

  @override
  State<WarningCondGame> createState() => _WarningCondGameState();
}

class _WarningCondGameState extends State<WarningCondGame> {
  GlobalData globalData = GlobalData();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.black.withOpacity(0.2),
            body: Center(
                child: Container(
                    width: 353.h,
                    height: 242.v,
                    decoration: AppDecoration.outlineGray.copyWith(
                        borderRadius: BorderRadiusStyle.circleBorder15),
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.h),
                        child: Column(children: [
                          SizedBox(height: 10.v),
                          Text("Условие для начала",
                              style: CustomTextStyles.extraBold32Text),
                          SizedBox(height: 24.v),
                          Text(
                              "Необходимо ${widget.cond_start} мемов для доступа к уровню",
                              style: CustomTextStyles.light20Text,
                              textAlign: TextAlign.center),
                          SizedBox(height: 24.v),
                          CustomElevatedButton(
                              text: "Продолжить",
                              buttonTextStyle:
                                  CustomTextStyles.semiBold18TextWhite,
                              buttonStyle: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              onTap: () async {
                                if (widget.cond_start <= globalData.money) {
                                  await supabase
                                      .from('Levels')
                                      .update({
                                        'try': true,
                                      })
                                      .eq('user_id', globalData.user_id)
                                      .eq('number', widget.currentLevel)
                                      .count();
                                } else {
                                  context.showsnackbar(
                                      title:
                                          'Недостаточно средств для продолжения!',
                                      color: Colors.grey);
                                }
                                Navigator.pop(context);
                              }),
                          SizedBox(height: 24.v),
                        ]))))));
  }
}
