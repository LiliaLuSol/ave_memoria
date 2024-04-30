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
      "Персонаж 1 - Реплика 1",
      "Персонаж 2 - Реплика 1",
      "Персонаж 1 - Реплика 2",
      "Персонаж 1 - Реплика 3",
      "Персонаж 2 - Реплика 2",
      "Персонаж 1 - Реплика 4",
      "Персонаж 1 - Реплика 5",
      "Персонаж 2 - Реплика 3",
    ],
    2: [],
  };

  final Map<int, List<String>> characterNamesMap = {
    1: [
      "Персонаж 1",
      "Персонаж 2",
      "Персонаж 1",
      "Персонаж 1",
      "Персонаж 2",
      "Персонаж 1",
      "Персонаж 1",
      "Персонаж 2",
    ],
    2: [],
  };

  int currentLevel = 1;
  int currentDialogIndex = 0;

  final Map<int, List<String>> characterSprites = {
    1: [
      "assets/character1.png",
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
                    'assets/background_image.jpg',
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
                            child: Text(
                              "Пропустить",
                              style: CustomTextStyles.semiBold18TextGray,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            // Positioned(
                            //   bottom: 0,
                            //   left: 0,
                            //   right: 0,
                            //   child: Container(
                            //     width: 393.h,
                            //     height: 700.v,
                            //     color: Colors.purple,
                            //   ),
                            // ),
                            Positioned.fill(
                              child: Image.asset(
                                characterSprites[currentLevel]![
                                    currentDialogIndex],
                                fit: BoxFit.contain,
                              ),
                            ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 500.v),
                                  Container(
                                    width: 353.h,
                                    height: 150.v,
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
                                        ),
                                        SizedBox(height: 8.v),
                                        Divider(
                                            height: 1, color: appTheme.gray),
                                        Spacer(),
                                        Text(
                                          dialoguesMap[currentLevel]![
                                              currentDialogIndex],
                                          maxLines: 5,
                                        ),
                                        Spacer(),
                                        Row(
                                          children: [
                                            Spacer(),
                                            Text('далее'),
                                            SizedBox(width: 16.h)
                                          ],
                                        ),
                                        SizedBox(height: 8.v),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
