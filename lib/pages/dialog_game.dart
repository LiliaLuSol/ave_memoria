import 'package:ave_memoria/games/cards_game/gaming_cards.dart';
import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

import '../games/sequence_game/gaming_sequence.dart';
import 'game_rules.dart';

class DialogGame extends StatefulWidget {
  final bool isStart;
  final bool isEndSuc;
  final bool isEndFail;

  const DialogGame(
      {super.key,
      required this.isStart,
      required this.isEndSuc,
      required this.isEndFail});

  @override
  State<DialogGame> createState() => _DialogGameState();
}

class _DialogGameState extends State<DialogGame> {
  GlobalData globalData = GlobalData();

  final Map<int, List<String>> dialoguesStartMap = {
    11: [
      "Сила знания - твое оружие, сын мой. Вложи всю свою страсть и усилия в свое обучение, и никогда не забывай, что память - ключ к успеху.",
      "Да прибудет с тобой богиня Мемория!",
      "Эван, ты здесь?",
      "Да, я здесь, Лава. Что-то случилось? Ты что так запыхалась?",
      "Я долго тебя искала. Раз мы здесь, не хочешь немного прогуляться  перед завтрашним уходом?",
      "Конечно, я только " "за" "! (Что угодно, если это не сборы и не уборка)",
      "Никогда не думал, что этот день наступит так быстро",
      "Да, время летит. «Богиня Мемория будет с тобой на экзамене», - так ведь все говорят? А мы будем болеть за тебя во время его прохождения.",
      "Конечно, Лава, я не сомневаюсь, но я не могу оставить тебя одну здесь! А если что-то снова произойдет?",
      "Брат так долго не был дома. В последнем письме он говорил, что вернется домой к моему уходу",
      "2choose Эв, ты же сам знаешь как братец Марц занят. Все эти дела апостола...",
      "А, давай сыграем в игру, чтобы отвлечься. Если выиграешь, я тебе дам кое-что",
      "Хорошо, давай сыграем, только не плач потом",
      "Хе-хе, я уже не маленькая"
    ],
    12: [
      "Так, вещи все взял? Ничего не забыл? Деньги взял?",
      "Все взял, не переживай, не маленький",
      "Сказал тот, кто никак не хотел собираться, пока пенок не дали",
      "...",
      "Ну, я пошел. Если задержусь еще, то придется ночевать на улице",
      "Да прибудет с тобой Богиня, ни пуха ни пера, безопасной дороги!",
      "Я же не на охоту иду, а на экзамен.",
      "...",
      "Уверена, что справишься одна? Я могу и в следующем году сдать...",
      "Эван Аквиллия, иди уже, а то и правда, до вечера не уйдешь",
      "Я ушел, ушел уже",
      "Вот теперь и Эван покинул дом. Хоть какое-то время в доме будет порядок",
      "Через некоторе время...",
      "Надо было нормально собираться. Взял с собой всего ничего, зато на легке, да Эван? Но это и правда все, что у меня есть",
      "Эй, парень, ты случайно не направляешься на экзамен в храм богини Мемории? Значит ты довольно смышленный?",
      "Допустим. А что?",
      "Ха, у тебя даже не хватит денег и времени, чтобы дойти до следующего города к закату. Здесь полно бандитов, которые только и ждут таких, как ты.",
      "Вам покуда знать, сколько у меня денег? Я справлюсь. Спасибо за предупреждение.",
      "Ну, не будь таким самоуверенным, может тогда поможешь мне? Ничего сложного.",
      "Если задумка преуспеет, я дам тебе полезный совет, если нет — ты ничего не потеряешь.",
      "Ничего, кроме времени. Но и оно не на моей стороне... Что за помощь нужна?",
      "Видишь ли, парень, я гладиатор. И сегодня у нас довольно важдая тренировка, но у меня беды с запоминанием движений. Я хорош в...",
      "То есть, ты хочешь, чтобы я тебе движения подсказывал? А если поймают?",
      "А ты не попадись, и проблем не будет, и деньжат сможешь подзаработать. Одни плюсы.",
      "Ладно, помогу. Но ты обязан сдержать свое слово. Надеюсь оно того стоит.",
      "Не сомневайся, совет тебе здорово поможет. Пойдем."
    ],
  };

  final Map<int, List<String>> chooseMap = {
    11: [
      "Я знаю, Лава. В конце концов, он старается и ради нас тоже.",
      "Марц всегда занят! Однако мы тоже нуждаемся в нем..."
    ],
    12: [],
  };

