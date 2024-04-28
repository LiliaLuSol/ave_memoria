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
          text: 'Какой цвет у ленты на шляпке девушки?',
          options: ['Голубой', 'Розовый', 'Черный', 'Желтый'],
          correctIndex: 2,
        ),
        Question(
          text: 'Была ли шляпа у мужчины?',
          options: [
            'Да, в левой руке',
            'Да, в правой руке',
            'Да, на голове',
            'Нет'
          ],
          correctIndex: 3,
        ),
        Question(
          text: 'Был ли объект розового цвета?',
          options: ['Нет', 'Да, воздушный шарик', 'Да, мячик', 'Да, шляпа'],
          correctIndex: 0,
        ),
        Question(
          text: 'Была ли карта на фото?',
          options: [
            'Нет',
            'Да, лежала рядом с парой',
            'Да, стенд стоял снизу',
            'Да, карта весела на здании'
          ],
          correctIndex: 1,
        ),
        Question(
          text: 'Какого цвета юбка у девушки?',
          options: ['Красная', 'Желтая', 'Синяя', 'Черная'],
          correctIndex: 3,
        ),
        Question(
          text: 'На какой руке кольца у парня?',
          options: ['На левой', 'На правой', 'На двух', 'Ни на одной'],
          correctIndex: 2,
        ),
        Question(
          text: 'Была ли сумка на фото?',
          options: [
            'Нет',
            'Да, лежала рядом с девушкой',
            'Да, лежала рядом с парнем',
            'Да, весела на плече девушки'
          ],
          correctIndex: 3,
        ),
        Question(
          text: 'На какой руке парня находятся часы?',
          options: ['Ни на одной', 'На левой', 'На правой', 'На двух'],
          correctIndex: 1,
        ),
        Question(
          text: 'Каого объекта не было на фото?',
          options: ['Фотоаппарат', 'Фонарь', 'Самолет', 'Браслет'],
          correctIndex: 2,
        ),
      ],
    ),
    ImageQuestion(
      imagePath: ImageConstant.imgImage_2,
      questions: [
        Question(
          text: 'На какой руке у мужчины часы?',
          options: ['Ни на одной', 'На левой', 'На правой'],
          correctIndex: 2,
        ),
        Question(
          text: 'Какого цвета кепка у мужчины?',
          options: [
            'Красно-черная',
            'Бело-черная',
            'Бело-Красная',
            'Красно-серая'
          ],
          correctIndex: 1,
        ),
        Question(
          text: 'Какого цвета футболка у мужчины?',
          options: ['Футболки нет', 'Красная', 'Белая', 'Черная'],
          correctIndex: 3,
        ),
        Question(
          text: 'Какого цвета кроссовки у девушки?',
          options: ['Черные', 'Красные', 'Серые', 'Белые'],
          correctIndex: 3,
        ),
        Question(
          text: 'Какого цвета тент у телеги?',
          options: ['Зеленый', 'Коричневый', 'Оранжевый', 'Фиолетовый'],
          correctIndex: 2,
        ),
        Question(
          text: 'Были ли у мужчины очки?',
          options: [
            'Нет',
            'Да, надеты на лицо',
            'Да, прикреплены к сумке',
            'Да, прикреплены к рубашке '
          ],
          correctIndex: 0,
        ),
        Question(
          text: 'Что было на фото?',
          options: ['Камера', 'Воздушный шар', 'Колокольчик', 'Коврик'],
          correctIndex: 0,
        ),
      ],
    ),
    ImageQuestion(
      imagePath: ImageConstant.imgImage_3,
      questions: [
        Question(
          text: 'Какая обивка у стульев?',
          options: ['Бамбук', 'Велюр', 'Кожа', 'Флок'],
          correctIndex: 0,
        ),
        Question(
          text: 'Какого цвета свечи на столе?',
          options: ['Черные', 'Оранжевые', 'Красные', 'Синие'],
          correctIndex: 2,
        ),
        Question(
          text: 'Был ли на картинке штопор?',
          options: [
            'Да, на столе справа',
            'Да, штопор ввинчен в пробку',
            'Да, на столе слева',
            'Нет'
          ],
          correctIndex: 2,
        ),
        Question(
          text: 'Где находилась гирлянда?',
          options: ['В цветах', 'На окне', 'На столе', 'Вдоль корней'],
          correctIndex: 0,
        ),
        Question(
          text: 'Какого предмета не было на картинке?',
          options: ['Бутылка вина', 'Бокалы', 'Букет', 'Скатерть'],
          correctIndex: 2,
        ),
        Question(
          text: 'Из какого материала изготовлен каркас стульев?',
          options: ['Дерево', 'Стекло', 'Пластик', 'Металл'],
          correctIndex: 3,
        ),
        Question(
          text: 'Какого цвета окна?',
          options: ['Синие', 'Красные', 'Зеленые', 'Белые'],
          correctIndex: 0,
        ),
        Question(
          text: 'Какой предмет был на картинке?',
          options: ['Шарик', 'Труба', 'Торшер', 'Шкаф'],
          correctIndex: 1,
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
                body: Stack(children: [
            Padding(
                padding: EdgeInsets.all(16.v),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 70.v),
                      Text(
                        "Картинка будет представлена на 20 секунд. Запомните как можно больше деталей!",
                        style: CustomTextStyles.regular24Text,
                        textAlign: TextAlign.center,
                      ),
                      Spacer(),
                      CustomElevatedButton(
                        text: "Начать раньше",
                        buttonTextStyle: CustomTextStyles.semiBold18TextWhite,
                        buttonStyle: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        onTap: () {
                          setState(() {
                            _isStart = false;
                          });
                        },
                      ),
                      SizedBox(height: 70.v),
                    ])),
            Center(
                child: Image.asset(
              imageQuestions[randomIndex].imagePath,
              width: 393.h,
            )),
          ])))
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
                                style: theme.textTheme.titleMedium,
                                textAlign: TextAlign.center,
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
                                          buttonStyle: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  appTheme.lightGray,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5))),
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
