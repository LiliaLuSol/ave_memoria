import 'package:ave_memoria/main.dart';
import 'package:ave_memoria/pages/warning_cond.dart';
import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dialog_game.dart';
import 'homepage.dart';

class Story extends StatefulWidget {
  const Story({super.key});

  @override
  State<Story> createState() => _StoryState();
}

class _StoryState extends State<Story> {
  late Stream<ConnectivityResult> connectivityStream;
  bool isConnected = true;
  GlobalData globalData = GlobalData();
  String emailAnon = '';
  int money = 0;
  int filledStars = 0;
  late String moneyRule;

  @override
  void initState() {
    connectivityStream = Connectivity().onConnectivityChanged;
    checkInitialConnection();
    emailAnon = globalData.emailAnon;
    money = globalData.money;
    filledStars = 3;
    moneyRule = globalData.moneyRule;
    getMoney();
    getLevels();
    super.initState();
  }

  void checkInitialConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      isConnected = connectivityResult != ConnectivityResult.none;
    });
  }

  String? getEmail() {
    final currentUser = supabase.auth.currentUser;
    if (currentUser != null) {
      return currentUser.email;
    } else {
      return '';
    }
  }

  void getMoney() async {
    String? email = getEmail();
    email = email.toString();
    final res = await supabase
        .from('profileusergame')
        .select('money')
        .eq('email', email)
        .single()
        .count(CountOption.exact);
    final data = res.data;
    setState(() {
      globalData.updateMoney(data['money']);
      money = globalData.money;
    });
  }

  Future<dynamic> getLevels() async {
    List<dynamic> list = await supabase
        .from('levelsuser')
        .select()
        .eq('user_id', globalData.user_id)
        .order('number', ascending: true);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return StreamBuilder<ConnectivityResult>(
        stream: connectivityStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
          } else {
            isConnected = snapshot.data != ConnectivityResult.none;
          }
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
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "Сюжет",
                                    style: CustomTextStyles.extraBold32Text),
                                if (!isConnected)
                                  TextSpan(
                                      text: ". Глава I",
                                      style: CustomTextStyles.extraBold32Text)
                              ]))),
                          const Spacer(),
                          if (!globalData.isAnon)
                            Padding(
                                padding: EdgeInsets.only(
                                  top: 14.v,
                                  bottom: 9.v,
                                ),
                                child: Text(money.toString(),
                                    style: CustomTextStyles.semiBold18Text)),
                          if (!globalData.isAnon)
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
                                        pageBuilder: (_, __, ___) => MoneyPage(
                                              text: moneyRule,
                                            ),
                                        opaque: false,
                                        fullscreenDialog: true));
                              },
                            )
                        ],
                      ),
                      styleType: Style.bgFill),
                  body: globalData.isAnon
                      ? buildContent()
                      : isConnected
                          ? buildContent()
                          : no_internet()));
        });
  }

  Widget buildContent() {
    return SizedBox(
        width: mediaQueryData.size.width,
        height: mediaQueryData.size.height,
        child: SizedBox(
            width: double.maxFinite,
            child: globalData.isAnon
                ? Column(children: [
                    SizedBox(height: 75.v),
                    Divider(height: 1, color: appTheme.gray),
                    Expanded(child: lock())
                  ])
                : Column(children: [
                    SizedBox(
                      height: 75.v,
                    ),
                    Divider(height: 1, color: appTheme.gray),
                    Stack(children: [
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(left: 16.h, right: 16.h),
                              child: SingleChildScrollView(
                                  child: Column(children: [
                                SizedBox(height: 5.v),
                                Text("Глава I",
                                    style: CustomTextStyles.extraBold32Text,
                                    textAlign: TextAlign.center),
                                FutureBuilder(
                                    future: getLevels(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: CircularProgressIndicator(
                                              color: theme.colorScheme.primary),
                                        );
                                      }
                                      final list = snapshot.data!;
                                      return buildList(list);
                                    })
                              ])))),
                      Column(children: [
                        SizedBox(height: 345.v),
                        SizedBox(
                            width: 393.h,
                            height: 343.v,
                            child: Stack(children: [
                              Container(
                                  width: 393.h,
                                  height: 343.v,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/cloud.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  )),
                              Center(
                                  child: Padding(
                                      padding: EdgeInsets.all(16.h),
                                      child: Text(
                                          'Скоро будет продолжение! Следите за обновлениями',
                                          style: CustomTextStyles
                                              .extraBold20Primary,
                                          textAlign: TextAlign.center)))
                            ])),
                        Container(
                            color: appTheme.white, width: 393.h, height: 25.v)
                      ])
                    ])
                  ])));
  }

  Widget buildList(List<dynamic> list) {
    return SingleChildScrollView(
        child: Column(
      children: [
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 2.85,
          ),
          padding: EdgeInsets.only(top: 0.v),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (BuildContext ctx, index) {
            return GestureDetector(
                onTap: () {
                  if (list[index]['is_available']) {
                    globalData.updateGameDate(list[index]);
                    if (list[index]['try']) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DialogGame(
                              isStart: true, isEndSuc: false, isEndFail: false),
                        ),
                      );
                    } else if (list[index]['cond_start'] > 0) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => WarningCondGame(
                              cond_start: list[index]['cond_start'],
                          currentLevel: list[index]['number']),
                          opaque: false,
                          fullscreenDialog: true,
                        ),
                      ).then((value) => setState(() {}));
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DialogGame(
                              isStart: true, isEndSuc: false, isEndFail: false),
                        ),
                      );
                    }
                  }
                },
                child: Container(
                    key: ValueKey(list[index]['level_id']),
                    child: Column(children: [
                      SizedBox(height: 28.v),
                      list[index]['number'] * 10 % 2 == 0
                          ? story_card(
                              context,
                              svgPath: ImageConstant.imgStoryL,
                              gameData: list[index],
                            )
                          : story_card(
                              context,
                              svgPath: ImageConstant.imgStoryR,
                              gameData: list[index],
                            )
                    ])));
          },
        ),
      ],
    ));
  }
}
