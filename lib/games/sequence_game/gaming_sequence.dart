import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';
import '../../pages/pause_menu.dart';
import '../../pages/result_game.dart';

class SequenceGame extends StatefulWidget {
  const SequenceGame({super.key});

  @override
  _SequenceGameState createState() => _SequenceGameState();
}

class _SequenceGameState extends State<SequenceGame> {
  Map<int, String> numberImageMap = {
    1: "assets/images/image1.png",
    2: "assets/images/image2.png",
    3: "assets/images/image2.png",
    4: "assets/images/image2.png",
    5: "assets/images/image2.png",
    6: "assets/images/image2.png",
    7: "assets/images/image2.png",
    8: "assets/images/image2.png"
  };

  List<int> sequence = [];
  int currentIndex = 0;
  bool canPlay = false;
  bool _start = false;
  int time = -3;
  int _time = 3;
  int roundTime = 5;
  int life = 3;
  late Timer _timer;
  late Timer _timeTimer;
  late bool _isFinished;
  late int score;

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
    life = 3;
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
    _timer.cancel();
    _timeTimer.cancel();
    super.dispose();
  }

  void pauseTimer() {
    _timer.cancel();
    _timeTimer.cancel();
  }

  void resumeTimer() {
    startTimer();
    startDuration();
  }

  void handleButtonClick(int number) {
    if (sequence[currentIndex] == number) {
      setState(() {
        score++;
        currentIndex++;
      });
      if (currentIndex == sequence.length) {
        setState(() {
          sequence.add(Random().nextInt(8) + 1);
          currentIndex = 0;
        });
      }
    } else {
      setState(() {
        life--;
      });
      if (life == 0) {
        _isFinished = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return _isFinished
        ? ResultGame(
            nameGame: "Гладиаторский поединок памяти",
            tries: 0,
            score: 0,
            time: 0,
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
                          Text("  Гладиаторский\nпоединок памяти",
                              style: CustomTextStyles.regular24Text),
                          Spacer(),
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.circlePause,
                                size: 25.h, color: theme.colorScheme.primary),
                            onPressed: () {
                              pauseTimer();
                              Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                          pageBuilder: (_, __, ___) =>
                                              const PauseMenu(
                                                goRoute:
                                                    AppRoutes.game_sequence,
                                                countRule: 3,
                                                text1:
                                                    "В каждом раунде, гладиатор показывает последовательность движений.",
                                                text2:
                                                    "Ваша задача запоинить и воспроизвести эти движения за определенное время, не допуская ошибок.",
                                                text3:
                                                    "С каждым раундом времени на раздумья будет все меньше, а за ошибку вы теярете по одной жизни.",
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
                          info_card("Время", time < 0 ? "0" : "$time"),
                          Spacer(),
                          info_card("Очки", "$score"),
                          Spacer(),
                          info_card("Жизни", "$life"),
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: 22.v),
                      Divider(height: 1, color: appTheme.gray)
                    ])),
                SizedBox(height: 22.v),
                Align(
                    alignment: Alignment.center,
                    child: Container(
                      color: Colors.blue,
                      width: 353.h,
                      height: 353.v,
                      child: Center(
                        child: Text(
                          "0",
                          style: CustomTextStyles.bold30Text,
                        ),
                      ),
                    )),
                Spacer(),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.v),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Handle Button 1
                                },
                                child: Container(
                                    color: Colors.orangeAccent,
                                    width: 115.h,
                                    height: 80.v,
                                    child: Text("Кнопка 1")),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Handle Button 2
                                },
                                child: Container(
                                    color: Colors.orangeAccent,
                                    width: 115.h,
                                    height: 80.v,
                                    child: Text("Кнопка 2")),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Handle Button 3
                                },
                                child: Container(
                                    color: Colors.orangeAccent,
                                    width: 115.h,
                                    height: 80.v,
                                    child: Text("Кнопка 3")),
                              ),
                            ],
                          ),
                          SizedBox(height: 9.v),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Handle Button 4
                                },
                                child: Container(
                                    color: Colors.orangeAccent,
                                    width: 115.h,
                                    height: 60.v,
                                    child: Text("Кнопка 4")),
                              ),
                              Container(
                                  width: 115.h,
                                  height: 60.v,
                                  child: Center(
                                      child: Text(
                                    canPlay ? "Нажимай!" : "Стой!",
                                    style: CustomTextStyles.light20Text,
                                    textAlign: TextAlign.center,
                                  ))),
                              GestureDetector(
                                onTap: () {
                                  // Handle Button 5
                                },
                                child: Container(
                                    color: Colors.orangeAccent,
                                    width: 115.h,
                                    height: 60.v,
                                    child: Text("Кнопка 5")),
                              ),
                            ],
                          ),
                          SizedBox(height: 9.v),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Handle Button 6
                                  },
                                  child: Container(
                                      color: Colors.orangeAccent,
                                      width: 115.h,
                                      height: 80.v,
                                      child: Text("Кнопка 6")),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Handle Button 7
                                  },
                                  child: Container(
                                      color: Colors.orangeAccent,
                                      width: 115.h,
                                      height: 80.v,
                                      child: Text("Кнопка 7")),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Handle Button 8
                                  },
                                  child: Container(
                                      color: Colors.orangeAccent,
                                      width: 115.h,
                                      height: 80.v,
                                      child: Text("Кнопка 8")),
                                ),
                              ]),
                          SizedBox(height: 16.v),
                        ]))
              ],
            ),
          )));
  }
}
