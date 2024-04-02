import 'package:ave_memoria/pages/pause_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';
import 'utils.dart';
import '../../widgets/info_card.dart';

class CardsGame extends StatefulWidget {
  const CardsGame({super.key});

  @override
  _CardsGameState createState() => _CardsGameState();
}

class _CardsGameState extends State<CardsGame> {
  //setting text style
  TextStyle whiteText = TextStyle(color: Colors.white);
  bool hideTest = false;
  Game _game = Game();

  //game stats
  int tries = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    _game.initGame();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
        child: Scaffold(
            body: Container(
                width: mediaQueryData.size.width,
                height: mediaQueryData.size.height,
                child: SizedBox(
                    width: double.maxFinite,
                    child: Column(children: [
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.h),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 12.v,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 25.h,
                                ),
                                Spacer(),
                                Text("Легион памяти",
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
                                            pageBuilder: (_, __, ___) => const PauseMenu(),
                                            opaque: false,
                                        fullscreenDialog: true));
                                    // game.pauseEngine();
                                    // game.overlays.add(PauseMenu.id);
                                    // game.overlays.remove(PauseButton.id);
                                  },
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.v,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                info_card("Попытки", "$tries"),
                                info_card("Очки", "$score"),
                              ],
                            ),
                            Divider(height: 1, color: appTheme.gray),
                            SizedBox(
                                height: MediaQuery.of(context).size.width,
                                width: MediaQuery.of(context).size.width,
                                child: GridView.builder(
                                    itemCount: _game.gameImg!.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 16.0,
                                      mainAxisSpacing: 16.0,
                                    ),
                                    padding: EdgeInsets.all(16.0),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          print(_game.matchCheck);
                                          setState(() {
                                            //incrementing the clicks
                                            tries++;
                                            _game.gameImg![index] =
                                                _game.cards_list[index];
                                            _game.matchCheck.add({
                                              index: _game.cards_list[index]
                                            });
                                            print(_game.matchCheck.first);
                                          });
                                          if (_game.matchCheck.length == 2) {
                                            if (_game.matchCheck[0].values
                                                    .first ==
                                                _game.matchCheck[1].values
                                                    .first) {
                                              print("true");
                                              //incrementing the score
                                              score += 100;
                                              _game.matchCheck.clear();
                                            } else {
                                              print("false");

                                              Future.delayed(
                                                  Duration(milliseconds: 500),
                                                  () {
                                                print(_game.gameColors);
                                                setState(() {
                                                  _game.gameImg![_game
                                                          .matchCheck[0]
                                                          .keys
                                                          .first] =
                                                      _game.hiddenCardpath;
                                                  _game.gameImg![_game
                                                          .matchCheck[1]
                                                          .keys
                                                          .first] =
                                                      _game.hiddenCardpath;
                                                  _game.matchCheck.clear();
                                                });
                                              });
                                            }
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(16.0),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFFFB46A),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  _game.gameImg![index]),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      );
                                    }))
                          ],
                        ),
                      ))
                    ])))));
  }
}
