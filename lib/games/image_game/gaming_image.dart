import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';
import '../../pages/pause_menu.dart';
import '../../pages/result_game.dart';
import 'utils.dart';

class ImageGame extends StatefulWidget {
  const ImageGame({super.key});

  @override
  _ImageGameState createState() => _ImageGameState();
}

class _ImageGameState extends State<ImageGame> {
  int correctAnswers = 0;
  int currentQuestionIndex = 0;
  late bool _isFinished;
  late bool _isStart;
  late int score;
  late int tries;
  late int randomIndex;
  late Timer _timer;

  List<ImageQuestion> imageQuestions = [
    ImageQuestion(
      imagePath: 'assets/image1.png',
      questions: [
        Question(
          text: 'Какое животное изображено на картинке?',
          options: ['Собака', 'Кошка', 'Лев', 'Тигр'],
          correctIndex: 2,
        ),
        Question(
          text: 'Сколько лап у этого животного?',
          options: ['2', '4', '6', '8'],
          correctIndex: 1,
        ),
      ],
    ),
    //  другие картинки и вопросы...
  ];

  void initializeGameData() {
    correctAnswers = 0;
    currentQuestionIndex = 0;
    tries = 0;
    score = 0;
    _isStart = true;
    _isFinished = false;
    randomIndex = Random().nextInt(imageQuestions.length);
    ImageQuestion randomImageQuestion = imageQuestions[randomIndex];
  }

  void startGameIfTrue() {
    _timer = Timer(Duration(seconds: 10), () {
      if (_isStart) {
        setState(() {
          _isStart = false;
        });
      }
    });
  }

  @override
  void initState() {
    initializeGameData();
    startGameIfTrue();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    List<Question> questions = imageQuestions[currentQuestionIndex].questions;
    return _isStart
        ? SafeArea(
            child: Scaffold(
                body: Padding(
                    padding: EdgeInsets.all(16.v),
                    child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Text(
                            "Картинка будет представлена на 10 секунд. Запомните как можено больше деталей!",
                            style: CustomTextStyles.regular24Text,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20.v),
                          Image.asset('assets/image1.png',
                              width: 200, height: 200),
                          SizedBox(height: 20.v),
                          CustomElevatedButton(
                            text: "Начать раньше",
                            buttonTextStyle:
                                CustomTextStyles.semiBold18TextWhite,
                            buttonStyle: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            onTap: () {
                              setState(() {
                                _isStart = false;
                              });
                            },
                          )
                        ])))))
        : _isFinished
            ? ResultGame(
                nameGame: "Римские картинки",
                goRoute: AppRoutes.game_image,
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
                                                fullscreenDialog: true));
                                      }),
                                  SizedBox(width: 16.h),
                                ],
                              ),
                              SizedBox(height: 22.v),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Spacer(),
                                  info_card("Попытки", "$tries"),
                                  Spacer(),
                                  info_card("Очки", "$score"),
                                  Spacer(),
                                  info_card("Время", "0"),
                                  Spacer(),
                                ],
                              ),
                              SizedBox(height: 22.v),
                              Divider(height: 1, color: appTheme.gray)
                            ])),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.v),
                            child:
                            Column(children: [
                              // Spacer(),
                              SizedBox(height: 22.v),
                              Text(questions[currentQuestionIndex].text, style: CustomTextStyles.regular16Text,),
                        //       Spacer(),
                              SizedBox(height: 22.v),
                              Column(
                                children: questions[currentQuestionIndex]
                                    .options
                                    .map((option) => CustomElevatedButton(
                                          onTap: () {
                                            if (option ==
                                                questions[currentQuestionIndex]
                                                    .options[questions[
                                                        currentQuestionIndex]
                                                    .correctIndex]) {
                                              setState(() {
                                                correctAnswers++;
                                              });
                                            }
                                            if (currentQuestionIndex <
                                                questions.length - 1) {
                                              setState(() {
                                                currentQuestionIndex++;
                                              });
                                            } else {
                                              setState(() {
                                                _isFinished = true;
                                              });
                                            }
                                          },
                                          text: option,
                                        ))
                                    .toList(),
                              ),
                        //       Spacer(),
                            ])
                        )
                      ],
                    ),
                  ),
                ),
              );
  }
}
