import 'package:ave_memoria/other/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameRules extends StatefulWidget {
  const GameRules({super.key});

  @override
  State<GameRules> createState() => _GameRulesState();
}

class _GameRulesState extends State<GameRules> {
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    bool isVolume = true;
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.black.withOpacity(0.2),
            body: Center(
                child: Container(
                    width: 353.h,
                    height: 654.v,
                    decoration: AppDecoration.outlineGray.copyWith(
                        borderRadius: BorderRadiusStyle.circleBorder15),
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.h),
                        child: Column(children: [
                          SizedBox(height: 10.v),
                          Row(children: [
                            Spacer(),
                            IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.circleXmark,
                                size: 25.h,
                                color: theme.colorScheme.primary,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ]),
                          SizedBox(height: 15.v),
                          Text("Правила",
                              style: CustomTextStyles.extraBold32Text),
                          SizedBox(height: 49.v),
                          Container(
                            height: 205.v,
                            width: 260.h,
                            color: appTheme.lightGray,
                          ),
                          SizedBox(height: 49.v),
                          Text("",
                              style: CustomTextStyles.semiBold18Text,
                              maxLines: 5),
                          SizedBox(height: 49.v),
                          CustomElevatedButton(
                              text: "Начать",
                              buttonTextStyle:
                                  CustomTextStyles.semiBold18TextWhite,
                              buttonStyle: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              onTap: () {
                                null;
                              }),
                        ]))))));
  }
}
