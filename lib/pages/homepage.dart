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
  late String nameGame1;
  late String nameGame2;
  late String nameGame3;
  late String game1Rule1;
  late String game1Rule2;
  late String game1Rule3;
  late String game2Rule1;
  late String game2Rule2;
  late String game2Rule3;
  late String game3Rule1;
  late String game3Rule2;
  late String moneyRule;
  late int user_id;

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
    getQuantity();
    getId();
    nameGame1 = globalData.nameGame1;
    nameGame2 = globalData.nameGame2__;
    nameGame3 = globalData.nameGame3;
    game1Rule1 = globalData.game1Rule1;
    game1Rule2 = globalData.game1Rule2;
    game1Rule3 = globalData.game1Rule3;
    game2Rule1 = globalData.game2Rule1;
    game2Rule2 = globalData.game2Rule2;
    game2Rule3 = globalData.game2Rule3;
    game3Rule1 = globalData.game3Rule1;
    game3Rule2 = globalData.game3Rule2;
    moneyRule = globalData.moneyRule;
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

  void getId() async {
    String? email = getEmail();
    email = email.toString();
    final res = await supabase
        .from('profileusergame')
        .select('user_id')
        .eq('email', email)
        .count(CountOption.exact);
    final data = res.data;
    setState(() {
      globalData.updateId(data[0]['user_id']);
      user_id = data[0]['user_id'];
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
    await supabase
        .from('GameRule')
        .update({'is_new': false})
        .eq('user_id', user_id)
        .eq('game', nameGame)
        .count(CountOption.exact);
  }

  void getQuantity() async {
    String? email = getEmail();
    email = email.toString();
    final res =
    supabase.from('usergamedata').select('quantity').eq('email', email);
    final data01 = await res.eq('game', 'cards').count(CountOption.exact);
    final data1 = data01.data;
    final data02 = await res.eq('game', 'sequence').count(CountOption.exact);
    final data2 = data02.data;
    final data03 = await res.eq('game', 'image').count(CountOption.exact);
    final data3 = data03.data;
    setState(() {
      globalData.updateCount(1,data1[0]['quantity']);
      globalData.updateCount(2,data2[0]['quantity']);
      globalData.updateCount(3,data3[0]['quantity']);
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
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_, __, ___) =>
                                    //     GameRules(
                                    //   firstTimes: false,
                                    //   goRoute: "",
                                    //   countRule: 1,
                                    //   text1: moneyRule,
                                    // ),
                                    MoneyPage(
                                      text: moneyRule,
                                    ),
                                opaque: false,
                                fullscreenDialog: true));
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
                                            left: 25.h,
                                            child: Text(nameGame1,
                                                style: CustomTextStyles
                                                    .bold16Text),
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
                                                      'assets/images/quen_game.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                              )),
                                          // Positioned(
                                          //     top: 10.h,
                                          //     child: Column(
                                          //         crossAxisAlignment:
                                          //             CrossAxisAlignment.start,
                                          //         children: [
                                          //           Container(
                                          //             color: appTheme.white,
                                          //             height: 22.v,
                                          //             width: 224.h,
                                          //           ),
                                          //           SizedBox(
                                          //             height: 6.v,
                                          //           ),
                                          //           Container(
                                          //             color: appTheme.white,
                                          //             height: 22.v,
                                          //             width: 80.h,
                                          //           )
                                          //         ])),
                                          Positioned(
                                              top: 10.h,
                                              left: 25.h,
                                              child: Text(nameGame2,
                                                  style: CustomTextStyles
                                                      .bold16Text))
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
                                                      'assets/images/image_game.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                              )),
                                          Positioned(
                                            top: 10.h,
                                            left: 25.h,
                                            child: Text(nameGame3,
                                                style: CustomTextStyles
                                                    .bold16Text),
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

class MoneyPage extends StatelessWidget {
  String text;

  MoneyPage({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: appTheme.black.withOpacity(0.2),
      body: Center(
          child: Container(
              width: 353.h,
              height: 300.v,
              decoration: AppDecoration.outlineGray
                  .copyWith(borderRadius: BorderRadiusStyle.circleBorder15),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  child: Column(children: [
                    SizedBox(height: 10.v),
                    Row(children: [
                      SizedBox(width: 25.h),
                      Spacer(),
                      Text("Мемы", style: CustomTextStyles.extraBold32Text),
                      Spacer(),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.circleXmark,
                          size: 25.h,
                          color: theme.colorScheme.primary,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ]),
                    SizedBox(height: 40.v),
                    Expanded(
                      child: Text(text,
                          style: CustomTextStyles.semiBold18Text,
                          maxLines: 6,
                          textAlign: TextAlign.center),
                    ),
                    SizedBox(height: 25.v)
                  ])))),
    ));
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
