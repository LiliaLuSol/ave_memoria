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
  GlobalData globalData = GlobalData();
  String nameGame3 = '';
  String game3Rule1 = '';
  String game3Rule2 = '';

  int correctAnswers = 0;
  int currentQuestionIndex = 0;
  int questionNumber = 0;
  late bool _isFinished;
  late bool _isStart;
  late int randomIndex;
  late Timer _timer;

  List<ImageQuestion> imageQuestions = [
    ImageQuestion(
      imagePath: ImageConstant.imgImage_1,
      questions: [
        Question(
          text: 'Какое животное изображено на картинке?',
          options: ['Собака', 'Кошка', 'Лев', 'Тигр'],
          correctIndex: 2,
        ),
        Question(
          text: 'Как называется самое большое животное на Земле?',
          options: ['Слон', 'Кит', 'Гиппопотам', 'Бегемот'],
          correctIndex: 1,
        ),
        Question(
          text: 'Какое животное является символом США?',
          options: ['Орёл', 'Буйвол', 'Медведь', 'Американский питбультерьер'],
          correctIndex: 0,
        ),
        Question(
          text: 'Что едят кенгуру?',
          options: ['Трава', 'Плоды', 'Планктон', 'Мясо'],
          correctIndex: 0,
        ),
        Question(
          text: 'Где живут пингвины?',
          options: ['Арктика', 'Антарктида', 'Сахара', 'Амазонка'],
          correctIndex: 1,
        ),
        Question(
          text: 'Как называется животное, которое спит зимой в норе?',
          options: ['Медведь', 'Слон', 'Енот', 'Барсук'],
          correctIndex: 3,
        ),
        Question(
          text: 'Как называется самая длинная змея в мире?',
          options: ['Питон', 'Анаконда', 'Удав', 'Кобра'],
          correctIndex: 1,
        ),
        Question(
          text: 'Сколько ног у паука?',
          options: ['4', '6', '8', '10'],
          correctIndex: 2,
        ),
        Question(
          text: 'Какое животное считается самым быстрым на Земле?',
          options: ['Гепард', 'Лев', 'Олень', 'Тигр'],
          correctIndex: 0,
        ),
        Question(
          text: 'Какой птицей является символ мира?',
          options: ['Голубь', 'Орёл', 'Страус', 'Сова'],
          correctIndex: 0,
        ),
      ],
    ),
    ImageQuestion(
      imagePath: ImageConstant.imgImage_2,
      questions: [
        Question(
          text: 'Какое животное изображено на картинке?',
          options: ['Собака', 'Кошка', 'Лев', 'Тигр'],
          correctIndex: 2,
        ),
        Question(
          text: 'Как называется самое большое животное на Земле?',
          options: ['Слон', 'Кит', 'Гиппопотам', 'Бегемот'],
          correctIndex: 1,
        ),
        Question(
          text: 'Какое животное является символом США?',
          options: ['Орёл', 'Буйвол', 'Медведь', 'Американский питбультерьер'],
          correctIndex: 0,
        ),
        Question(
          text: 'Что едят кенгуру?',
          options: ['Трава', 'Плоды', 'Планктон', 'Мясо'],
          correctIndex: 0,
        ),
        Question(
          text: 'Где живут пингвины?',
          options: ['Арктика', 'Антарктида', 'Сахара', 'Амазонка'],
          correctIndex: 1,
        ),
        Question(
          text: 'Как называется животное, которое спит зимой в норе?',
          options: ['Медведь', 'Слон', 'Енот', 'Барсук'],
          correctIndex: 3,
        ),
        Question(
          text: 'Как называется самая длинная змея в мире?',
          options: ['Питон', 'Анаконда', 'Удав', 'Кобра'],
          correctIndex: 1,
        ),
        Question(
          text: 'Сколько ног у паука?',
          options: ['4', '6', '8', '10'],
          correctIndex: 2,
        ),
        Question(
          text: 'Какое животное считается самым быстрым на Земле?',
          options: ['Гепард', 'Лев', 'Олень', 'Тигр'],
          correctIndex: 0,
        ),
        Question(
          text: 'Какой птицей является символ мира?',
          options: ['Голубь', 'Орёл', 'Страус', 'Сова'],
          correctIndex: 0,
        ),
      ],
    ),
    ImageQuestion(
      imagePath: ImageConstant.imgImage_3,
      questions: [
        Question(
          text: 'Какое животное изображено на картинке?',
          options: ['Собака', 'Кошка', 'Лев', 'Тигр'],
          correctIndex: 2,
        ),
        Question(
          text: 'Как называется самое большое животное на Земле?',
          options: ['Слон', 'Кит', 'Гиппопотам', 'Бегемот'],
          correctIndex: 1,
        ),
        Question(
          text: 'Какое животное является символом США?',
          options: ['Орёл', 'Буйвол', 'Медведь', 'Американский питбультерьер'],
          correctIndex: 0,
        ),
        Question(
          text: 'Что едят кенгуру?',
          options: ['Трава', 'Плоды', 'Планктон', 'Мясо'],
          correctIndex: 0,
        ),
        Question(
          text: 'Где живут пингвины?',
          options: ['Арктика', 'Антарктида', 'Сахара', 'Амазонка'],
          correctIndex: 1,
        ),
        Question(
          text: 'Как называется животное, которое спит зимой в норе?',
          options: ['Медведь', 'Слон', 'Енот', 'Барсук'],
          correctIndex: 3,
        ),
        Question(
          text: 'Как называется самая длинная змея в мире?',
          options: ['Питон', 'Анаконда', 'Удав', 'Кобра'],
          correctIndex: 1,
        ),
        Question(
          text: 'Сколько ног у паука?',
          options: ['4', '6', '8', '10'],
          correctIndex: 2,
        ),
        Question(
          text: 'Какое животное считается самым быстрым на Земле?',
          options: ['Гепард', 'Лев', 'Олень', 'Тигр'],
          correctIndex: 0,
        ),
        Question(
          text: 'Какой птицей является символ мира?',
          options: ['Голубь', 'Орёл', 'Страус', 'Сова'],
          correctIndex: 0,
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
    _timer = Timer(Duration(seconds: 20), () {
      if (_isStart) {
        setState(() {
          _isStart = false;
        });
      }
    });
  }

  @override
  void initState() {
    nameGame3 = globalData.nameGame3;
    game3Rule1 = globalData.game3Rule1;
    game3Rule2 = globalData.game3Rule2;
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
    List<Question> questions =
        imageQuestions[randomIndex].questions.take(5).toList();
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
                            "Картинка будет представлена на 20 секунд. Запомните как можно больше деталей!",
                            style: CustomTextStyles.regular24Text,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 40.v),
                          Image.asset(
                            imageQuestions[randomIndex].imagePath,
                            width: 353.h,
                          ),
                          SizedBox(height: 40.v),
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
                nameGame: nameGame3,
                goRoute: AppRoutes.game_image,
                isGameImage: true,
                correctAnswers: correctAnswers,
                totalQuestions: 5,
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
                                  Text(nameGame3,
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
                                                          AppRoutes.game_image,
                                                      countRule: 2,
                                                      text1: game3Rule1,
                                                      text2: game3Rule2,
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
                                  info_card("Вопрос", "$questionNumber из 5"),
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
                                            if (currentQuestionIndex <
                                                questions.length - 1) {
                                              setState(() {
                                                currentQuestionIndex++;
                                                questionNumber++;
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
