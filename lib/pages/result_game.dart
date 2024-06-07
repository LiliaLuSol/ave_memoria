import 'dart:math';
import 'package:ave_memoria/other/app_export.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../games/cards_game/gaming_cards.dart';
import '../games/sequence_game/gaming_sequence.dart';
import '../main.dart';
import 'dialog_game.dart';
import 'game_rules.dart';

class ResultGame extends StatefulWidget {
  final String nameGame;
  final String goRoute;
  final int? tries;
  final int? round;
  int? score;
  final int? time;
  final int? minTries;
  final int? maxScore;
  final int? correctAnswers;
  final int? totalQuestions;
  final bool isGameCards;
  final bool isGameSequence;
  final bool isGameImage;
  final bool isStory;
  final String game;
  final int? cond;
  final int currentLevel;
  int? scoreStory;

  ResultGame({
    super.key,
    required this.nameGame,
    required this.goRoute,
    this.tries,
    this.round,
    this.score,
    this.time,
    this.minTries,
    this.maxScore,
    this.correctAnswers,
    this.totalQuestions,
    this.isGameCards = false,
    this.isGameSequence = false,
    this.isGameImage = false,
    this.isStory = false,
    required this.game,
    this.cond,
    this.scoreStory,
    this.currentLevel = 11,
  });

  @override
  _ResultGameState createState() => _ResultGameState();
}

class _ResultGameState extends State<ResultGame> {
  GlobalData globalData = GlobalData();
  int? calculatedMoney;

  @override
  void initState() {
    super.initState();
    calculatedMoney = calculationMoney();
  }

  void getCurrentDay(int score) {
    final now = DateTime.now();
    switch (now.weekday) {
      case DateTime.monday:
        globalData.updateDay(DateTime.monday, globalData.mon + score);
      case DateTime.tuesday:
        globalData.updateDay(DateTime.tuesday, globalData.tue + score);
      case DateTime.wednesday:
        globalData.updateDay(DateTime.wednesday, globalData.wen + score);
      case DateTime.thursday:
        globalData.updateDay(DateTime.thursday, globalData.thu + score);
      case DateTime.friday:
        globalData.updateDay(DateTime.friday, globalData.fri + score);
      case DateTime.saturday:
        globalData.updateDay(DateTime.saturday, globalData.sat + score);
      case DateTime.sunday:
        globalData.updateDay(DateTime.sunday, globalData.sun + score);
    }
  }

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

