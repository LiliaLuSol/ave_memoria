import 'package:ave_memoria/other/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'game_rules.dart';

class PauseMenu extends StatefulWidget {
  static const String id = 'PauseMenu';

  // final CarsGame game;
  const PauseMenu({super.key});

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
                              GoRouter.of(context).push(AppRoutes.game_cards);
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
                                      pageBuilder: (_, __, ___) =>
                                          const GameRules(
                                            firstTimes: false,
                                            goRoute: "",
                                            countRule: 3,
                                            text1:
                                                "Игровое поле состоит из карт, за каждой из которых скрыта картинка. Картинки ― парные, т.е. на игровом поле есть две карты, на которых находятся одинаковые картинки",
                                            text2:
                                                "В начале игры на несколько секунд показывают все картинки. Ваша задача запомнить как можно больше карт",
                                            text3:
                                                "А затем все карты перевернут рубашкой вверх. Надо с меньшим числом попыток найти и перевернуть парные карты, если картинки различаются, тогда они снова повернутся",
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
