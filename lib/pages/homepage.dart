import 'dart:core';
import 'package:ave_memoria/theme/custom_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';
import 'game_rules.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  GlobalData globalData = GlobalData();
  String emailAnon = '';
  int money = 0;
  bool gameRulesFirst1 = true;

  @override
  void initState() {
    emailAnon = globalData.emailAnon;
    money = globalData.money;
    getMoney();
    super.initState();
  }

  String? getEmail() {
    final currentUser = supabase.auth.currentUser;
    if (currentUser != null) {
      final email = currentUser.email!;
      return email;
    } else {
      return "Ваш email скоро здесь появится...";
    }
  }

  void getMoney() async {
    String? email = getEmail();
    email = email.toString();
    final res = await supabase
        .from('profileusergame')
        .select('money')
        .eq('email', email)
        .count(CountOption.exact);
    final data = res.data;
    setState(() {
      globalData.updateMoney(data[0]['money']);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: false,
            appBar: CustomAppBar(
              height: 75.v,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 16.h, right: 16.h),
                      child: Text("AveMemoria",
                          style: CustomTextStyles.extraBold32Primary)),
                  Spacer(),
                  if (supabase.auth.currentUser?.email != "anounymous@gmail.com")
                  Padding(
                      padding: EdgeInsets.only(
                        top: 14.v,
                        bottom: 9.v,
                      ),
                      child: Text(money.toString(),
                          style: CustomTextStyles.semiBold18Text)),
                  if (supabase.auth.currentUser?.email != "anounymous@gmail.com")
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.coins,
                      size: 25.h,
                      color: appTheme.yellow,
                    ),
                    onPressed: () {
                      null;
                    },
                  )
                ],
              ),
              styleType: Style.bgFill,
            ),
            body: Container(
                width: mediaQueryData.size.width,
                height: mediaQueryData.size.height,
                child: SizedBox(
                    width: double.maxFinite,
                    child: Column(children: [
                      SizedBox(
                        height: 75.v,
                      ),
                      Divider(height: 1, color: appTheme.gray),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.h),
                              child: SingleChildScrollView(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    SizedBox(height: 16.v),
                                    GestureDetector(
                                        child: Stack(children: [
                                          Container(
                                              width: 353.h,
                                              height: 167.v,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/cards_game.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                              )),
                                          Positioned(
                                            top: 10.h,
                                            left: 28.h,
                                            child: Text(
                                              'Карточная игра\n'
                                              '"Легион памяти"',
                                              style: TextStyle(
                                                color: Colors.brown,
                                                fontSize: 16.h,
                                                fontFamily: 'fSize',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        ]),
                                        onTap: () {
                                          gameRulesFirst1
                                              ? Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                      pageBuilder: (_, __,
                                                              ___) =>
                                                          const GameRules(
                                                            firstTimes: true,
                                                            countRule: 3,
                                                            goRoute: AppRoutes
                                                                .game_cards,
                                                            text1:
                                                                "Игровое поле состоит из карт, за каждой из которых скрыта картинка. Картинки ― парные, т.е. на игровом поле есть две карты, на которых находятся одинаковые картинки",
                                                            text2:
                                                                "В начале игры на несколько секунд показывают все картинки. Ваша задача запомнить как можно больше карт",
                                                            text3:
                                                                "А затем все карты перевернут рубашкой вверх. Надо с меньшим числом попыток найти и перевернуть парные карты, если картинки различаются, тогда они снова повернутся",
                                                          ),
                                                      opaque: false,
                                                      fullscreenDialog: true))
                                              : GoRouter.of(context)
                                                  .push(AppRoutes.game_cards);
                                        }),
                                    SizedBox(height: 16.v),
                                    GestureDetector(
                                        child: Stack(children: [
                                          Container(
                                              width: 353.h,
                                              height: 167.v,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/cards_game.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                              )),
                                          Positioned(
                                            top: 10.h,
                                            left: 28.h,
                                            child: Text(
                                              'Гладиаторская тренировка памяти',
                                              style: TextStyle(
                                                color: Colors.brown,
                                                fontSize: 16.h,
                                                fontFamily: 'fSize',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        ]),
                                        onTap: () {
                                          gameRulesFirst1
                                              ? Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                      pageBuilder: (_, __,
                                                              ___) =>
                                                          const GameRules(
                                                            firstTimes: true,
                                                            countRule: 3,
                                                            goRoute: AppRoutes
                                                                .game_sequence,
                                                            text1:
                                                                "В каждом раунде, гладиатор показывает последовательность движений.",
                                                            text2:
                                                                "Ваша задача запоинить и воспроизвести эти движения за определенное время, не допуская ошибок.",
                                                            text3:
                                                                "С каждым раундом времени на раздумья будет все меньше, а за ошибку вы теярете по одной жизни.",
                                                          ),
                                                      opaque: false,
                                                      fullscreenDialog: true))
                                              : GoRouter.of(context).push(
                                                  AppRoutes.game_sequence);
                                        }),
                                    SizedBox(height: 16.v),
                                    GestureDetector(
                                        child: Stack(children: [
                                          Container(
                                              width: 353.h,
                                              height: 167.v,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/cards_game.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                              )),
                                          Positioned(
                                            top: 10.h,
                                            left: 28.h,
                                            child: Text(
                                              'Римские картинки',
                                              style: TextStyle(
                                                color: Colors.brown,
                                                fontSize: 16.h,
                                                fontFamily: 'fSize',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        ]),
                                        onTap: () {
                                          gameRulesFirst1
                                              ? Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                      pageBuilder: (_, __,
                                                              ___) =>
                                                          const GameRules(
                                                            firstTimes: true,
                                                            countRule: 2,
                                                            goRoute: AppRoutes
                                                                .game_image,
                                                            text1:
                                                                "В начале вам показывается картинка, вы должны запомнить как можно больше подробнее его",
                                                            text2:
                                                                "Затем задается ряд вопросов по картинке на которые Вам предстоит ответить по памяти",
                                                          ),
                                                      opaque: false,
                                                      fullscreenDialog: true))
                                              : GoRouter.of(context)
                                                  .push(AppRoutes.game_image);
                                        }),
                                    SizedBox(height: 16.v)
                                  ]))))
                    ])))));
  }
}

class ListBuilder extends StatefulWidget {
  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (_, int index) {
          return ListTile(
              trailing: const SizedBox.shrink(), title: Text('item $index'));
        });
  }
}