  int calculationMoney() {
    int money = 1;
    if (widget.isGameImage) {
      money = ((widget.correctAnswers != null && widget.totalQuestions != null)
          ? ((widget.correctAnswers! / widget.totalQuestions!) * 10).toInt()
          : 1);
      globalData.updateCount(30, 1);
      getCurrentDay(money * 10);
    }
    if (widget.isGameCards) {
      const int maxScore = 600;
      const int minTries = 6;
      const int maxTries = 100;
      const double scoreWeight = 0.7;
      const double triesWeight = 0.3;
      double normalizedScore = widget.score! / maxScore;
      double normalizedTries = (widget.tries! <= minTries)
          ? 1.0
          : (maxTries - widget.tries!).toDouble() / (maxTries - minTries);
      double combinedNormalizedValue =
          (normalizedScore * scoreWeight) + (normalizedTries * triesWeight);
      int minMoney = 1;
      int maxMoney = 12;
      money = ((combinedNormalizedValue * (maxMoney - minMoney)) + minMoney)
          .toInt();
      globalData.updateCount(10, 1);
      widget.score! > globalData.best1
          ? globalData.updateBest(1, widget.score!)
          : null;
      getCurrentDay(widget.score!);
    }
    if (widget.isGameSequence) {
      int a = widget.round! > 1 ? widget.round! : 0;
      money = a * 2 + (widget.score! / 100).ceil();
      money == 0 ? money = 1 : null;
      globalData.updateCount(20, 1);
      widget.round! > globalData.best2
          ? globalData.updateBest(2, widget.round!)
          : null;
      getCurrentDay(widget.score!);
    }
    globalData.updateMoney(globalData.money + money);
    return money;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFC0C0C0),
        body: Center(
          child: Container(
            width: 353.h,
            height: 563.v,
            decoration: AppDecoration.outlineGray.copyWith(
              borderRadius: BorderRadiusStyle.circleBorder15,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Column(
                children: [
                  SizedBox(height: 35.v),
                  Text(
                    widget.nameGame,
                    style: CustomTextStyles.regular24Text,
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  buildContent(),
                  const Spacer(),
                  buildFooter(context, calculatedMoney ?? 0),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContent() {
    if (widget.isStory) {
      return buildStory();
    } else if (widget.isGameCards) {
      return buildGameCardsContent();
    } else if (widget.isGameSequence) {
      return buildGameSequenceContent();
    } else if (widget.isGameImage) {
      return buildGameImageContent();
    } else {
      return Container();
    }
  }

  Widget buildGameCardsContent() {
    return Column(
      children: [
        SizedBox(height: 90.v),
        Row(
          children: [
            const Spacer(),
            info_card("Попытки", "${widget.tries}"),
            const Spacer(),
            info_card("Очки", "${widget.score}"),
            const Spacer(),
            info_card("Время", "${widget.time}"),
            const Spacer(),
          ],
        ),
        SizedBox(height: 90.v),
      ],
    );
  }

  Widget buildGameSequenceContent() {
    List<String> comp = ['Супер!', 'Здорово!', 'Класс!'];
    int rand = Random().nextInt(comp.length);
    return Column(
      children: [
        SizedBox(height: 20.v),
        Text(comp[rand], style: CustomTextStyles.extraBold32Primary),
        SizedBox(height: 30.v),
        Row(
          children: [
            const Spacer(),
            info_card("Раунд", "${widget.round}"),
            const Spacer(),
            info_card("Очки", "${widget.score}"),
            const Spacer(),
          ],
        ),
        SizedBox(height: 20.v)
      ],
    );
  }

  Widget buildGameImageContent() {
    return Column(
      children: [
        SizedBox(height: 40.v),
        Stack(
          fit: StackFit.passthrough,
          alignment: Alignment.center,
          children: [
            CircularPercentIndicator(
              radius: 71.h,
              animation: false,
              lineWidth: 19.h,
              percent: 1,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: theme.colorScheme.onPrimary,
              backgroundColor: appTheme.lightGray,
            ),
            CircularPercentIndicator(
              radius: 70.h,
              animation: true,
              lineWidth: 17.h,
              percent:
                  widget.correctAnswers != null && widget.totalQuestions != null
                      ? widget.correctAnswers! / widget.totalQuestions!
                      : 0,
              center: Text(
                '${((widget.correctAnswers != null && widget.totalQuestions != null ? widget.correctAnswers! / widget.totalQuestions! : 0) * 100).toStringAsFixed(0)}%',
                style: CustomTextStyles.regular24Text,
              ),
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: appTheme.white,
              progressColor: _calculateColor(),
            ),
          ],
        ),
        SizedBox(height: 10.v),
        Row(
          children: [
            const Spacer(),
            info_card("Ответы",
                "${widget.correctAnswers} из ${widget.totalQuestions}"),
            const Spacer(),
          ],
        ),
        SizedBox(height: 10.v),
      ],
    );
  }

  Widget buildStars() {
    int filledStars = 0;
    if (widget.isGameCards) {
      double scorePercentage = (widget.score != null && widget.maxScore != null)
          ? widget.score! / widget.maxScore!
          : 0;
      double triesPercentage = (widget.tries != null && widget.minTries != null)
          ? widget.tries! <= widget.minTries!
              ? 1
              : widget.minTries! / widget.tries!
          : 0;
      double percentage = scorePercentage * triesPercentage;
      filledStars = calculateStars(percentage);
    }
    if (widget.isGameSequence) {
      double percentage = (widget.score != null && widget.cond != null)
          ? widget.score! / widget.cond!
          : 0;
      filledStars = calculateStars(percentage);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Padding(
          padding: EdgeInsets.only(right: 12.h),
          child: Icon(
            index < filledStars
                ? FontAwesomeIcons.solidStar
                : FontAwesomeIcons.star,
            color: theme.colorScheme.primary,
            size: 50.h,
          ),
        );
      }),
    );
  }

  int calculateStars(double percentage) {
    if (widget.isGameCards) {
      if (percentage >= 0.8) {
        globalData.updateStars(3);
        return 3;
      } else if (percentage >= 0.6) {
        globalData.updateStars(2);
        return 2;
      } else if (percentage >= 0.4) {
        globalData.updateStars(1);
        return 1;
      } else {
        globalData.updateStars(0);
        return 0;
      }
    } else {
      if (percentage >= 2.0) {
        globalData.updateStars(3);
        return 3;
      } else if (percentage >= 1.5) {
        globalData.updateStars(2);
        return 2;
      } else if (percentage >= 1.0) {
        globalData.updateStars(1);
        return 1;
      } else {
        globalData.updateStars(0);
        return 0;
      }
    }
  }

  Color _calculateColor() {
    double percentage =
        (widget.correctAnswers != null && widget.totalQuestions != null)
            ? widget.correctAnswers! / widget.totalQuestions!
            : 0;

    if (percentage <= 0.2) {
      return Colors.red;
    } else if (percentage <= 0.4) {
      return Colors.orange;
    } else if (percentage <= 0.6) {
      return Colors.yellow;
    } else if (percentage <= 0.8) {
      return Colors.green;
    } else {
      return Colors.blue;
    }
  }

  Widget buildStory() {
    widget.scoreStory! <= widget.score!
        ? widget.scoreStory = widget.score
        : null;
    List<String> comp = ['Уровень пройден!', 'Неудача!'];
    globalData.updateIsReplay(widget.score! >= widget.cond! ? true : false);
    return Column(
      children: [
        Text(widget.score! >= widget.cond! ? comp[0] : comp[1],
            style: CustomTextStyles.extraBold32Primary),
        SizedBox(height: 20.v),
        Row(children: [
          const Spacer(),
          info_card("Очки", "${widget.score}"),
          const Spacer(),
          info_card('Рекорд', '${widget.scoreStory}'),
          const Spacer(),
        ]),
        SizedBox(height: 20.v),
        widget.score! >= widget.cond!
            ? buildStars()
            : Text('Повторим попытку?',
                style: CustomTextStyles.extraBold32Primary),
        SizedBox(height: 20.v),
      ],
    );
  }

  Widget buildFooter(BuildContext context, int money) {
    int query = 0;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('+ $money', style: CustomTextStyles.light20Text),
            SizedBox(width: 8.h),
            FaIcon(
              FontAwesomeIcons.coins,
              size: 25.h,
              color: appTheme.yellow,
            ),
          ],
        ),
        SizedBox(height: 30.v),
        CustomElevatedButton(
          text: "Переиграть",
          buttonTextStyle: CustomTextStyles.semiBold18TextWhite,
          buttonStyle: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onTap: () async {
            try {
              await supabase
                  .from('Characters')
                  .update({'money': globalData.money})
                  .eq('user_id', globalData.user_id)
                  .count(CountOption.exact);
              if (widget.game == 'cards') query = globalData.countGame1;
              if (widget.game == 'sequence') query = globalData.countGame2;
              if (widget.game == 'image') query = globalData.countGame3;
              await supabase
                  .from('GameRule')
                  .update({'quantity': query})
                  .eq('user_id', globalData.user_id)
                  .eq('game', widget.game)
                  .count(CountOption.exact);
              if (widget.isGameSequence || widget.isGameCards) {
                await supabase
                    .from('GameRule')
                    .update({
                      'best_score':
                          widget.game == 'cards' ? widget.score : widget.round
                    })
                    .eq('user_id', globalData.user_id)
                    .eq('game', widget.game)
                    .count(CountOption.exact);
              }
              final res = await supabase
                  .from('Statistics')
                  .select('score')
                  .eq('user_id', globalData.user_id)
                  .eq('date_game',
                      DateTime.now().toIso8601String().split('T')[0])
                  .count();
              globalData.updateScore(res.data[0]['score']);
              await supabase
                  .from('Statistics')
                  .update({
                    'score': globalData.score +
                        (widget.isGameImage ? money * 10 : widget.score!)
                  })
                  .eq('user_id', globalData.user_id)
                  .eq('date_game', DateTime.now().toIso8601String())
                  .count();
              if (widget.isStory) {
                final res = await supabase
                    .from('Levels')
                    .select()
                    .eq('user_id', globalData.user_id)
                    .eq('number', widget.currentLevel / 10)
                    .single()
                    .count();
                globalData.updateStars(globalData.stars > res.data['stars']
                    ? globalData.stars
                    : res.data['stars']);
                await supabase
                    .from('Levels')
                    .update({
                      'stars': globalData.stars,
                      'score': widget.scoreStory! <= widget.score!
                          ? widget.scoreStory
                          : widget.score,
                      'is_replay': globalData.isReplay
                    })
                    .eq('user_id', globalData.user_id)
                    .eq('number', widget.currentLevel / 10)
                    .count();
                await supabase
                    .from('Levels')
                    .update({'is_available': true})
                    .eq('user_id', globalData.user_id)
                    .eq('number', (widget.currentLevel + 1) / 10)
                    .count();
              }
            } catch (error) {
              print('$error');
            }
            if (widget.isStory) {
              getGamePath(widget.currentLevel);
            } else {
              GoRouter.of(context).push(widget.goRoute);
            }
          },
        ),
        SizedBox(height: 24.v),
        if (widget.isStory)
          CustomElevatedButton(
              text: "Продолжить",
              buttonTextStyle: CustomTextStyles.semiBold18TextWhite,
              buttonStyle: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onTap: () async {
                await supabase
                    .from('Characters')
                    .update({'money': globalData.money})
                    .eq('user_id', globalData.user_id)
                    .count(CountOption.exact);
                if (widget.game == 'cards') query = globalData.countGame1;
                if (widget.game == 'sequence') query = globalData.countGame2;
                if (widget.game == 'image') query = globalData.countGame3;
                await supabase
                    .from('GameRule')
                    .update({'quantity': query})
                    .eq('user_id', globalData.user_id)
                    .eq('game', widget.game)
                    .count(CountOption.exact);
                if (widget.isGameSequence || widget.isGameCards) {
                  await supabase
                      .from('GameRule')
                      .update({
                        'best_score':
                            widget.game == 'cards' ? widget.score : widget.round
                      })
                      .eq('user_id', globalData.user_id)
                      .eq('game', widget.game)
                      .count(CountOption.exact);
                }
                final res = await supabase
                    .from('Statistics')
                    .select('score')
                    .eq('user_id', globalData.user_id)
                    .eq('date_game',
                        DateTime.now().toIso8601String().split('T')[0])
                    .count();
                globalData.updateScore(res.data[0]['score']);
                await supabase
                    .from('Statistics')
                    .update({
                      'score': globalData.score +
                          (widget.isGameImage ? money * 10 : widget.score!)
                    })
                    .eq('user_id', globalData.user_id)
                    .eq('date_game',
                        DateTime.now().toIso8601String().split('T')[0])
                    .count();
                final res1 = await supabase
                    .from('Levels')
                    .select()
                    .eq('user_id', globalData.user_id)
                    .eq('number', widget.currentLevel / 10)
                    .single()
                    .count();
                globalData.updateStars(globalData.stars > res1.data['stars']
                    ? globalData.stars
                    : res1.data['stars']);
                await supabase
                    .from('Levels')
                    .update({
                      'stars': globalData.stars,
                      'score': widget.scoreStory! <= widget.score!
                          ? widget.scoreStory
                          : widget.score,
                      'is_replay': globalData.isReplay
                    })
                    .eq('user_id', globalData.user_id)
                    .eq('number', widget.currentLevel / 10)
                    .count();
                await supabase
                    .from('Levels')
                    .update({'is_available': true})
                    .eq('user_id', globalData.user_id)
                    .eq('number', (widget.currentLevel + 1) / 10)
                    .count();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DialogGame(
                        isStart: false,
                        isEndSuc: globalData.isReplay,
                        isEndFail: !globalData.isReplay),
                  ),
                );
              }),
        if (!widget.isStory)
          CustomElevatedButton(
            text: "Выход",
            buttonTextStyle: CustomTextStyles.semiBold18TextWhite,
            buttonStyle: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onTap: () async {
              try {
                await supabase
                    .from('Characters')
                    .update({'money': globalData.money})
                    .eq('user_id', globalData.user_id)
                    .count(CountOption.exact);
                if (widget.game == 'cards') query = globalData.countGame1;
                if (widget.game == 'sequence') query = globalData.countGame2;
                if (widget.game == 'image') query = globalData.countGame3;
                await supabase
                    .from('GameRule')
                    .update({'quantity': query})
                    .eq('user_id', globalData.user_id)
                    .eq('game', widget.game)
                    .count(CountOption.exact);
                if (widget.isGameSequence || widget.isGameCards) {
                  await supabase
                      .from('GameRule')
                      .update({
                        'best_score':
                            widget.game == 'cards' ? widget.score : widget.round
                      })
                      .eq('user_id', globalData.user_id)
                      .eq('game', widget.game)
                      .count(CountOption.exact);
                }
                final res = await supabase
                    .from('Statistics')
                    .select('score')
                    .eq('user_id', globalData.user_id)
                    .eq('date_game',
                        DateTime.now().toIso8601String().split('T')[0])
                    .count();
                globalData.updateScore(res.data[0]['score']);
                await supabase
                    .from('Statistics')
                    .update({
                      'score': globalData.score +
                          (widget.isGameImage ? money * 10 : widget.score!)
                    })
                    .eq('user_id', globalData.user_id)
                    .eq('date_game',
                        DateTime.now().toIso8601String().split('T')[0])
                    .count();
              } catch (error) {
                print('$error');
              }
              GoRouter.of(context).push(AppRoutes.homepage);
            },
          ),
        SizedBox(height: 30.v),
      ],
    );
  }
}