  final Map<int, List<String>> dialoguesEndSucMap = {
    11: [
      "Вау! Ты как всегда на высоте!",
      "Лава, ты переувеличиваешь. Лучше вручай мой приз",
      "Да, да. Держи приз. Но обещай что хоть прочтешь его",
      "Мм? Ладно, обещаю",
      "Тогда держи",
      "Вау! Письмо от старшего брата, пришедшее вместо брата!",
      "Ты пообещал прочесть его",
      "Прочту. О, внутри что-то есть!",
      "Это... карта доступа в библиотеку Мемориес? Они же довольно дорогие и без специального разрешния их не получить",
      "Видимо брат так извиняется за то, что не сам пришел",
      "Полезные извинения! Карта тебе обязательно поможет еще!",
      "Я думал, ты защищаешь Марцеллиана",
      "Еще чего, я вообще-то не меньше твоего его ждала! К слову, Эв, у тебя хоть денег хватает на дорогу?",
      "...",
      "Эван Аквиллия!!! Я не пущу тебя никуда, пока у тебя не будет хотя бы 50 мемо!"
    ],
    12: [
      "Вау, да ты даешь, пацан!",
      "Держи свое слово и говори",
      "Во-первых, спасибо за помощь, во-вторых, как и обещал, слушай, впереди на дороге есть тайный проход, о котором знают немногие.",
      "Он безопасен и сократит твой путь. Удачи на экзамене, парень. Может, у тебя действительно есть шанс.",
      "Отлично! Теперь я не буду спать под открытым небом",
      "Тебя только это беспокоило? Ладно, дам еще совет. Гладиаторские тренировки  и арены расположены повсеместно на всем твоем пути",
      "И везде найдутся такие гладиаторы, как я, которым нужна помощь таких, как ты. Так что пользуйся. Удачи",
      "Спасибо, незнакомец, и тебе удачи"
    ],
  };

  final Map<int, List<String>> characterEndSucMap = {
    11: [
      "Лавиния",
      "Эван",
      "Лавиния",
      "Эван",
      "Лавиния",
      "Эван",
      "Лавиния",
      "Эван",
      "Лавиния",
      "Эван",
      "Лавиния",
      "Эван",
      "Лавиния",
      "Эван",
      "Лавиния",
    ],
    12: [
      "Незнакомец",
      "Эван",
      "Незнакомец",
      "Незнакомец",
      "Эван",
      "Незнакомец",
      "Незнакомец",
      "Эван"
    ],
  };

  final Map<int, List<String>> dialoguesEndFailMap = {
    11: ["Ну... бывает. Еще разок?", "...", "Давай"],
    12: [
      "Черт, плохо вышло. Ты точно участник экзамена?",
      "Точно, иди и проси еще один шанс"
    ],
  };

  final Map<int, List<String>> characterEndFailMap = {
    11: [
      "Лавиния",
      "Эван",
      "Эван",
    ],
    12: [
      "Незнакомец",
      "Эван",
    ],
  };

  final Map<int, List<String>> backEndMap = {
    11: [
      'assets/images/back_forest.jpg',
      'assets/images/back_forest.jpg',
      'assets/images/back_forest.jpg',
      'assets/images/back_forest.jpg',
      'assets/images/back_forest.jpg',
      'assets/images/back_forest.jpg',
      'assets/images/back_forest.jpg',
      'assets/images/back_forest.jpg',
      'assets/images/back_forest.jpg',
      'assets/images/back_forest.jpg',
      'assets/images/back_forest.jpg',
      'assets/images/back_forest.jpg',
      'assets/images/back_forest.jpg',
      'assets/images/back_forest.jpg',
      'assets/images/back_forest.jpg'
    ],
    12: [
      'assets/images/back_forest1.jpg',
      'assets/images/back_forest1.jpg',
      'assets/images/back_forest1.jpg',
      'assets/images/back_forest1.jpg',
      'assets/images/back_forest1.jpg',
      'assets/images/back_forest1.jpg',
      'assets/images/back_forest1.jpg',
      'assets/images/back_forest1.jpg',
    ],
  };

