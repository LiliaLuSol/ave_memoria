import 'package:ave_memoria/other/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PauseMenu extends StatelessWidget {
  static const String id = 'PauseMenu';

  // final CarsGame game;

  const PauseMenu({
    Key? key,
    //  required this.game
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.black.withOpacity(0.2),
            body: Center(
                child: Container(
                    width: 353.h,
                    height: 478.v,
                    decoration: AppDecoration.outlineGray.copyWith(
                        borderRadius: BorderRadiusStyle.circleBorder15),
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.h),
                        child: Column(children: [
                          SizedBox(height: 10.v),
                          Row(children: [
                            IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.volumeHigh,
                                size: 25.h,
                                color: theme.colorScheme.primary,
                              ),
                              onPressed: () {},
                            ),
                            Spacer(),
                            IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.circleXmark,
                                size: 25.h,
                                color: theme.colorScheme.primary,
                              ),
                              onPressed: () {
                                null;
                              },
                            )
                          ]),
                          SizedBox(height: 15.v),
                          Text("Пауза",
                              style: CustomTextStyles.extraBold32Text),
                          SizedBox(height: 46.v),
                          CustomElevatedButton(
                            text: "Продолжить",
                            buttonTextStyle:
                                CustomTextStyles.semiBold18TextWhite,
                            buttonStyle: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                          SizedBox(height: 24.v),
                          CustomElevatedButton(
                            text: "Переиграть",
                            buttonTextStyle:
                                CustomTextStyles.semiBold18TextWhite,
                            buttonStyle: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                          SizedBox(height: 24.v),
                          CustomElevatedButton(
                            text: "Правила",
                            buttonTextStyle:
                                CustomTextStyles.semiBold18TextWhite,
                            buttonStyle: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                          SizedBox(height: 24.v),
                          CustomElevatedButton(
                            text: "Выход",
                            buttonTextStyle:
                                CustomTextStyles.semiBold18TextWhite,
                            buttonStyle: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          )
                        ]))))));
    // Center(
    // child: Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     // Pause menu title.
    //     const Padding(
    //       padding: EdgeInsets.symmetric(vertical: 50.0),
    //       child: Text(
    //         'Paused',
    //         style: TextStyle(
    //           fontSize: 50.0,
    //           color: Colors.black,
    //           shadows: [
    //             Shadow(
    //               blurRadius: 20.0,
    //               color: Colors.white,
    //               offset: Offset(0, 0),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //
    // // Resume button.
    // SizedBox(
    //   width: MediaQuery.of(context).size.width / 3,
    //   child: ElevatedButton(
    //     onPressed: () {
    //       // game.resumeEngine();
    //       // game.overlays.remove(PauseMenu.id);
    //       // game.overlays.add(PauseButton.id);
    //     },
    //     child: const Text('Resume'),
    //   ),
    // ),
    //
    // // Restart button.
    // SizedBox(
    //   width: MediaQuery.of(context).size.width / 3,
    //   child: ElevatedButton(
    //     onPressed: () {
    //       // game.overlays.remove(PauseMenu.id);
    //       // game.overlays.add(PauseButton.id);
    //       // game.reset();
    //       // game.resumeEngine();
    //     },
    //     child: const Text('Restart'),
    //   ),
    // ),
    //
    // // Exit button.
    // SizedBox(
    //   width: MediaQuery.of(context).size.width / 3,
    //   child: ElevatedButton(
    //     onPressed: () {
    //       // game.overlays.remove(PauseMenu.id);
    //       // game.reset();
    //       // game.resumeEngine();
    //
    //       // Navigator.of(context).pushReplacement(
    //       //   MaterialPageRoute(
    //       //     builder: (context) => const MainMenu(),
    //       //   ),
    //       // );
    //     },
    //     child: const Text('Exit'),
    //   ),
    // ),
    //     ],
    //   ),
    // );
  }
}
