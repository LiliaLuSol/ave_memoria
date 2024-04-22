import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';
import '../../pages/pause_menu.dart';
import '../../pages/result_game.dart';

class ImageGame extends StatefulWidget {
  const ImageGame({super.key});

  @override
  _ImageGameState createState() => _ImageGameState();
}

class _ImageGameState extends State<ImageGame> {
  int time = -3;
  int _time = 3;
  bool _start = false;
  late bool _isFinished;
  late Timer _timer;
  late Timer _timeTimer;
  late int score;
  late int tries;
  late List _data;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        _time = (_time - 1);
      });
    });
  }

  void startDuration() {
    _timeTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        time = (time + 1);
      });
    });
  }

  void startGameAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _start = true;
        _timer.cancel();
      });
    });
  }

  void initializeGameData() {
    _time = -3;
    tries = 0;
    score = 0;
    _isFinished = false;
  }

  @override
  void initState() {
    startTimer();
    startDuration();
    startGameAfterDelay();
    initializeGameData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _timeTimer.cancel();
  }

  void pauseTimer() {
    _timer.cancel();
    _timeTimer.cancel();
  }

  void resumeTimer() {
    startTimer();
    startDuration();
  }

  Widget getItem(int index) {
    return Container(
      padding: EdgeInsets.all(5.h),
      decoration: BoxDecoration(
          color: Color(0xFF83B0C8), borderRadius: BorderRadius.circular(8.h)),
      child: Image.asset(_data[index], fit: BoxFit.cover),
    );
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return _isFinished
        ? ResultGame(
      nameGame: "Римские картинки",
      goRoute:
      AppRoutes.game_image,
      tries: tries,
      score: score,
      time: tries,
      maxScore: 600,
    )
        : SafeArea(
      child: Scaffold(
        body: Container(
          width: mediaQueryData.size.width,
          height: mediaQueryData.size.height,
          child: Column(
            children: [
              Container(
                  color: theme.colorScheme.onPrimaryContainer,
                  child: Column(children: [
                    SizedBox(
                      height: 22.v,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 49.h),
                        Spacer(),
                        Text("Римские картинки",
                            style: CustomTextStyles.regular24Text),
                        Spacer(),
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.circlePause,
                              size: 25.h,
                              color: theme.colorScheme.primary),
                          onPressed: () {
                            pauseTimer();
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                    const PauseMenu(
                                      goRoute:
                                      AppRoutes.game_image,
                                      countRule: 2,
                                      text1:
                                      "В начале вам показывается картинка, вы должны запомнить как можно больше подробнее его",
                                      text2:
                                      "Затем задается ряд вопросов по картинке на которые Вам предстоит ответить по памяти",
                                    ),
                                    opaque: false,
                                    fullscreenDialog: true))
                                .then((value) {
                              resumeTimer();
                            });
                          },
                        ),
                        SizedBox(width: 16.h),
                      ],
                    ),
                    SizedBox(height: 22.v),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Spacer(),
                        info_card("Попытки", "$tries"),
                        Spacer(),
                        info_card("Очки", "$score"),
                        Spacer(),
                        info_card("Время", time < 0 ? "0" : "$time"),
                        Spacer(),
                      ],
                    ),
                    SizedBox(height: 22.v),
                    Divider(height: 1, color: appTheme.gray)
                  ])),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
