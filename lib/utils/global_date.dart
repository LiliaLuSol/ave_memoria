class GlobalData {
  static final GlobalData _instance = GlobalData._internal();

  factory GlobalData() {
    return _instance;
  }

  GlobalData._internal();

  //общее
  String emailAnon = 'anounymous@gmail.com';
  int money = 0;

  void updateMoney(int newData) {
    money = newData;
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

  void updateCount(int numberGame) {
    switch (numberGame) {
      case 1:
        countGame1++;
        break;
      case 2:
        countGame2++;
        break;
      case 3:
        countGame3++;
        break;
      default:
        throw ArgumentError('глобал апдейт каунт');
    }
  }

  String moneyRule = 'Внутриигровая валюта - Мем. Можно получить за мини-игры и достижения. Потратить можно на рынке или на открытие новых уровней в сюжете';

  //игры
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
  String nameGame2__ = "Гладиаторская тренировка\nпамяти";
  String game2Rule1 =
      "В каждом раунде, гладиатор-учитель показывает последовательность движений";
  String game2Rule2 =
      "Ваша задача запомнить и воспроизвести эту последовательность, не допуская ошибок";
  String game2Rule3 =
      "С каждым раундом последовательность становится все длинее, а за ошибку Вы теярете по одной жизни";

  String nameGame3 = 'Взгляд в будущее';
  String game3Rule1 =
      "В начале игры Вам показывается картинка на 20 секунд, Вы должны запомнить как можно больше деталей";
  String game3Rule2 =
      "Затем задается ряд вопросов по картинке, на которые Вам предстоит ответить по памяти";

  //проводник

}
