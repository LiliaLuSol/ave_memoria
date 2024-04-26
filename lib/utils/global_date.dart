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

  void updateMoney(int newData) {
    money = newData;
  }
}
