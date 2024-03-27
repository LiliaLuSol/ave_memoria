import 'package:flutter/material.dart';
import '../../other/app_export.dart';

class Game {
  final Color hiddenCard = appTheme.white;
  List<Color>? gameColors;
  List<String>? gameImg;
  final String hiddenCardpath = ImageConstant.imgHidden;
  List<String> cards_list = [
    ImageConstant.imgCards_1_jug,
    ImageConstant.imgCards_2_jug,
    ImageConstant.imgCards_3_jug,
    ImageConstant.imgCards_4_jug,
    ImageConstant.imgCards_5_jug,
    ImageConstant.imgCards_1_jug,
    ImageConstant.imgCards_2_jug,
    ImageConstant.imgCards_3_jug,
    ImageConstant.imgCards_4_jug,
   ImageConstant.imgCards_5_jug,
  ];
  final int cardCount = 10;
  List<Map<int, String>> matchCheck = [];
  
  void initGame() {
    gameColors = List.generate(cardCount, (index) => hiddenCard);
    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
  }
}