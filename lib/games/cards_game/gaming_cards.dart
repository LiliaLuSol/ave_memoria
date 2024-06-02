import 'dart:async';
import 'package:ave_memoria/pages/pause_menu.dart';
import 'package:ave_memoria/pages/result_game.dart';
import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';
import 'utils.dart';
import 'package:flip_card/flip_card.dart';

class CardsGame extends StatefulWidget {
  final bool? isStory;
  final int? cond;
  final int? currentLevel;
  final int? scoreStory;

  const CardsGame(
      {super.key, this.isStory, this.cond, this.scoreStory, this.currentLevel});

  @override
  CardsGameState createState() => CardsGameState();
}

class CardsGameState extends State<CardsGame> {
  GlobalData globalData = GlobalData();
  int time = -3;
  int _previousIndex = -1;
  bool _flip = false;
  bool _start = false;
  bool _wait = false;
  late String _nameGame1;
  late String game1Rule1;
  late String game1Rule2;
  late String game1Rule3;
  late bool _isFinished;
  late Timer _timer;
  late Timer _timeTimer;
  late int score;
  late int tries;
  late List _data;
  late List<bool> _cardFlips;
  late List<GlobalKey<FlipCardState>> _cardStateKeys;
  final String hiddenCardpath = ImageConstant.imgHidden;

  @override
  void initState() {
    _nameGame1 = globalData.nameGame1_;
    game1Rule1 = globalData.game1Rule1;
    game1Rule2 = globalData.game1Rule2;
    game1Rule3 = globalData.game1Rule3;
    startTimers();
    initializeGameData();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _timeTimer.cancel();
    super.dispose();
  }

  void startTimers() {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {});
    });

    _timeTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        time++;
      });
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _start = true;
        _timer.cancel();
      });
    });
  }

  void initializeGameData() {
    _data = createShuffledListFromImageSource();
    _cardFlips = getInitialItemStateList();
    _cardStateKeys = createFlipCardStateKeysList();
    tries = 0;
    score = 0;
    _isFinished = false;
  }

  void pauseTimer() {
    _timer.cancel();
    _timeTimer.cancel();
  }

  void resumeTimer() {
    startTimers();
  }

  Widget getItem(int index) {
    return Container(
      padding: EdgeInsets.all(5.h),
      decoration: BoxDecoration(
          color: appTheme.flipCard, borderRadius: BorderRadius.circular(8.h)),
      child: Image.asset(_data[index], fit: BoxFit.cover),
    );
  }

  Widget buildGameBoard() {
    return GridView.builder(
      padding: EdgeInsets.all(8.h),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16.h,
          mainAxisSpacing: 16.h,
          childAspectRatio: 1),
      itemBuilder: (context, index) => _start
          ? FlipCard(
              key: _cardStateKeys[index],
              onFlip: () {
                if (!_flip) {
                  _flip = true;
                  _previousIndex = index;
                } else {
                  _flip = false;
                  if (_previousIndex != index) {
                    if (_data[_previousIndex] != _data[index]) {
                      _wait = true;
                      Future.delayed(const Duration(milliseconds: 1500), () {
                        _cardStateKeys[_previousIndex]
                            .currentState!
                            .toggleCard();
                        _previousIndex = index;
                        _cardStateKeys[_previousIndex]
                            .currentState!
                            .toggleCard();
                        Future.delayed(const Duration(milliseconds: 160), () {
                          setState(() {
                            tries++;
                            if (score > 0) {
                              score -= 25;
                            }
                            _wait = false;
                          });
                        });
                      });
                    } else {
                      _cardFlips[_previousIndex] = false;
                      _cardFlips[index] = false;
                      setState(() {
                        score += 100;
                        tries++;
                      });
                      if (_cardFlips.every((t) => t == false)) {
                        Future.delayed(const Duration(milliseconds: 160), () {
                          setState(() {
                            _isFinished = true;
                            _start = false;
                          });
                          _timeTimer.cancel();
                        });
                      }
                    }
                  }
                }
              },
              flipOnTouch: _wait ? false : _cardFlips[index],
              direction: FlipDirection.HORIZONTAL,
              front: Container(
                padding: EdgeInsets.all(5.h),
                decoration: BoxDecoration(
                  color: appTheme.flipCard,
                  borderRadius: BorderRadius.circular(8.h),
                ),
                child: Image.asset(hiddenCardpath, fit: BoxFit.cover),
              ),
              back: getItem(index),
            )
          : getItem(index),
      itemCount: _data.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return _isFinished
        ? ResultGame(
            nameGame: _nameGame1,
            goRoute: AppRoutes.game_cards,
            tries: tries,
            score: score,
            time: time,
            minTries: 6,
            maxScore: 600,
            isGameCards: true,
            game: 'cards',
            isStory: widget.isStory ?? false,
            cond: widget.cond ?? 0,
            scoreStory: widget.scoreStory ?? 0,
            currentLevel: widget.currentLevel ?? 0,
          )
        : SafeArea(
            child: Scaffold(
              body: SizedBox(
                width: mediaQueryData.size.width,
                height: mediaQueryData.size.height,
                child: Column(
                  children: [
                    Container(
                      color: theme.colorScheme.onPrimaryContainer,
                      child: Column(
                        children: [
                          SizedBox(height: 22.v),
                          Row(
                            children: [
                              SizedBox(width: 49.h),
                              const Spacer(),
                              Text(
                                _nameGame1,
                                style: CustomTextStyles.regular24Text,
                              ),
                              const Spacer(),
                              IconButton(
                                icon: FaIcon(
                                  FontAwesomeIcons.circlePause,
                                  size: 25.h,
                                  color: theme.colorScheme.primary,
                                ),
                                onPressed: () {
                                  pauseTimer();
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (_, __, ___) => PauseMenu(
                                        goRoute: AppRoutes.game_cards,
                                        countRule: 3,
                                        text1: game1Rule1,
                                        text2: game1Rule2,
                                        text3: game1Rule3,
                                      ),
                                      opaque: false,
                                      fullscreenDialog: true,
                                    ),
                                  ).then((value) {
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
                              const Spacer(),
                              info_card("Попытки", "$tries"),
                              const Spacer(),
                              info_card("Очки", "$score"),
                              const Spacer(),
                              info_card("Время", time < 0 ? "0" : "$time"),
                              const Spacer(),
                            ],
                          ),
                          SizedBox(height: 22.v),
                          Divider(height: 1, color: appTheme.gray),
                        ],
                      ),
                    ),
                    const Spacer(),
                    buildGameBoard(),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          );
  }
}
