import 'package:ave_memoria/other/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'game_rules.dart';

class PauseMenu extends StatefulWidget {
  final String goRoute;
  static const String id = 'PauseMenu';
  final int countRule;
  final String text1;
  final String? text2;
  final String? text3;
  final String? image1;
  final String? image2;
  final String? image3;

  const PauseMenu(
      {super.key,
      required this.goRoute,
      required this.countRule,
      required this.text1,
      this.text2,
      this.text3,
      this.image1,
      this.image2,
      this.image3});

  @override
  State<PauseMenu> createState() => _PauseMenuState();
}

class _PauseMenuState extends State<PauseMenu> {
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
                    height: 478.v,
                    decoration: AppDecoration.outlineGray.copyWith(
                        borderRadius: BorderRadiusStyle.circleBorder15),
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.h),
                        child: Column(children: [
                          SizedBox(height: 10.v),
                          Row(children: [
                            IconButton(
                              icon: FaIcon(
                                isVolume
                                    ? FontAwesomeIcons.volumeHigh
                                    : FontAwesomeIcons.volumeOff,
                                size: 25.h,
                                color: theme.colorScheme.primary,
                              ),
                              onPressed: () {
                                setState(() {
                                  isVolume = !isVolume;
                                });
                              },
                            ),
                            Spacer(),
                          ]),
                          SizedBox(height: 15.v),
                          Text("Пауза",
                              style: CustomTextStyles.extraBold32Text),
                          SizedBox(height: 46.v),
                          CustomElevatedButton(
                              text: "Продолжить",
                              buttonTextStyle:
                                  CustomTextStyles.semiBold18TextWhite,
                              buttonStyle: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              onTap: () {
                                Navigator.pop(context);
                              }),
                          SizedBox(height: 24.v),
                          CustomElevatedButton(
                            text: "Переиграть",
                            buttonTextStyle:
                                CustomTextStyles.semiBold18TextWhite,
                            buttonStyle: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            onTap: () {
                              GoRouter.of(context).push(widget.goRoute);
                            },
                          ),
                          SizedBox(height: 24.v),
                          CustomElevatedButton(
                            text: "Правила",
                            buttonTextStyle:
                                CustomTextStyles.semiBold18TextWhite,
                            buttonStyle: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      pageBuilder: (_, __, ___) => GameRules(
                                            firstTimes: false,
                                            goRoute: "",
                                            countRule: 3,
                                            text1: widget.text1,
                                            text2: widget.text2,
                                            text3: widget.text3,
                                          ),
                                      opaque: false,
                                      fullscreenDialog: true));
                            },
                          ),
                          SizedBox(height: 24.v),
                          CustomElevatedButton(
                              text: "Выход",
                              buttonTextStyle:
                                  CustomTextStyles.semiBold18TextWhite,
                              buttonStyle: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              onTap: () {
                                GoRouter.of(context).push(AppRoutes.homepage);
                              })
                        ]))))));
  }
}
