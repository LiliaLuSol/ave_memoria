import 'package:ave_memoria/other/app_export.dart';
import 'package:flutter/material.dart';

import '../games/cards_game/gaming_cards.dart';
import '../games/sequence_game/gaming_sequence.dart';
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
  final bool isStory;
  final int currentLevel;

  const PauseMenu({
    super.key,
    required this.goRoute,
    required this.countRule,
    required this.text1,
    this.text2,
    this.text3,
    this.image1,
    this.image2,
    this.image3,
    this.isStory = false,
    this.currentLevel = 11,
  });

  @override
  State<PauseMenu> createState() => _PauseMenuState();
}

class _PauseMenuState extends State<PauseMenu> {
  GlobalData globalData = GlobalData();

  void getGamePath(int currentLevel) {
    switch (currentLevel) {
      case 11:
        globalData.updateImage(globalData.image1Game1, globalData.image2Game1,
            globalData.image3Game1);
        Navigator.push(
            context,
            PageRouteBuilder(
                pageBuilder: (_, __, ___) => GameRules(
                    firstTimes: true,
                    countRule: 3,
                    goRoute: AppRoutes.game_cards,
                    isStory: true,
                    text1: globalData.game1Rule1,
                    text2: globalData.game1Rule2,
                    text3: globalData.game1Rule3,
                    goGame: CardsGame(
                        isStory: true,
                        cond: globalData.gameData['cond'],
                        scoreStory: globalData.gameData['score'])),
                opaque: false,
                fullscreenDialog: true));
        break;
      case 12:
        globalData.updateImage(globalData.image1Game2, globalData.image2Game2,
            globalData.image3Game2);
        Navigator.push(
            context,
            PageRouteBuilder(
                pageBuilder: (_, __, ___) => GameRules(
                      firstTimes: true,
                      countRule: 3,
                      isStory: true,
                      goRoute: AppRoutes.game_sequence,
                      text1: globalData.game2Rule1,
                      text2: globalData.game2Rule2,
                      text3: globalData.game2Rule3,
                      goGame: SequenceGame(
                          isStory: true,
                          cond: globalData.gameData['cond'],
                          scoreStory: globalData.gameData['score']),
                    ),
                opaque: false,
                fullscreenDialog: true));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.black.withOpacity(0.2),
            body: Center(
                child: Container(
                    width: 353.h,
                    height: 453.v,
                    decoration: AppDecoration.outlineGray.copyWith(
                        borderRadius: BorderRadiusStyle.circleBorder15),
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.h),
                        child: Column(children: [
                          SizedBox(height: 30.v),
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
                              if (widget.isStory) {
                                getGamePath(widget.currentLevel);
                              } else {
                                GoRouter.of(context).push(widget.goRoute);
                              }
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
