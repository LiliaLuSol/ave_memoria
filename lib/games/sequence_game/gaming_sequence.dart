import 'dart:async';
import 'dart:math';
import 'package:ave_memoria/games/sequence_game/utils.dart';
import 'package:ave_memoria/theme/theme_helper.dart';
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
    0: ImageConstant.imgPose_0,
    1: ImageConstant.imgPose_1,
    2: ImageConstant.imgPose_2,
    3: ImageConstant.imgPose_3,
    4: ImageConstant.imgPose_4,
    5: ImageConstant.imgPose_5,
    6: ImageConstant.imgPose_6,
    7: ImageConstant.imgPose_7,
    8: ImageConstant.imgPose_8,
    10: ImageConstant.imgPose_10,
    11: ImageConstant.imgPose_11,
    12: ImageConstant.imgPose_12,
    13: ImageConstant.imgPose_13,
    14: ImageConstant.imgPose_14,
    15: ImageConstant.imgPose_15,
    16: ImageConstant.imgPose_16,
    17: ImageConstant.imgPose_17,
    18: ImageConstant.imgPose_18
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
                          // color: Colors.blue,
                          width: 353.h,
                          height: 353.v,
                          child: Center(
                            child: _canPlay
                                ? Image.asset(
                                    "${sequenceUser.isNotEmpty ? numberImageMap[sequenceUser.last] : ImageConstant.imgPose_10}",
                                    fit: BoxFit.cover,
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
                    Divider(height: 1, color: appTheme.gray),
                    Container(
                      color: appTheme.white,
                      width: 393.h,
                      height: 4.v,
                    ),
                    Stack(children: [
                      Container(
                        color: appTheme.white,
                        width: 393.h,
                        height: 267.v,
                      ),
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
                                        width: 115.h,
                                        height: 80.v,
                                        decoration: BoxDecoration(
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/images/sword1.png'),
                                            fit: BoxFit.contain,
                                          )
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (_start && _canPlay) {
                                          handleButtonClick(2);
                                        }
                                      },
                                      child: Container(
                                          width: 115.h,
                                          height: 80.v,
                                          decoration:  BoxDecoration(
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/sword2.png'),
                                              fit: BoxFit.contain,
                                            ),
                                            border: Border(
                                                right: BorderSide(
                                                  color: appTheme.gray,
                                                  width: 1,
                                                ),
                                                left: BorderSide(
                                                  color: appTheme.gray,
                                                  width: 1,
                                                )),
                                          )),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (_start && _canPlay) {
                                          handleButtonClick(3);
                                        }
                                      },
                                      child: Container(
                                          width: 115.h,
                                          height: 80.v,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/sword3.png'),
                                              fit: BoxFit.contain,
                                            ),
                                          )),
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
                                          width: 90.h,
                                          height: 60.v,
                                          decoration: BoxDecoration(
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/sword4.png'),
                                              fit: BoxFit.contain,
                                            ),border: Border(
                                              top: BorderSide(
                                                color: appTheme.gray,
                                                width: 1,
                                              ),
                                              bottom: BorderSide(
                                                color: appTheme.gray,
                                                width: 1,
                                              )),
                                          )),
                                    ),
                                    Container(
                                        width: 115.h,
                                        height: 60.v,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: theme.colorScheme.onPrimary,
                                            width: 1.h,
                                          ),
                                        ),
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
                                          width: 90.h,
                                          height: 60.v,
                                          decoration:  BoxDecoration(
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/sword5.png'),
                                              fit: BoxFit.contain,
                                            ), border: Border(
                                              top: BorderSide(
                                                color: appTheme.gray,
                                                width: 1,
                                              ),
                                              bottom: BorderSide(
                                                color: appTheme.gray,
                                                width: 1,
                                              )),
                                          )),
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
                                            width: 115.h,
                                            height: 80.v,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/sword6.png'),
                                                fit: BoxFit.contain,
                                              ),
                                            )),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (_start && _canPlay) {
                                            handleButtonClick(7);
                                          }
                                        },
                                        child: Container(
                                            width: 115.h,
                                            height: 80.v,
                                            decoration:  BoxDecoration(
                                              image: const DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/sword7.png'),
                                                fit: BoxFit.contain,
                                              ), border: Border(
                                                right: BorderSide(
                                                  color: appTheme.gray,
                                                  width: 1,
                                                ),
                                                left: BorderSide(
                                                  color: appTheme.gray,
                                                  width: 1,
                                                )),
                                            )),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (_start && _canPlay) {
                                            handleButtonClick(8);
                                          }
                                        },
                                        child: Container(
                                            width: 115.h,
                                            height: 80.v,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/sword8.png'),
                                                fit: BoxFit.contain,
                                              ),
                                            )),
                                      ),
                                    ]),
                                SizedBox(height: 14.v),
                                Divider(height: 1, color: appTheme.gray),
                                SizedBox(height: 12.v),
                              ]))
                    ])
                  ],
                ),
              )));
  }
}
