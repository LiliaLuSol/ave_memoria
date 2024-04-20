import 'dart:async';
import 'dart:math';
import 'package:ave_memoria/games/sequence_game/utils.dart';
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
    0: "0",
    1: "1",
    2: "2",
    3: "3",
    4: "4",
    5: "5",
    6: "6",
    7: "7",
    8: "8",
    9: "9",
  };

  List<int> sequence = [];
  List<int> sequenceUser = [];
  int currentIndex = 0;
  String currentCountdownValue = '';
  List<String> countdown = ["3", '2', '1', 'НАЧАЛИ'];
  bool _countdown = false;
  bool _canPlay = false;
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
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        _start = true;
        _timer.cancel();
      });
    });
  }

  void initializeGameData() {
    _time = -4;
    life = 3;
    score = 0;
    _countdown = true;
    _isFinished = false;
    _canPlay = false;
    sequence.clear();
    sequence.add(0);
    for (int i = 0; i < 3; i++) {
      int randomNumber = Random().nextInt(8) + 1;
      sequence.add(randomNumber);
      sequence.add(0);
    }
    startCountdown();
    // sequence.add(9);
    // sequenceUser.clear();
    // sequenceUser.add(9);
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
    sequence.clear();
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
        if (currentIndex == sequence.length) {
          sequence.add(Random().nextInt(8) + 1);
          currentIndex = 0;
          _canPlay = false;
        }
      });
    } else {
      setState(() {
        life--;
        _canPlay = false;
        if (life == 0) {
          _isFinished = true;
          _start = false;
        }
      });
    }
  }

  void startCountdown() async {
    for (String value in countdown) {
      setState(() {
        currentCountdownValue = value;
      });
      await Future.delayed(Duration(seconds: 1));
    }
    setState(() {
      _countdown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return _countdown ?
        Center(child: Text(currentCountdownValue,style: CustomTextStyles.extraBold32Primary, textAlign: TextAlign.center,))
        :
      _isFinished
        ? ResultGame(
            nameGame: "Гладиаторская тренировка памяти",
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
                          Text("    Гладиаторская\nтренировка памяти",
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
                        child:
                        _canPlay
                            ? Text(
                          "${sequenceUser.isNotEmpty ? numberImageMap[sequenceUser.last] : '0'}", // Показываем последнее введенное значение
                          style: CustomTextStyles.bold30Text,
                        )
                            : NumberDisplay(
                          sequence: sequence,
                          numberImageMap: numberImageMap,
                          delay: const Duration(seconds: 2),
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
                                  if (_start && _canPlay) {
                                    handleButtonClick(1);
                                  }
                                },
                                child: Container(
                                    color: Colors.orangeAccent,
                                    width: 115.h,
                                    height: 80.v,
                                    child: Text("Кнопка 1")),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (_start && _canPlay) {
                                    handleButtonClick(2);
                                  }
                                },
                                child: Container(
                                    color: Colors.orangeAccent,
                                    width: 115.h,
                                    height: 80.v,
                                    child: Text("Кнопка 2")),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (_start && _canPlay) {
                                    handleButtonClick(3);
                                  }
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
                                  if (_start && _canPlay) {
                                    handleButtonClick(4);
                                  }
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
                                    _canPlay ? "Нажимай!" : "Стой!",
                                    style: CustomTextStyles.light20Text,
                                    textAlign: TextAlign.center,
                                  ))),
                              GestureDetector(
                                onTap: () {
                                  if (_start && _canPlay) {
                                    handleButtonClick(5);
                                  }
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
                                    if (_start && _canPlay) {
                                      handleButtonClick(6);
                                    }
                                  },
                                  child: Container(
                                      color: Colors.orangeAccent,
                                      width: 115.h,
                                      height: 80.v,
                                      child: Text("Кнопка 6")),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (_start && _canPlay) {
                                      handleButtonClick(7);
                                    }
                                  },
                                  child: Container(
                                      color: Colors.orangeAccent,
                                      width: 115.h,
                                      height: 80.v,
                                      child: Text("Кнопка 7")),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (_start && _canPlay) {
                                      handleButtonClick(8);
                                    }
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
