import 'package:ave_memoria/other/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultGame extends StatefulWidget {
  const ResultGame({super.key});

  @override
  State<ResultGame> createState() => _ResultGameState();
}

class _ResultGameState extends State<ResultGame> {
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    int tries = 0;
    int score = 0;
    int time = 0;
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.black.withOpacity(0.2),
            body: Center(
                child: Container(
                    width: 353.h,
                    height: 563.v,
                    decoration: AppDecoration.outlineGray.copyWith(
                        borderRadius: BorderRadiusStyle.circleBorder15),
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.h),
                        child: Column(children: [
                          SizedBox(height: 20.v),
                          Text("Игра", style: CustomTextStyles.regular24Text),
                          SizedBox(height: 44.v),
                          Row(children: [
                            Icon(FontAwesomeIcons.star,
                                color: theme.colorScheme.primary, size: 25.h),
                            SizedBox(width: 12.h),
                            Icon(FontAwesomeIcons.star,
                                color: theme.colorScheme.primary, size: 25.h),
                            SizedBox(width: 12.h),
                            Icon(FontAwesomeIcons.star,
                                color: theme.colorScheme.primary, size: 25.h)
                          ]),
                          SizedBox(height: 45.v),
                          Row(children: [
                            info_card("Попытки", "$tries"),
                            Spacer(),
                            info_card("Очки", "$score"),
                            Spacer(),
                            info_card("Время", "$time"),
                          ]),
                          SizedBox(height: 50.v),
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
                              GoRouter.of(context)
                                  .push(AppRoutes.game_cards);
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
