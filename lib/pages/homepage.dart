import 'dart:core';
import 'dart:io';
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
  String nameGame1 = '';
  String nameGame2 = '';
  String nameGame3 = '';
  String game1Rule1 = '';
  String game1Rule2 = '';
  String game1Rule3 = '';
  String game2Rule1 = '';
  String game2Rule2 = '';
  String game2Rule3 = '';
  String game3Rule1 = '';
  String game3Rule2 = '';

  bool _isConnection = false;
  late bool gameRulesFirst1;
  late bool gameRulesFirst2;
  late bool gameRulesFirst3;

  @override
  void initState() {
    gameRulesFirst1 = true;
    gameRulesFirst2 = true;
    gameRulesFirst3 = true;
    emailAnon = globalData.emailAnon;
    money = globalData.money;
    getMoney();
    _tryConnection();
    getFirstRule();
    nameGame1 = globalData.nameGame1;
    nameGame2 = globalData.nameGame2;
    nameGame3 = globalData.nameGame3;
    game1Rule1 = globalData.game1Rule1;
    game1Rule2 = globalData.game1Rule2;
    game1Rule3 = globalData.game1Rule3;
    game2Rule1 = globalData.game2Rule1;
    game2Rule2 = globalData.game2Rule2;
    game2Rule3 = globalData.game2Rule3;
    game3Rule1 = globalData.game3Rule1;
    game3Rule2 = globalData.game3Rule2;
    super.initState();
  }

  Future<void> _tryConnection() async {
    try {
      final response = await InternetAddress.lookup('www.google.com');
      setState(() {
        _isConnection = response.isNotEmpty;
      });
    } on SocketException catch (e) {
      setState(() {
        _isConnection = false;
      });
    }
  }

  String? getEmail() {
    final currentUser = supabase.auth.currentUser;
    if (currentUser != null) {
      final email = currentUser.email!;
      return email;
    } else if (_isConnection) {
      return emailAnon;
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

  void getFirstRule() async {
    String? email = getEmail();
    email = email.toString();
    final res = await supabase
        .from('usergamedata')
        .select('is_new')
        .eq('email', email)
        .count(CountOption.exact);
    final data = res.data;
    setState(() {
      gameRulesFirst1 = data[0]['is_new'];
      gameRulesFirst2 = data[2]['is_new'];
      gameRulesFirst3 = data[1]['is_new'];
    });
  }

  Future<void> updateFirstRule(String nameGame) async {
    String? email = getEmail();
    email = email.toString();
    await supabase
        .from('GameRule')
        .update({'is_new': false})
        .eq('email', email)
        .eq('game', 'cards')
        .count(CountOption.exact);
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
                  if (supabase.auth.currentUser?.email !=
                      "anounymous@gmail.com")
                    Padding(
                        padding: EdgeInsets.only(
                          top: 14.v,
                          bottom: 9.v,
                        ),
                        child: Text(money.toString(),
                            style: CustomTextStyles.semiBold18Text)),
                  if (supabase.auth.currentUser?.email !=
                      "anounymous@gmail.com")
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
                                              decoration: const BoxDecoration(
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
                                              nameGame1,
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
                                              ? {
                                                  setState(() {
                                                    gameRulesFirst1 = false;
                                                    updateFirstRule('cards');
                                                  }),
                                                  Navigator.push(
                                                      context,
                                                      PageRouteBuilder(
                                                          pageBuilder: (_, __,
                                                                  ___) =>
                                                              GameRules(
                                                                firstTimes:
                                                                    true,
                                                                countRule: 3,
                                                                goRoute: AppRoutes
                                                                    .game_cards,
                                                                text1:
                                                                    game1Rule1,
                                                                text2:
                                                                    game1Rule2,
                                                                text3:
                                                                    game1Rule3,
                                                              ),
                                                          opaque: false,
                                                          fullscreenDialog:
                                                              true))
                                                }
                                              : GoRouter.of(context)
                                                  .push(AppRoutes.game_cards);
                                        }),
                                    SizedBox(height: 16.v),
                                    GestureDetector(
                                        child: Stack(children: [
                                          Container(
                                              width: 353.h,
                                              height: 167.v,
                                              decoration: const BoxDecoration(
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
                                              nameGame2,
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
                                          gameRulesFirst2
                                              ? {
                                                  setState(() {
                                                    gameRulesFirst2 = false;
                                                    updateFirstRule('sequence');
                                                  }),
                                                  Navigator.push(
                                                      context,
                                                      PageRouteBuilder(
                                                          pageBuilder: (_, __,
                                                                  ___) =>
                                                              GameRules(
                                                                firstTimes:
                                                                    true,
                                                                countRule: 3,
                                                                goRoute: AppRoutes
                                                                    .game_sequence,
                                                                text1:
                                                                    game2Rule1,
                                                                text2:
                                                                    game2Rule2,
                                                                text3:
                                                                    game2Rule3,
                                                              ),
                                                          opaque: false,
                                                          fullscreenDialog:
                                                              true))
                                                }
                                              : GoRouter.of(context).push(
                                                  AppRoutes.game_sequence);
                                        }),
                                    SizedBox(height: 16.v),
                                    GestureDetector(
                                        child: Stack(children: [
                                          Container(
                                              width: 353.h,
                                              height: 167.v,
                                              decoration: const BoxDecoration(
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
                                              nameGame1,
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
                                          gameRulesFirst3
                                              ? {
                                                  setState(() {
                                                    gameRulesFirst3 = false;
                                                    updateFirstRule('image');
                                                  }),
                                                  Navigator.push(
                                                      context,
                                                      PageRouteBuilder(
                                                          pageBuilder: (_, __,
                                                                  ___) =>
                                                              GameRules(
                                                                firstTimes:
                                                                    true,
                                                                countRule: 2,
                                                                goRoute: AppRoutes
                                                                    .game_image,
                                                                text1:
                                                                    game3Rule1,
                                                                text2:
                                                                    game3Rule2,
                                                              ),
                                                          opaque: false,
                                                          fullscreenDialog:
                                                              true))
                                                }
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
