import 'dart:io';
import 'package:ave_memoria/other/app_export.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class GlobalData {
  static final GlobalData _instance = GlobalData._internal();

  factory GlobalData() {
    return _instance;
  }

  GlobalData._internal();

  String emailAnon = 'anounymous@gmail.com';
  int money = 0;
  int mon = 0;
  int tue = 0;
  int wen = 0;
  int thu = 0;
  int fri = 0;
  int sat = 0;
  int sun = 0;

  void updateMoney(int newData) {
    money = newData;
  }

  void updateMon(int newData) {
    mon = newData;
  }
  void updateTue(int newData) {
    tue = newData;
  }
  void updateWen(int newData) {
    wen = newData;
  }
  void updateThu(int newData) {
    thu = newData;
  }
  void updateFri(int newData) {
    fri = newData;
  }
  void updateSat(int newData) {
    sat = newData;
  }
  void updateSun(int newData) {
    sun = newData;
  }

  String nameGame1 = 'Карточная игра\n'
      '"Река памяти"';
  String nameGame1_ = 'Река памяти';
  String game1Rule1 =
      "Игровое поле состоит из карт, за каждой из которых скрыта картинка. Картинки ― парные, т.е. на игровом поле есть две карты, на которых находятся одинаковые картинки";
  String game1Rule2 =
      "В начале игры на несколько секунд показывают все картинки. Ваша задача запомнить как можно больше карт";
  String game1Rule3 =
      "А затем все карты перевернут рубашкой вверх. Надо с меньшим числом попыток найти и перевернуть парные карты, если картинки различаются, тогда они снова повернутся";

  String nameGame2 = 'Гладиаторская тренировка памяти';
  String nameGame2_ = "    Гладиаторская\nтренировка памяти";
  String game2Rule1 =
      "В каждом раунде, гладиатор-учитель показывает последовательность движений";
  String game2Rule2 =
      "Ваша задача запомнить и воспроизвести эту последовательность, не допуская ошибок";
  String game2Rule3 =
      "С каждым раундом последовательность становится все длинее, а за ошибку Вы теярете по одной жизни";

  String nameGame3 = 'Взгляд в будующее';
  String game3Rule1 =
      "В начале игры Вам показывается картинка на 20 секунд, Вы должны запомнить как можно больше деталей";
  String game3Rule2 =
      "Затем задается ряд вопросов по картинке, на которые Вам предстоит ответить по памяти";
}
