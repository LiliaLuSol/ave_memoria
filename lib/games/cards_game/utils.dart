import 'package:flutter/material.dart';
import '../../other/app_export.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';

// class CardGame {
//   final Color hiddenCard = appTheme.white;
//   List<Color>? gameColors;
//   List<String>? gameImg;
//   final String hiddenCardpath = ImageConstant.imgHidden;
//   List<String> cards_list = [
//     ImageConstant.imgCards_1_jug,
//     ImageConstant.imgCards_2_jug,
//     ImageConstant.imgCards_3_jug,
//     ImageConstant.imgCards_4_jug,
//     ImageConstant.imgCards_5_jug,
//     ImageConstant.imgCards_6_jug,
//     ImageConstant.imgCards_1_jug,
//     ImageConstant.imgCards_2_jug,
//     ImageConstant.imgCards_3_jug,
//     ImageConstant.imgCards_4_jug,
//     ImageConstant.imgCards_5_jug,
//     ImageConstant.imgCards_6_jug,
//   ];
//   final int cardCount = 12;
//   List<Map<int, String>> matchCheck = [];
//
//   void initGame() {
//     gameColors = List.generate(cardCount, (index) => hiddenCard);
//     gameImg = List.generate(cardCount, (index) => hiddenCardpath);
//   }
// }
List<String> imageSource() {
  return [
    ImageConstant.imgCards_1_jug,
    ImageConstant.imgCards_2_jug,
    ImageConstant.imgCards_3_jug,
    ImageConstant.imgCards_4_jug,
    ImageConstant.imgCards_5_jug,
    ImageConstant.imgCards_6_jug,
    ImageConstant.imgCards_1_jug,
    ImageConstant.imgCards_2_jug,
    ImageConstant.imgCards_3_jug,
    ImageConstant.imgCards_4_jug,
    ImageConstant.imgCards_5_jug,
    ImageConstant.imgCards_6_jug,
  ];
}

List createShuffledListFromImageSource() {
  List shuffledImages = [];
  List sourceArray = imageSource();
  for (var element in sourceArray) {
    shuffledImages.add(element);
  }
  shuffledImages.shuffle();
  return shuffledImages;
}

List<bool> getInitialItemStateList() {
  List<bool> initialItem = <bool>[];
  for (int i = 0; i < 12; i++) {
    initialItem.add(true);
  }
  return initialItem;
}

List<GlobalKey<FlipCardState>> createFlipCardStateKeysList() {
  List<GlobalKey<FlipCardState>> cardStateKeys = <GlobalKey<FlipCardState>>[];
  for (int i = 0; i < 12; i++) {
    cardStateKeys.add(GlobalKey<FlipCardState>());
  }
  return cardStateKeys;
}
