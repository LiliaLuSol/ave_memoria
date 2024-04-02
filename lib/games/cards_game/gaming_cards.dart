import 'package:ave_memoria/pages/pause_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';
import 'package:flutter/widgets.dart';
import 'utils.dart';
import '../../widgets/info_card.dart';

class CardsGame extends StatefulWidget {
  const CardsGame({super.key});

  @override
  _CardsGameState createState() => _CardsGameState();
}

class _CardsGameState extends State<CardsGame> {
  bool hideTest = false;
  Game _game = Game();

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
      child: Column(
        children: [
          Container(
              color: theme.colorScheme.onPrimaryContainer,
              child: Column(
                  children: [
                SizedBox(
                  height: 22.v,
                ),
                Row(
                  children: [
                    SizedBox(width: 49.h),
                    Spacer(),
                    Text("Легион памяти",
                        style: CustomTextStyles.regular24Text),
                    Spacer(),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.circlePause,
                          size: 25.h, color: theme.colorScheme.primary),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_, __, ___) => const PauseMenu(),
                                opaque: false,
                                fullscreenDialog: true));
                      },
                    ),SizedBox(width: 16.h),
                  ],
                ),
                SizedBox(width: 22.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    info_card("Попытки", "$tries"),
                    info_card("Очки", "$score"),
                  ],
                ),
                SizedBox(width: 22.v),
                Divider(height: 1, color: appTheme.gray)
              ])),
          Container(
              alignment: Alignment.center,
              height: 658.v,
              child: GridView.builder(
                  itemCount: _game.gameImg!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16.h,
                    mainAxisSpacing: 16.h,
                  ),
                  padding: EdgeInsets.all(16.h),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print(_game.matchCheck);
                        setState(() {
                          tries++;
                          _game.gameImg![index] = _game.cards_list[index];
                          _game.matchCheck
                              .add({index: _game.cards_list[index]});
                          print(_game.matchCheck.first);
                        });
                        if (_game.matchCheck.length == 2) {
                          if (_game.matchCheck[0].values.first ==
                              _game.matchCheck[1].values.first) {
                            score += 100;
                            _game.matchCheck.clear();
                          } else {
                            Future.delayed(Duration(milliseconds: 500), () {
                              print(_game.gameColors);
                              setState(() {
                                _game.gameImg![_game.matchCheck[0].keys.first] =
                                    _game.hiddenCardpath;
                                _game.gameImg![_game.matchCheck[1].keys.first] =
                                    _game.hiddenCardpath;
                                _game.matchCheck.clear();
                              });
                            });
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF83B0C8),
                          borderRadius: BorderRadius.circular(8.h),
                        ),
                        padding: EdgeInsets.all(5.h),
                        child: Image.asset(
                          _game.gameImg![index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  })),
        ],
      ),
    )));
  }
}
