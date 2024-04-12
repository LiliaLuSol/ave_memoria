import 'dart:async';
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
  List<int> sequence = [];
  int currentIndex = 0;
  bool canPlay = false;
  bool _start = false;
  int time = -3;
  int _time = 3;
  int roundTime = 5;
  late Timer _timer;
  late Timer _timeTimer;
  late bool _isFinished;

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
    _isFinished = false;
  }

  @override
  void initState() {
    startTimer();
    startDuration();
    startGameAfterDelay();
    initializeGameData();
    super.initState();
    startRound();
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

  void startRound() {
    setState(() {
      sequence.clear();
      currentIndex = 0;
      canPlay = false;
    });

    // // Generate new sequence
    // generateSequence();

    // Start timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (roundTime == 0) {
        timer.cancel();
        setState(() {
          canPlay = true;
        });
      } else {
        setState(() {
          roundTime--;
        });
      }
    });

    // Reset round time
    roundTime += 5;
  }

  void generateSequence() {
    int sequenceLength = sequence.length + 1;
    for (int i = 0; i < sequenceLength; i++) {
      sequence.add(i);
    }
    sequence.shuffle();
  }

  void checkSequence(int index) {
    if (index == sequence[currentIndex]) {
      if (currentIndex == sequence.length - 1) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Round completed!'),
        ));
        startRound();
      } else {
        setState(() {
          currentIndex++;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Wrong sequence!'),
      ));
      startRound();
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
                      SizedBox(width: 22.v),
                      Divider(height: 1, color: appTheme.gray)
                    ])),
                Spacer(),
                SizedBox(height: 20),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: sequence.map((index) {
                    return GestureDetector(
                      onTap: () {
                        if (!canPlay) return;
                        checkSequence(index);
                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        width: 50,
                        height: 50,
                        color: Colors.blueAccent,
                        child: Center(
                          child: Text(
                            index.toString(),
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                // Show timer
                Text(
                  'Time left: $roundTime seconds',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          )));
  }
}
