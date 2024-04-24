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
  int questionNumber = 0;
  late bool _isFinished;
  late bool _isStart;
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
        Question(
          text: 'Сколько лап у этого животного?',
          options: ['0', '0', '0', '0'],
          correctIndex: 0,
        ),
        Question(
          text: 'Сколько лап у этого животного?',
          options: ['1', '1', '1', '1'],
          correctIndex: 1,
        ),
        Question(
          text: 'Сколько лап у этого животного?',
          options: ['2', '2', '2', '2'],
          correctIndex: 2,
        ),
        Question(
          text: 'Сколько лап у этого животного?',
          options: ['3', '3', '3', '3'],
          correctIndex: 3,
        ),
        Question(
          text: 'Сколько лап у этого животного?',
          options: ['4', '4', '4', '4'],
          correctIndex: 3,
        ),
        Question(
            text: 'Сколько лап у этого животного?',
            options: ['5', '5', '5', '5'],
            correctIndex: 3),
        Question(
          text: 'Сколько лап у этого животного?',
          options: ['6', '6', '6', '6'],
          correctIndex: 3,
        ),
        Question(
          text: 'Сколько лап у этого животного?',
          options: ['8', '8', '8', '8'],
          correctIndex: 3,
        ),
      ],
    ),
    ImageQuestion(
      imagePath: 'assets/image2.png',
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
        Question(
          text: 'Сколько лап у этого животного?',
          options: ['0', '0', '0', '0'],
          correctIndex: 0,
        ),
        Question(
          text: 'Сколько лап у этого животного?',
          options: ['1', '1', '1', '1'],
          correctIndex: 1,
        ),
        Question(
          text: 'Сколько лап у этого животного?',
          options: ['2', '2', '2', '2'],
          correctIndex: 2,
        ),
        Question(
          text: 'Сколько лап у этого животного?',
          options: ['3', '3', '3', '3'],
          correctIndex: 3,
        ),
        Question(
          text: 'Сколько лап у этого животного?',
          options: ['4', '4', '4', '4'],
          correctIndex: 3,
        ),
        Question(
            text: 'Сколько лап у этого животного?',
            options: ['5', '5', '5', '5'],
            correctIndex: 3),
        Question(
          text: 'Сколько лап у этого животного?',
          options: ['6', '6', '6', '6'],
          correctIndex: 3,
        ),
        Question(
          text: 'Сколько лап у этого животного?',
          options: ['8', '8', '8', '8'],
          correctIndex: 3,
        ),
      ],
    ),
    ImageQuestion(
      imagePath: 'assets/image3.png',
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
        Question(
          text: 'Сколько лап у этого животного?',
          options: ['0', '0', '0', '0'],
          correctIndex: 0,
        ),
        Question(
          text: 'Сколько лап у этого животного?',
          options: ['1', '1', '1', '1'],
          correctIndex: 1,
        ),
        Question(
          text: 'Сколько лап у этого животного?',
          options: ['2', '2', '2', '2'],
          correctIndex: 2,
        ),
        Question(
          text: 'Сколько лап у этого животного?',
          options: ['3', '3', '3', '3'],
          correctIndex: 3,
        ),
        Question(
          text: 'Сколько лап у этого животного?',
          options: ['4', '4', '4', '4'],
          correctIndex: 3,
        ),
        Question(
            text: 'Сколько лап у этого животного?',
            options: ['5', '5', '5', '5'],
            correctIndex: 3),
        Question(
          text: 'Сколько лап у этого животного?',
          options: ['6', '6', '6', '6'],
          correctIndex: 3,
        ),
        Question(
          text: 'Сколько лап у этого животного?',
          options: ['8', '8', '8', '8'],
          correctIndex: 3,
        ),
      ],
    ),
  ];

  void initializeGameData() {
    correctAnswers = 0;
    currentQuestionIndex = 0;
    questionNumber = 1;
    _isStart = true;
    _isFinished = false;
    randomIndex = Random().nextInt(imageQuestions.length);
    imageQuestions[randomIndex].questions.shuffle();
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
    List<Question> questions = imageQuestions[randomIndex].questions.take(5).toList();
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
                          Image.asset(
                            imageQuestions[randomIndex].imagePath,
                            width: 200,
                            height: 200,
                          ),
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
                                  info_card("Вопрос", "$questionNumber"),
                                  Spacer(),
                                ],
                              ),
                              SizedBox(height: 22.v),
                              Divider(height: 1, color: appTheme.gray)
                            ])),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.h),
                            child: Column(children: [
                              // Spacer(),
                              SizedBox(height: 150.v),
                              Text(
                                questions[currentQuestionIndex].text,
                                style: CustomTextStyles.regular16Text,
                              ),
                              //       Spacer(),
                              SizedBox(height: 150.v),
                              Column(
                                children: questions[currentQuestionIndex]
                                    .options
                                    .map((option) => Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.v),
                                        child: CustomElevatedButton(
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
                                            print(currentQuestionIndex);
                                            print(questions.length - 1);
                                            if (currentQuestionIndex < questions.length - 1) {
                                              setState(() {
                                                currentQuestionIndex++;
                                                questionNumber++;
                                                print(questions);
                                                print(currentQuestionIndex);
                                              });
                                            } else {
                                              setState(() {
                                                _isFinished = true;
                                              });
                                            }
                                          },
                                          text: option,
                                        )))
                                    .toList(),
                              )
                            ]))
                      ],
                    ),
                  ),
                ),
              );
  }
}
