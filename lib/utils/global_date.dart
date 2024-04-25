import 'package:ave_memoria/other/app_export.dart';

class GlobalData {
  static final GlobalData _instance = GlobalData._internal();

  factory GlobalData() {
    return _instance;
  }

  GlobalData._internal();

  String emailAnon = 'anounymous@gmail.com';
  int money = 0;

  void updateMoney(int newData) {
    money = newData;
  }
}