import 'dart:ui';

import 'package:ave_memoria/other/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ResultGame extends StatefulWidget {
  final String nameGame;
  final String goRoute;
  final int? tries;
  final int? rounde;
  final int? score;
  final int? time;
  final int? minTries;
  final int? maxScore;
  final int? correctAnswers;
  final int? totalQuestions;
  final bool? isGameCards;
  final bool? isGameSequence;
  final bool? isGameImage;
  final bool? isStory;

  const ResultGame(
      {super.key,
      required this.nameGame,
      required this.goRoute,
      this.tries,
      this.rounde,
      this.score,
      this.time,
      this.minTries,
      this.maxScore,
      this.correctAnswers,
      this.totalQuestions,
      this.isGameCards,
      this.isGameSequence,
      this.isGameImage,
      this.isStory});

  @override
  State<ResultGame> createState() => _ResultGameState();
}

class _ResultGameState extends State<ResultGame> {
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    double scorePercentage = widget.score != null && widget.maxScore != null
        ? widget.score! / widget.maxScore!
        : 0;
    double triesPercentage = widget.tries != null && widget.minTries != null
        ? (widget.tries! - widget.minTries!) / widget.minTries!
        : 0;
    int filledStars = 0;
    double percentage = (scorePercentage + triesPercentage) / 2;
    if (percentage >= 0.8) {
      filledStars = 3;
    } else if (percentage >= 0.6) {
      filledStars = 2;
    } else if (percentage >= 0.4) {
      filledStars = 1;
    }

    List<Widget> stars = List.generate(3, (index) {
      if (index < filledStars) {
        return Padding(
            padding: EdgeInsets.only(right: 12.h),
            child: Icon(FontAwesomeIcons.solidStar,
                color: theme.colorScheme.primary, size: 50.h));
      } else {
        return Padding(
            padding: EdgeInsets.only(right: 12.h),
            child: Icon(FontAwesomeIcons.star,
                color: theme.colorScheme.primary, size: 50.h));
      }
    });

    Color _calculateColor() {
      double percentage =
          (widget.correctAnswers != null && widget.totalQuestions != null
              ? widget.correctAnswers! / widget.totalQuestions!
              : 0);

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

    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xFFC0C0C0),
            body: Center(
                child: Container(
                    width: 353.h,
                    height: 563.v,
                    decoration: AppDecoration.outlineGray.copyWith(
                        borderRadius: BorderRadiusStyle.circleBorder15),
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.h),
                        child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 35.v),
                              Text(widget.nameGame,
                                  style: CustomTextStyles.regular24Text,
                                  textAlign: TextAlign.center),
                              if (widget.isGameCards ?? false)
                                SizedBox(height: 60.v),
                              if (widget.isGameImage ?? false)
                              SizedBox(height: 40.v),
                              if (widget.isGameSequence ?? false)
                                SizedBox(height: 30.v),
                              if (widget.isGameSequence ?? false)
                                Text('Супер!', style: CustomTextStyles.extraBold32Primary,),
                              if (widget.isGameSequence ?? false)
                                SizedBox(height: 30.v),
                              if (widget.isStory ?? false)
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Spacer(),
                                      SizedBox(width: 12.h),
                                      ...stars,
                                      Spacer()
                                    ]),
                              if (widget.isGameImage ?? false)
                                Stack(
                                    fit: StackFit.passthrough,
                                    alignment: Alignment.center,
                                    children: [
                                      CircularPercentIndicator(
                                        radius: 71.h,
                                        animation: false,
                                        lineWidth: 19.h,
                                        percent: 1,
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                        progressColor:
                                            theme.colorScheme.onPrimary,
                                        backgroundColor: appTheme.lightGray,
                                      ),
                                      CircularPercentIndicator(
                                        radius: 70.h,
                                        animation: true,
                                        lineWidth: 17.h,
                                        percent: widget.correctAnswers !=
                                                    null &&
                                                widget.totalQuestions != null
                                            ? widget.correctAnswers! /
                                                widget.totalQuestions!
                                            : 0,
                                        center: Text(
                                            '${((widget.correctAnswers != null && widget.totalQuestions != null ? widget.correctAnswers! / widget.totalQuestions! : 0) * 100).toStringAsFixed(0)}%',
                                            style:
                                                CustomTextStyles.regular24Text),
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                        backgroundColor: appTheme.white,
                                        progressColor: _calculateColor(),
                                      )
                                    ]),
                              if (widget.isGameCards ?? false)
                                SizedBox(height: 30.v),
                              if (widget.isGameImage ?? false) Spacer(),
                              Row(children: [
                                Spacer(),
                                if (widget.isGameImage ?? false)
                                  info_card("Ответы",
                                      "${widget.correctAnswers} из ${widget.totalQuestions}"),
                                if (widget.isGameSequence ?? false)
                                  info_card("Раунд", "${widget.rounde}"),
                                if (widget.isGameCards ?? false)
                                  info_card("Попытки", "${widget.tries}"),
                                Spacer(),
                                if ((widget.isGameCards ?? false) ||
                                    (widget.isGameSequence ?? false))
                                  info_card("Очки", "${widget.score}"),
                                if ((widget.isGameCards ?? false) ||
                                    (widget.isGameSequence ?? false))
                                  Spacer(),
                                if (widget.isGameCards ?? false)
                                  info_card("Время", "${widget.time}"),
                                if (widget.isGameCards ?? false) Spacer(),
                              ]),
                              Spacer(),
                              Row(mainAxisAlignment:MainAxisAlignment.center,children: [
                                Text('+ 7', style: CustomTextStyles.light20Text,),
                                SizedBox(width: 8.h,),
                                FaIcon(
                                  FontAwesomeIcons.coins,
                                  size: 25.h,
                                  color: appTheme.yellow,
                                ),
                              ]),
                              if (widget.isGameCards ?? false)
                                SizedBox(height: 30.v),
                                  if (widget.isGameSequence ?? false)
                                SizedBox(height: 60.v),
                              Spacer(),
                              CustomElevatedButton(
                                text: "Переиграть",
                                buttonTextStyle:
                                    CustomTextStyles.semiBold18TextWhite,
                                buttonStyle: ElevatedButton.styleFrom(
                                    backgroundColor: theme.colorScheme.primary,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                                onTap: () {
                                  GoRouter.of(context).push(widget.goRoute);
                                },
                              ),
                              SizedBox(height: 24.v),
                              CustomElevatedButton(
                                  text: "Выход",
                                  buttonTextStyle:
                                      CustomTextStyles.semiBold18TextWhite,
                                  buttonStyle: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          theme.colorScheme.primary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                  onTap: () {
                                    GoRouter.of(context)
                                        .push(AppRoutes.homepage);
                                  }),
                              Spacer()
                            ]))))));
  }
}
