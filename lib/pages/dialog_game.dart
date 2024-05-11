import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

class DialogGame extends StatefulWidget {
  const DialogGame({super.key});

  @override
  State<DialogGame> createState() => _DialogGameState();
}

class _DialogGameState extends State<DialogGame> {
  final Map<int, List<String>> dialoguesMap = {
    1: [
      "Эв, ты же сам знаешь как братец Марц занят. Все эти дела апостола...",
      "Сила знания - твое оружие, сын мой. Вложи всю свою страсть и усилия в свое обучение, и никогда не забывай, что память - ключ к успеху",
      "Эван, ты здесь?",
      "Да, я здесь, Лава",
      "Что случилось?",
      "Я долго тебя искала. Раз мы здесь, не хочешь немного прогуляться  перед завтрашним уходом?",
      "Конечно, я только за, чтобы только не собираться",
      "Никогда не думал, что этот день наступит так быстро",
      "Да, время летит. «Богиня Мемория будет с тобой на экзамене», - так ведь все говорят? А мы будем болеть за тебя во время его прохождения.",
      "Конечно, Лава, я не сомневаюсь, но я не могу оставить тебя одну здесь! Дяди наверняка снова будут навязываться или выкинут что-то этакое",
      "Брат так долго не был дома. В последнем письме он говорил, что вернется домой к моему уходу",
      "Эв, ты же сам знаешь как братец Марц занят. Все эти дела апостола...",
      "А, давай сыграем в игру, чтобы   отвлечься. Если выиграешь, я тебе дам кое-что",
      "Хорошо, давай сыграем, только не плач потом",
      "Хе-хе, я уже не маленькая"
    ],
    2: [],
  };

  final Map<int, List<String>> characterNamesMap = {
    1: [
      "Лавиния",
      "Отец",
      "Лавиния",
      "Эван",
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
    2: [],
  };

  int currentLevel = 1;
  int currentDialogIndex = 0;

  final Map<int, List<String>> characterSprites = {
    1: [
      "assets/images/lava_evan_0.png",
      "assets/character2.png",
      "assets/character1.png",
      "assets/character2.png",
      "assets/character1.png",
      "assets/character2.png",
      "assets/character1.png",
      "assets/character2.png"
    ],
  };

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: GestureDetector(
          onTap: () {
            setState(() {
              currentDialogIndex++;
              if (currentDialogIndex >= dialoguesMap[currentLevel]!.length) {
                currentDialogIndex = 0;
              }
            });
          },
          child: Container(
            width: mediaQueryData.size.width,
            height: mediaQueryData.size.height,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/back_forest.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  child: Column(
                    children: [
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
                                  "Вы уверены, что хотите пропустить данный раздел?",
                              descTextStyle: CustomTextStyles.regular16Text,
                              btnCancelText: "Нет",
                              btnCancelOnPress: () {},
                              btnOkText: "Да",
                              btnOkOnPress: () =>
                                  GoRouter.of(context).push(AppRoutes.authreg),
                              buttonsTextStyle: CustomTextStyles.regular16White,
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
                                characterSprites[currentLevel]![
                                    currentDialogIndex],
                                fit: BoxFit.contain,
                              ),
                            ),
                            Expanded(
                                child: Align(
                                    alignment: FractionalOffset.bottomRight,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(height: 450.v),
                                        Container(
                                          width: 295.h,
                                          height: 50.v,
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 0.9),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Column(
                                            children: [
                                              Spacer(),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16.v),
                                                  child: Text(
                                                    // dialoguesMap[currentLevel]![
                                                    //     currentDialogIndex],
                                                    "Я знаю, Лава. В конце концов, он старается и ради нас тоже.",
                                                    maxLines: 2,
                                                  )),
                                              Spacer(),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 295.h,
                                          height: 50.v,
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 0.9),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Column(
                                            children: [
                                              Spacer(),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16.v),
                                                  child: Text(
                                                    // dialoguesMap[currentLevel]![
                                                    //     currentDialogIndex],
                                                    "Марц всегда занят! Однако мы тоже нуждаемся в нем…",
                                                    maxLines: 2,
                                                  )),
                                              Spacer(),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 200.v,
                                        )
                                      ],
                                    ))),
                            Expanded(
                              child: Align(
                                alignment: FractionalOffset.bottomCenter,
                                child: Container(
                                  width: 393.h,
                                  height: 200.v,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 0.9),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 8.v),
                                      Text(
                                        characterNamesMap[currentLevel]![
                                            currentDialogIndex],
                                        style: CustomTextStyles.bold16Text,
                                      ),
                                      SizedBox(height: 8.v),
                                      Divider(height: 1, color: appTheme.gray),
                                      Spacer(),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.h),
                                          child: Text(
                                            dialoguesMap[currentLevel]![
                                                currentDialogIndex],
                                            maxLines: 6,
                                            textAlign: TextAlign.center,
                                            style:
                                                CustomTextStyles.regular14Text,
                                          )),
                                      Spacer(),
                                      Row(children: [
                                        Spacer(),
                                        Icon(
                                          Icons.subdirectory_arrow_right,
                                          size: 16.v,
                                          color: theme.colorScheme.onPrimary
                                        ),
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
}