  final Map<int, List<String>> backMap = {
    11: [
      'assets/images/back_sundown.jpg',
      'assets/images/back_sundown.jpg',
      'assets/images/back_forest.jpg',
      'assets/images/back_forest.jpg',
      'assets/images/back_forest.jpg',
      'assets/images/back_forest.jpg',
      'assets/images/back_forest.jpg',
      'assets/images/back_forest.jpg',
      'assets/images/back_forest.jpg',
      'assets/images/back_forest.jpg',
      'assets/images/back_forest.jpg',
      'assets/images/back_forest.jpg',
      'assets/images/back_forest.jpg',
      'assets/images/back_forest.jpg'
    ],
    12: [
      'assets/images/back_road.jpg',
      'assets/images/back_road.jpg',
      'assets/images/back_road.jpg',
      'assets/images/back_road.jpg',
      'assets/images/back_road.jpg',
      'assets/images/back_road.jpg',
      'assets/images/back_road.jpg',
      'assets/images/back_road.jpg',
      'assets/images/back_road.jpg',
      'assets/images/back_road.jpg',
      'assets/images/back_road.jpg',
      'assets/images/back_road.jpg',
      'assets/images/back_forest1.jpg',
      'assets/images/back_forest1.jpg',
      'assets/images/back_forest1.jpg',
      'assets/images/back_forest1.jpg',
      'assets/images/back_forest1.jpg',
      'assets/images/back_forest1.jpg',
      'assets/images/back_forest1.jpg',
      'assets/images/back_forest1.jpg',
      'assets/images/back_forest1.jpg',
      'assets/images/back_forest1.jpg',
      'assets/images/back_forest1.jpg',
      'assets/images/back_forest1.jpg',
      'assets/images/back_forest1.jpg',
      'assets/images/back_forest1.jpg',
    ],
  };

  final Map<int, List<String>> characterNamesMap = {
    11: [
      "Отец",
      "Отец",
      "Лавиния",
      "Эван",
      "Лавиния",
      "Эван",
      "Эван",
      "Лавиния",
      "Эван",
      "Эван",
      "Лавиния",
      "Лавиния",
      "Эван",
      "Лавиния",
    ],
    12: [
      "Лавиния",
      "Эван",
      "Лавиния",
      "Эван",
      "Эван",
      "Лавиния",
      "Эван",
      "Эван",
      "Эван",
      "Лавиния",
      "Эван",
      "Лавиния",
      "<...>",
      "Эван",
      "Незнакомец",
      "Эван",
      "Незнакомец",
      "Эван",
      "Незнакомец",
      "Незнакомец",
      "Эван",
      "Незнакомец",
      "Эван",
      "Незнакомец",
      "Эван",
      "Незнакомец",
    ],
  };

  final Map<int, List<String>> characterSprites = {
    11: [
      "assets/images/zero.png",
      "assets/images/zero.png",
      "assets/images/lava_0.png",
      "assets/images/lava_evan_1.png",
      "assets/images/lava_evan_2.png",
      "assets/images/lava_evan_2.png",
      "assets/images/lava_evan_0.png",
      "assets/images/lava_evan_3.png",
      "assets/images/lava_evan_0.png",
      "assets/images/lava_evan_0.png",
      "assets/images/lava_evan_0.png",
      "assets/images/lava_evan_3.png",
      "assets/images/lava_evan_2.png",
      "assets/images/lava_evan_2.png",
    ],
    12: [
      "assets/images/lava_evan_0.png",
      "assets/images/lava_evan_0.png",
      "assets/images/lava_evan_3.png",
      "assets/images/lava_evan_2.png",
      "assets/images/lava_evan_2.png",
      "assets/images/lava_evan_2.png",
      "assets/images/lava_evan_2.png",
      "assets/images/lava_evan_3.png",
      "assets/images/lava_evan_3.png",
      "assets/images/lava_evan_0.png",
      "assets/images/lava_evan_3.png",
      "assets/images/lava_0.png",
      "assets/images/zero.png",
      "assets/images/evan_0.png",
      "assets/images/noname_evan_0.png",
      "assets/images/noname_evan_0.png",
      "assets/images/noname_evan_0.png",
      "assets/images/noname_evan_1.png",
      "assets/images/noname_evan_0.png",
      "assets/images/noname_evan_0.png",
      "assets/images/noname_evan_0.png",
      "assets/images/noname_evan_0.png",
      "assets/images/noname_evan_0.png",
      "assets/images/noname_evan_0.png",
      "assets/images/noname_evan_0.png",
      "assets/images/noname_evan_0.png",
    ]
  };

