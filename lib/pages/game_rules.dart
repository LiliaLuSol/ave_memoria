import 'package:ave_memoria/other/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameRules extends StatefulWidget {
  final bool firstTimes;
  final String goRoute;
  final int countRule;
  final String text1;
  final String? text2;
  final String? text3;
  final String? image1;
  final String? image2;
  final String? image3;

  const GameRules(
      {super.key,
      required this.goRoute,
      required this.firstTimes,
      required this.countRule,
      required this.text1,
      this.text2,
      this.text3,
      this.image1,
      this.image2,
      this.image3});

  @override
  State<GameRules> createState() => _GameRulesState();
}

class _GameRulesState extends State<GameRules> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor:
                widget.firstTimes ? Color(0xFFC0C0C0) : Colors.transparent,
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
                            SizedBox(width: 25.h),
                            Spacer(),
                            Text("Правила",
                                style: CustomTextStyles.extraBold32Text),
                            Spacer(),
                            IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.circleXmark,
                                size: 25.h,
                                color: theme.colorScheme.primary,
                              ),
                              onPressed: () {
                                widget.firstTimes
                                    ? GoRouter.of(context)
                                        .push(AppRoutes.game_cards)
                                    : Navigator.pop(context);
                              },
                            ),
                          ]),
                          SizedBox(height: 49.v),
                          Container(
                            height: 205.v,
                            width: 260.h,
                            color: appTheme.lightGray,
                          ),
                          SizedBox(height: 49.v),
                          Text(widget.text1,
                              style: CustomTextStyles.semiBold18Text,
                              maxLines: 6,
                              textAlign: TextAlign.center),
                          SizedBox(height: 49.v),
                          widget.firstTimes
                              ? CustomElevatedButton(
                                  text: "Начать",
                                  buttonTextStyle:
                                      CustomTextStyles.semiBold18TextWhite,
                                  buttonStyle: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          theme.colorScheme.primary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                  onTap: () {
                                    GoRouter.of(context)
                                        .push(widget.goRoute);
                                  })
                              : CustomElevatedButton(
                                  text: "Продолжить",
                                  buttonTextStyle:
                                      CustomTextStyles.semiBold18TextWhite,
                                  buttonStyle: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          theme.colorScheme.primary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                  onTap: () {
                                    Navigator.pop(context);
                                  })
                        ]))))));
  }
}
