import 'package:flutter/material.dart';

class GlobalData {
  static final GlobalData _instance = GlobalData._internal();

  factory GlobalData() {
    return _instance;
  }

  GlobalData._internal();

  //общее
  String emailAnon = 'anounymous@gmail.com';
  bool isAnon = false;
  bool isReg = false;
  bool isAuth = false;
  int money = 0;
  int user_id = 0;

  void updateMoney(int newData) {
    money = newData;
  }

  void updateId(int newData) {
    user_id = newData;
  }

  void updateAnonStatus(bool newData) {
    isAnon = newData;
  }

  void updateRegAuthStatus(bool newData1, bool newData2) {
    isReg = newData1;
    isAuth = newData2;
  }

  //статистика
  int mon = 0;
  int tue = 0;
  int wen = 0;
  int thu = 0;
  int fri = 0;
  int sat = 0;
  int sun = 0;

  int countGame1 = 0;
  int countGame2 = 0;
  int countGame3 = 0;

  int best1 = 0;
  int best2 = 0;

  int score = 0;
  int streakCount = 0;

  void updateScore(int newData) {
   score = newData;
  }

  void updateDay(int dayOfWeek, int newData) {
    switch (dayOfWeek) {
      case DateTime.monday:
        mon = newData;
        break;
      case DateTime.tuesday:
        tue = newData;
        break;
      case DateTime.wednesday:
        wen = newData;
        break;
      case DateTime.thursday:
        thu = newData;
        break;
      case DateTime.friday:
        fri = newData;
        break;
      case DateTime.saturday:
        sat = newData;
        break;
      case DateTime.sunday:
        sun = newData;
        break;
      default:
        throw ArgumentError('глобал апдейт дей');
    }
  }

  void updateCount(int numberGame, int current) {
    switch (numberGame) {
      case 1:
        countGame1 = current;
        break;
      case 2:
        countGame2 = current;
        break;
      case 3:
        countGame3 = current;
        break;
      case 10:
        countGame1++;
        break;
      case 20:
        countGame2++;
        break;
      case 30:
        countGame3++;
        break;
      default:
        throw ArgumentError('глобал апдейт каунт');
    }
  }

  void updateBest(int game, int newDate) {
    switch (game) {
      case 1:
        best1 = newDate;
        break;
      case 2:
        best2 = newDate;
        break;
      default:
        throw ArgumentError('глобал апдейт бест');
    }
  }

  String moneyRule =
      'Внутриигровая валюта - Мем. Можно получить за мини-игры и достижения. Потратить можно на рынке или на открытие новых уровней в сюжете';

  //игры
  String image1 = "";
  String image2 = "";
  String image3 = "";

  void updateImage(String newData1, String? newData2, String? newData3) {
    image1 = newData1;
    image2 = newData2!;
    image3 = newData3!;
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

  String image1Game1 = "assets/images/image1Game1.png";
  String image2Game1 = 'assets/images/image2Game1.png';
  String image3Game1 = 'assets/images/image3Game1.png';

  String nameGame2 = 'Гладиаторская тренировка памяти';
  String nameGame2_ = "    Гладиаторская\nтренировка памяти";
  String nameGame2__ = "Гладиаторская тренировка\nпамяти";
  String game2Rule1 =
      "В каждом раунде, гладиатор-учитель показывает последовательность движений";
  String game2Rule2 =
      "Ваша задача запомнить и воспроизвести эту последовательность, не допуская ошибок";
  String game2Rule3 =
      "С каждым раундом последовательность становится все длинее, а за ошибку Вы теряете по одной жизни";

  String image1Game2 = "assets/images/image1Game2.png";
  String image2Game2 = 'assets/images/image2Game2.png';
  String image3Game2 = 'assets/images/image3Game2.png';

  String nameGame3 = 'Взгляд в будущее';
  String game3Rule1 =
      "В начале игры Вам показывается картинка на 20 секунд, Вы должны запомнить как можно больше деталей";
  String game3Rule2 =
      "Затем задается ряд вопросов по картинке, на которые Вам предстоит ответить по памяти";

  String image1Game3 = "assets/images/image1Game3.png";
  String image2Game3 = 'assets/images/image2Game3.png';

//проводник

  int curSecurity = 0;

  void updateCurSecurity(int newData) {
    curSecurity = newData;
  }

//профиль

  bool news = false;
  bool notification = false;
  TimeOfDay notification_time = TimeOfDay.now();

  void updateNews(bool newData) {
    news = newData;
  }

  void updateNotification(bool newData) {
    notification = newData;
  }

  void updateNotificationTime(TimeOfDay newData) {
    notification_time = newData;
  }

//сюжет
  dynamic gameData = {};
  int stars = 0;
  bool isReplay = false;

  void updateGameDate(dynamic newData) {
    gameData = newData;
  }

  void updateStars(int newData) {
    stars = newData;
  }

  void updateIsReplay(bool newData) {
    isReplay = newData;
  }

}
