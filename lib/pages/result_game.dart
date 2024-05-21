import 'dart:math';
import 'package:ave_memoria/other/app_export.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';

class ResultGame extends StatelessWidget {
  final String nameGame;
  final String goRoute;
  final int? tries;
  final int? round;
  final int? score;
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
  });

  GlobalData globalData = GlobalData();

  @override
  Widget build(BuildContext context) {
    int money = 1;
    if (isGameImage) {
      money = ((correctAnswers != null && totalQuestions != null)
          ? ((correctAnswers! / totalQuestions!) * 10).toInt()
          : 1);
      globalData.updateCount(30, 1);
    }
    if (isGameCards) {
      const int maxScore = 600;
      const int minTries = 6;
      const int maxTries = 100;
      const double scoreWeight = 0.7;
      const double triesWeight = 0.3;
      double normalizedScore = score! / maxScore;
      double normalizedTries = (tries! <= minTries)
          ? 1.0
          : (maxTries - tries!).toDouble() / (maxTries - minTries);
      double combinedNormalizedValue =
          (normalizedScore * scoreWeight) + (normalizedTries * triesWeight);
      int minMoney = 1;
      int maxMoney = 12;
      money = ((combinedNormalizedValue * (maxMoney - minMoney)) + minMoney)
          .toInt();
      globalData.updateCount(10, 1);
      score! > globalData.best1 ? globalData.updateBest(1, score!) : null;
    }
    if (isGameSequence) {
      int a = round! > 1 ? round! : 0;
      money = a * 2 + (score! / 100).ceil();
      money == 0 ? money = 1 : null;
      globalData.updateCount(20, 1);
      round! > globalData.best2 ? globalData.updateBest(2, round!) : null;
    }
    globalData.updateMoney(globalData.money + money);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFC0C0C0),
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
                    nameGame,
                    style: CustomTextStyles.regular24Text,
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  buildContent(),
                  Spacer(),
                  buildFooter(context, money!),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContent() {
    if (isGameCards) {
      return buildGameCardsContent();
    } else if (isGameSequence) {
      return buildGameSequenceContent();
    } else if (isGameImage) {
      return buildGameImageContent();
    } else {
      return buildStory();
    }
  }

  Widget buildGameCardsContent() {
    return Column(
      children: [
        SizedBox(height: 90.v),
        Row(
          children: [
            Spacer(),
            info_card("Попытки", "$tries"),
            Spacer(),
            info_card("Очки", "$score"),
            Spacer(),
            info_card("Время", "$time"),
            Spacer(),
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
            Spacer(),
            info_card("Раунд", "$round"),
            Spacer(),
            info_card("Очки", "$score"),
            Spacer(),
          ],
        ),
        SizedBox(
          height: 20.v,
        )
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
              percent: correctAnswers != null && totalQuestions != null
                  ? correctAnswers! / totalQuestions!
                  : 0,
              center: Text(
                '${((correctAnswers != null && totalQuestions != null ? correctAnswers! / totalQuestions! : 0) * 100).toStringAsFixed(0)}%',
                style: CustomTextStyles.regular24Text,
              ),
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: appTheme.white,
              progressColor: _calculateColor(),
            ),
          ],
        ),
        SizedBox(
          height: 10.v,
        ),
        Row(
          children: [
            Spacer(),
            info_card("Ответы", "$correctAnswers из $totalQuestions"),
            Spacer(),
          ],
        ),
        SizedBox(
          height: 10.v,
        ),
      ],
    );
  }

  Widget buildStars() {
    double scorePercentage =
        (score != null && maxScore != null) ? score! / maxScore! : 0;
    double triesPercentage = (tries != null && minTries != null)
        ? (tries! - minTries!) / minTries!
        : 0;
    double percentage = (scorePercentage + triesPercentage) / 2;
    int filledStars = calculateStars(percentage);

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
    if (percentage >= 0.8) {
      return 3;
    } else if (percentage >= 0.6) {
      return 2;
    } else if (percentage >= 0.4) {
      return 1;
    } else {
      return 0;
    }
  }

  Color _calculateColor() {
    double percentage = (correctAnswers != null && totalQuestions != null)
        ? correctAnswers! / totalQuestions!
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
    return Column(
      children: [
        buildStars(),
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
              if (game == 'cards') query = globalData.countGame1;
              if (game == 'sequence') query = globalData.countGame2;
              if (game == 'image') query = globalData.countGame3;
              await supabase
                  .from('GameRule')
                  .update({'quantity': query})
                  .eq('user_id', globalData.user_id)
                  .eq('game', game)
                  .count(CountOption.exact);
              if (isGameSequence || isGameCards) {
                await supabase
                  .from('GameRule')
                  .update({'best_score': game == 'cards'? score : round})
                  .eq('user_id', globalData.user_id)
                  .eq('game', game)
                  .count(CountOption.exact);
              }
            } catch (error) {
              print('без денег $error');
            }
            ;
            GoRouter.of(context).push(goRoute);
          },
        ),
        SizedBox(height: 24.v),
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
              if (game == 'cards') query = globalData.countGame1;
              if (game == 'sequence') query = globalData.countGame2;
              if (game == 'image') query = globalData.countGame3;
              await supabase
                  .from('GameRule')
                  .update({'quantity': query})
                  .eq('user_id', globalData.user_id)
                  .eq('game', game)
                  .count(CountOption.exact);
            } catch (error) {
              print('без денег $error');
            }
            ;
            GoRouter.of(context).push(AppRoutes.homepage);
          },
        ),
        SizedBox(height: 30.v),
      ],
    );
  }
}