  final Map<int, List<String>> characterEndSucSprites = {
    11: [
      "assets/images/lava_evan_2.png",
      "assets/images/lava_evan_2.png",
      "assets/images/lava_evan_2.png",
      "assets/images/lava_evan_2.png",
      "assets/images/lava_evan_2.png",
      "assets/images/lava_evan_3.png",
      "assets/images/lava_evan_0.png",
      "assets/images/lava_evan_0.png",
      "assets/images/lava_evan_0.png",
      "assets/images/lava_evan_0.png",
      "assets/images/lava_evan_3.png",
      "assets/images/lava_evan_3.png",
      "assets/images/lava_evan_2.png",
      "assets/images/lava_evan_0.png",
      "assets/images/lava_evan_0.png",
    ],
    12: [
      "assets/images/noname_evan_1.png",
      "assets/images/noname_evan_0.png",
      "assets/images/noname_evan_0.png",
      "assets/images/noname_evan_0.png",
      "assets/images/noname_evan_0.png",
      "assets/images/noname_evan_1.png",
      "assets/images/noname_evan_1.png",
      "assets/images/noname_evan_1.png",
    ]
  };

  final Map<int, List<String>> characterEndFailSprites = {
    11: [
      "assets/images/lava_evan_0.png",
      "assets/images/lava_evan_0.png",
      "assets/images/lava_evan_0.png",
    ],
    12: [
      "assets/images/noname_evan_0.png",
      "assets/images/noname_evan_0.png",
    ]
  };

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
                        scoreStory: globalData.gameData['score'],
                        currentLevel: currentLevel)),
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
                          scoreStory: globalData.gameData['score'],
                          currentLevel: currentLevel),
                    ),
                opaque: false,
                fullscreenDialog: true));
        break;
    }
  }

  late int currentLevel;
  late int currentDialogIndex;
  late bool canCont;

  @override
  void initState() {
    super.initState();
    currentLevel = (globalData.gameData['number'] * 10).round();
    currentDialogIndex = 0;
    canCont = true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    preloadAllImages();
  }

  void preloadAllImages() {
    if (widget.isStart) {
      characterSprites.forEach((level, imagePaths) {
        preloadImages(context, imagePaths);
      });
      backMap.forEach((level, imagePaths) {
        preloadImages(context, imagePaths);
      });
    } else {
      characterEndSucSprites.forEach((level, imagePaths) {
        preloadImages(context, imagePaths);
      });
      characterEndFailSprites.forEach((level, imagePaths) {
        preloadImages(context, imagePaths);
      });
      backEndMap.forEach((level, imagePaths) {
        preloadImages(context, imagePaths);
      });
    }
  }

  void preloadImages(BuildContext context, List<String> imagePaths) {
    for (String path in imagePaths) {
      precacheImage(AssetImage(path), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: GestureDetector(
          onTap: () {
            if (canCont) {
              setState(() {
                currentDialogIndex++;
                if (currentDialogIndex >=
                    dialoguesStartMap[currentLevel]!.length) {
                  currentDialogIndex = 0;
                  if (widget.isStart) {
                    getGamePath(currentLevel);
                  }
                  if (widget.isEndSuc || widget.isEndFail) {
                    GoRouter.of(context).push(AppRoutes.homepage);
                  }
                }
                if (dialoguesStartMap[currentLevel]![currentDialogIndex]
                        .contains('2choose ') &&
                    widget.isStart) {
                  canCont = false;
                }
              });
            }
          },
          child: SizedBox(
            width: mediaQueryData.size.width,
            height: mediaQueryData.size.height,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    widget.isStart
                        ? backMap[currentLevel]![currentDialogIndex]
                        : backEndMap[currentLevel]![currentDialogIndex],
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  child: Column(
                    children: [
                      if (globalData.gameData['is_replay'])
                        Row(
                          children: [
                            SizedBox(width: 20.h),
                            TextButton(
                              onPressed: () => AwesomeDialog(
                                context: context,
                                dialogType: DialogType.info,
                                animType: AnimType.topSlide,
                                title: "Пропустить",
                                titleTextStyle: CustomTextStyles.semiBold32Text,
                                desc:
                                    "Вы уверены, что хотите пропустить данный диалог?",
                                descTextStyle: CustomTextStyles.regular16Text,
                                btnCancelText: "Нет",
                                btnCancelOnPress: () {},
                                btnOkText: "Да",
                                btnOkOnPress: () {
                                  setState(() {
                                    if (widget.isStart) {
                                      getGamePath(currentLevel);
                                    }
                                    if (widget.isEndSuc || widget.isEndFail) {
                                      GoRouter.of(context)
                                          .push(AppRoutes.homepage);
                                    }
                                  });
                                },
                                buttonsTextStyle:
                                    CustomTextStyles.regular16White,
                              ).show(),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return Colors.grey.withOpacity(0.5);
                                  },
                                ),
                              ),
                              child: Text(
                                "Пропустить",
                                style: CustomTextStyles.semiBold18TextWhite,
                              ),
                            ),
                          ],
                        ),
                      Expanded(
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.asset(
                                widget.isStart
                                    ? characterSprites[currentLevel]![
                                        currentDialogIndex]
                                    : widget.isEndSuc
                                        ? characterEndSucSprites[currentLevel]![
                                            currentDialogIndex]
                                        : characterEndFailSprites[
                                            currentLevel]![currentDialogIndex],
                                fit: BoxFit.contain,
                              ),
                            ),
                            if (widget.isStart &&
                                dialoguesStartMap[currentLevel]![
                                        currentDialogIndex]
                                    .contains('2choose '))
                              Expanded(
                                  child: Align(
                                      alignment: FractionalOffset.bottomRight,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(height: 450.v),
                                          if (!globalData.gameData['is_replay'])
                                            SizedBox(height: 20.v),
                                          chooseButton(
                                            context,
                                            chooseMap[currentLevel]![0],
                                            () {
                                              setState(() {
                                                canCont = true;
                                                currentDialogIndex++;
                                                if (currentDialogIndex >=
                                                    dialoguesStartMap[
                                                            currentLevel]!
                                                        .length) {
                                                  currentDialogIndex = 0;
                                                }
                                              });
                                            },
                                          ),
                                          chooseButton(
                                            context,
                                            chooseMap[currentLevel]![1],
                                            () {
                                              setState(() {
                                                canCont = true;
                                                currentDialogIndex++;
                                                if (currentDialogIndex >=
                                                    dialoguesStartMap[
                                                            currentLevel]!
                                                        .length) {
                                                  currentDialogIndex = 0;
                                                }
                                              });
                                            },
                                          ),
                                          SizedBox(height: 200.v)
                                        ],
                                      ))),
                            Expanded(
                              child: Align(
                                alignment: FractionalOffset.bottomCenter,
                                child: Container(
                                  width: 393.h,
                                  height: 200.v,
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                        255, 255, 255, 0.9),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 8.v),
                                      Text(
                                        widget.isStart
                                            ? characterNamesMap[currentLevel]![
                                                currentDialogIndex]
                                            : widget.isEndSuc
                                                ? characterEndSucMap[
                                                        currentLevel]![
                                                    currentDialogIndex]
                                                : characterEndFailMap[
                                                        currentLevel]![
                                                    currentDialogIndex],
                                        style: CustomTextStyles.bold16Text,
                                      ),
                                      SizedBox(height: 8.v),
                                      Divider(height: 1, color: appTheme.gray),
                                      const Spacer(),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.h),
                                          child: Text(
                                            widget.isStart
                                                ? dialoguesStartMap[
                                                                currentLevel]![
                                                            currentDialogIndex]
                                                        .contains('2choose ')
                                                    ? dialoguesStartMap[
                                                                currentLevel]![
                                                            currentDialogIndex]
                                                        .substring(8)
                                                    : dialoguesStartMap[
                                                            currentLevel]![
                                                        currentDialogIndex]
                                                : widget.isEndSuc
                                                    ? dialoguesEndSucMap[
                                                            currentLevel]![
                                                        currentDialogIndex]
                                                    : dialoguesEndFailMap[
                                                            currentLevel]![
                                                        currentDialogIndex],
                                            maxLines: 6,
                                            textAlign: TextAlign.center,
                                            style:
                                                CustomTextStyles.regular14Text,
                                          )),
                                      const Spacer(),
                                      Row(children: [
                                        const Spacer(),
                                        Icon(Icons.subdirectory_arrow_right,
                                            size: 16.v,
                                            color: theme.colorScheme.onPrimary),
                                        SizedBox(width: 16.h)
                                      ]),
                                      SizedBox(height: 8.v),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.v),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget chooseButton(BuildContext context, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 295.h,
        height: 50.v,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0.9),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.v),
              child: Text(
                text,
                maxLines: 2,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
