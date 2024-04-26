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
  GlobalData globalData = GlobalData();
  String nameGame2 = '';
  String _nameGame2 = '';
  String game2Rule1 = '';
  String game2Rule2 = '';
  String game2Rule3 = '';

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
    10: "10",
    11: "11",
    12: "12",
    13: "13",
    14: "14",
    15: "15",
    16: "16",
    17: "17",
    18: "18"
  };

  List<int> sequence = [];
  List<int> sequenceUser = [];
  int currentIndex = 0;
  String currentCountdownValue = '';
  List<String> countdown = ["3", '2', '1', 'НАЧАЛИ'];
  bool _countdown = false;
  bool _canPlay = false;
  bool _start = false;
  int life = 3;
  late bool _isFinished;
  late int score;
  late int rounde;

  void startGameAfterDelay() {
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        _start = true;
      });
    });
  }

  void initializeGameData() {
    life = 3;
    score = 0;
    rounde = 1;
    _countdown = true;
    _isFinished = false;
    _canPlay = false;
    sequenceUser.clear();
    sequenceUser.add(10);
    sequence.clear();
    sequence.add(0);
    for (int i = 0; i < 3; i++) {
      int randomNumber = Random().nextInt(8) + 1;
      sequence.add(randomNumber);
      sequence.add(0);
    }
    startCountdown();
  }

  @override
  void initState() {
    nameGame2 = globalData.nameGame2;
    _nameGame2 = globalData.nameGame2_;
    game2Rule1 = globalData.game2Rule1;
    game2Rule2 = globalData.game2Rule2;
    game2Rule3 = globalData.game2Rule3;
    startGameAfterDelay();
    initializeGameData();
    super.initState();
  }

  @override
  void dispose() {
    sequence.clear();
    sequenceUser.clear();
    super.dispose();
  }

  void newRounde() {}

  void handleButtonClick(int number) {
    if (sequence[currentIndex] == 0) {
      currentIndex++;
    }
    if (sequence[currentIndex] == number) {
      setState(() {
        score += 10;
        currentIndex++;
        sequenceUser.add(number + 10);
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            sequenceUser.add(10);
          });
        });
        if (currentIndex == sequence.length - 1) {
          rounde++;
          sequence.add(Random().nextInt(8) + 1);
          sequence.add(0);
          sequenceUser.clear();
          currentIndex = 0;
          _canPlay = false;
        }
      });
    } else {
      setState(() {
        life--;
        _canPlay = false;
        currentIndex = 0;
        sequenceUser.clear();
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
    return _countdown
        ? SafeArea(
            child: Scaffold(
                body: Center(
                    child: Text(
            currentCountdownValue,
            style: CustomTextStyles.extraBold32Primary,
            textAlign: TextAlign.center,
          ))))
        : _isFinished
            ? ResultGame(
                nameGame: nameGame2,
                goRoute: AppRoutes.game_sequence,
                rounde: rounde,
                score: score,
                isGameSequence: true,
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
                              Text(_nameGame2,
                                  style: CustomTextStyles.regular24Text),
                              Spacer(),
                              IconButton(
                                icon: FaIcon(FontAwesomeIcons.circlePause,
                                    size: 25.h,
                                    color: theme.colorScheme.primary),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                          pageBuilder: (_, __, ___) =>
                                              PauseMenu(
                                                goRoute:
                                                    AppRoutes.game_sequence,
                                                countRule: 3,
                                                text1: game2Rule1,
                                                text2: game2Rule2,
                                                text3: game2Rule3,
                                              ),
                                          opaque: false,
                                          fullscreenDialog: true));
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
                              info_card("Раунд", "$rounde"),
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
                            child: _canPlay
                                ? Text(
                                    "${sequenceUser.isNotEmpty ? numberImageMap[sequenceUser.last] : '10'}",
                                    style: CustomTextStyles.bold30Text,
                                  )
                                : NumberDisplay(
                                    sequence: sequence,
                                    numberImageMap: numberImageMap,
                                    delay: const Duration(seconds: 1),
                                    onSequenceDisplayed: () {
                                      setState(() {
                                        _canPlay = true;
                                      });
                                    },
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
