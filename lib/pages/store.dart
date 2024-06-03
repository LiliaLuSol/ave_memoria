import 'package:ave_memoria/main.dart';
import 'package:ave_memoria/pages/article.dart';
import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'homepage.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> with TickerProviderStateMixin {
  late final TabController _tabController;
  late Stream<ConnectivityResult> connectivityStream;
  bool isConnected = true;
  GlobalData globalData = GlobalData();
  String emailAnon = '';
  int money = 0;
  late int countGame1;
  late int countGame2;
  late int countGame3;
  late int curSecurity;
  late int user_id;
  late String moneyRule;

  @override
  void initState() {
    super.initState();
    connectivityStream = Connectivity().onConnectivityChanged;
    checkInitialConnection();
    _tabController = TabController(length: 4, vsync: this);
    emailAnon = globalData.emailAnon;
    money = globalData.money;
    curSecurity = globalData.curSecurity;
    user_id = globalData.user_id;
    getMoney();
    getSecurity();
    countGame1 = globalData.countGame1;
    countGame2 = globalData.countGame2;
    countGame3 = globalData.countGame3;
    moneyRule = globalData.moneyRule;
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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<dynamic> getAchievementList() async {
    String? email = getEmail();
    email = email.toString();
    List<dynamic> list = await supabase
        .from("userachievements")
        .select()
        .eq('email', email)
        .eq('availble', true)
        .order('achievement_name', ascending: true);

    return list;
  }

  Future<dynamic> getStoreList() async {
    String? email = getEmail();
    email = email.toString();
    List<dynamic> list = await supabase
        .from("storelist")
        .select()
        .lte('security', curSecurity)
        .eq('available', true)
        .eq('email', email);

    return list;
  }

  Future<dynamic> getShopList() async {
    String? email = getEmail();
    email = email.toString();
    List<dynamic> list = await supabase
        .from("usershope")
        .select()
        .lte('security', curSecurity)
        .eq('email', email);

    return list;
  }

  void getSecurity() async {
    final res = await supabase
        .from('Characters')
        .select('security')
        .eq('user_id', globalData.user_id)
        .single()
        .count(CountOption.exact);
    final data = res.data;
    globalData.updateCurSecurity(data['security']);
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
                              child: Text("Проводник",
                                  style: CustomTextStyles.extraBold32Text)),
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
        child: globalData.isAnon || !isConnected
            ? Column(children: [
                SizedBox(height: 75.v),
                Divider(height: 1, color: appTheme.gray),
                Expanded(child: lock())
              ])
            : Column(children: [
                SizedBox(height: 75.v),
                Divider(height: 1, color: appTheme.gray),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.v),
                    child: SizedBox(
                        height: 27.v,
                        width: 359.h,
                        child: TabBar(
                            controller: _tabController,
                            labelPadding: EdgeInsets.zero,
                            indicatorPadding:
                                EdgeInsets.symmetric(horizontal: -10.h),
                            labelStyle: CustomTextStyles.regular16White,
                            unselectedLabelStyle:
                                CustomTextStyles.regular16Text,
                            indicator: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(
                                50.h,
                              ),
                            ),
                            tabs: const [
                              Tab(
                                child: Text("библиотека"),
                              ),
                              Tab(
                                child: Text("рынок"),
                              ),
                              Tab(
                                child: Text("склад"),
                              ),
                              Tab(
                                child: Text("достижения"),
                              ),
                            ]))),
                Divider(height: 1, color: appTheme.gray),
                SizedBox(height: 15.v),
                Expanded(
                    child: TabBarView(
                        controller: _tabController,
                        children: <Widget>[
                      const NestedTabBar('библиотека'),
                      FutureBuilder(
                          future: getShopList(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(
                                    color: theme.colorScheme.primary),
                              );
                            }
                            final list = snapshot.data!;
                            return buildListShop(list);
                          }),
                      FutureBuilder(
                          future: getStoreList(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(
                                    color: theme.colorScheme.primary),
                              );
                            }
                            final list = snapshot.data!;
                            return buildListStore(list);
                          }),
                      FutureBuilder(
                          future: getAchievementList(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(
                                    color: theme.colorScheme.primary),
                              );
                            }
                            final list = snapshot.data!;
                            return buildListAch(list);
                          }),
                    ])),
              ]),
      ),
    );
  }

  Widget buildListAch(List<dynamic> list) {
    final List<int> countGame = [countGame2, countGame1, countGame3];
    return SingleChildScrollView(
        child: Column(
      children: [
        GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 170.h,
              childAspectRatio: 1,
              mainAxisSpacing: 15.h,
              crossAxisSpacing: 15.h),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.all(16.h),
          itemCount: list.length,
          itemBuilder: (BuildContext ctx, index) {
            final bool isCountValid = (countGame[index] == 1 &&
                    list[index]['achievement_name'].lastChars(1) == 'I') ||
                (countGame[index] == 5 &&
                    list[index]['achievement_name'].lastChars(2) == 'II') ||
                (countGame[index] == 15 &&
                    list[index]['achievement_name'].lastChars(3) == 'III') ||
                (countGame[index] > 1 &&
                    countGame[index] < 5 &&
                    (countGame[index] == 1 &&
                        list[index]['achievement_name'].lastChars(1) == 'I')) ||
                (countGame[index] > 5 && countGame[index] < 15) ||
                (countGame[index] >= 15);
            return Container(
                decoration: AppDecoration.outlineGray
                    .copyWith(borderRadius: BorderRadiusStyle.circleBorder5),
                key: ValueKey(list[index]['achievement_id']),
                width: 170.h,
                height: 150.v,
                child: Padding(
                  padding: EdgeInsets.all(4.h),
                  child: Column(
                    children: [
                      Text(
                        list[index]['achievement_name'],
                        style: CustomTextStyles.extraBold16Text,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                      SizedBox(height: 4.v),
                      Divider(height: 1, color: appTheme.gray),
                      SizedBox(height: 4.v),
                      const Spacer(),
                      Text(
                        list[index]['achievement_desc'],
                        style: CustomTextStyles.regular16Text,
                        maxLines: 3,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.v),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('+${list[index]['money']} '),
                            FaIcon(
                              FontAwesomeIcons.coins,
                              size: 16.h,
                              color: appTheme.yellow,
                            ),
                          ]),
                      const Spacer(),
                      SizedBox(height: 4.v),
                      CustomElevatedButton(
                        text: isCountValid ? 'Получить' : 'Не выполнено',
                        height: 30.v,
                        buttonStyle: isCountValid
                            ? ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.h)),
                              )
                            : ElevatedButton.styleFrom(
                                backgroundColor: appTheme.gray,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.h)),
                              ),
                        buttonTextStyle: CustomTextStyles.regular16White,
                        onTap: () async {
                          PostgrestMap res;
                          isCountValid
                              ? {
                                  setState(() {
                                    globalData.updateMoney((globalData.money +
                                            list[index]['money'])
                                        .toInt());
                                    money = globalData.money;
                                  }),
                                  await supabase
                                      .from('Characters')
                                      .update({'money': globalData.money})
                                      .eq('user_id', globalData.user_id)
                                      .count(CountOption.exact),
                                  await supabase
                                      .from("UserAchievements")
                                      .update({'availble': false})
                                      .eq('user_id', user_id)
                                      .eq('achievement_id',
                                          list[index]['achievement_id']),
                                  res = await supabase
                                      .from('Achievements')
                                      .select()
                                      .ilike('achievement_name',
                                          '${list[index]['achievement_name']}%')
                                      .gt('achievement_id',
                                          list[index]['achievement_id'])
                                      .order('achievement_name',
                                          ascending: true)
                                      .limit(1)
                                      .single(),
                                  await supabase
                                      .from("UserAchievements")
                                      .update({'availble': true})
                                      .eq('user_id', user_id)
                                      .eq('achievement_id',
                                          res['achievement_id']),
                                  setState(() {
                                    list.length;
                                  })
                                }
                              : null;
                        },
                      ),
                    ],
                  ),
                ));
          },
        ),
      ],
    ));
  }

  Widget buildListStore(List<dynamic> list) {
    return SingleChildScrollView(
        child: Column(
      children: [
        GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 706.h,
              childAspectRatio: 2.35,
              mainAxisSpacing: 15.h),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.all(16.h),
          itemCount: list.length,
          itemBuilder: (BuildContext ctx, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Article(
                        title:
                            list[index]["title"] ?? list[index]["store_name"],
                        num: list[index]["title"] != null ? 1 : 2,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: AppDecoration.outlineGray
                      .copyWith(borderRadius: BorderRadiusStyle.circleBorder5),
                  width: 353.h,
                  height: 150.v,
                  child: Padding(
                      padding: EdgeInsets.all(16.v),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(list[index]['micro_image']),
                                fit: BoxFit.cover,
                              ),
                            ),
                            height: 100.v,
                            width: 100.h,
                          ),
                          VerticalDivider(
                            color: appTheme.gray,
                            thickness: 1,
                          ),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                Text(
                                  list[index]['store_name'],
                                  style: CustomTextStyles.extraBold16Text,
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(height: 4.v),
                                Text(
                                  list[index]['store_desc'],
                                  style: CustomTextStyles.regular16Text,
                                  maxLines: 4,
                                  textAlign: TextAlign.start,
                                ),
                              ])),
                          SizedBox(width: 3.h),
                          CustomImageView(
                            svgPath: ImageConstant.imgArrowright,
                            height: 15.v,
                            width: 9.h,
                            margin: EdgeInsets.only(top: 2.v, bottom: 5.v),
                          ),
                        ],
                      )),
                ));
          },
        ),
      ],
    ));
  }

  Widget buildListShop(List<dynamic> list) {
    return SingleChildScrollView(
        child: Column(
      children: [
        GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 170.h,
              childAspectRatio: 1,
              mainAxisSpacing: 15.h,
              crossAxisSpacing: 15.h),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(16.h),
          itemCount: list.length,
          itemBuilder: (BuildContext ctx, index) {
            bool is_buy = list[index]['is_buy'];
            return Container(
                decoration: AppDecoration.outlineGray
                    .copyWith(borderRadius: BorderRadiusStyle.circleBorder5),
                key: ValueKey(list[index]['item_id']),
                width: 170.h,
                height: 150.v,
                child: Padding(
                  padding: EdgeInsets.all(4.h),
                  child: Column(
                    children: [
                      Text(
                        list[index]['item_name'],
                        style: CustomTextStyles.extraBold16Text,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.v),
                      Divider(height: 1, color: appTheme.gray),
                      SizedBox(height: 4.v),
                      const Spacer(),
                      Text(
                        list[index]['item_description'],
                        style: CustomTextStyles.regular16Text,
                        maxLines: 3,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.v),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('цена: '),
                            const Spacer(),
                            Text('${list[index]['item_price']} '),
                            FaIcon(
                              FontAwesomeIcons.coins,
                              size: 16.h,
                              color: appTheme.yellow,
                            ),
                            const Spacer(),
                          ]),
                      const Spacer(),
                      SizedBox(height: 4.v),
                      CustomElevatedButton(
                        text: is_buy ? 'куплено' : 'купить',
                        height: 30.v,
                        buttonStyle: is_buy
                            ? ElevatedButton.styleFrom(
                                backgroundColor: appTheme.gray,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.h)),
                              )
                            : ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.h)),
                              ),
                        buttonTextStyle: CustomTextStyles.regular16White,
                        onTap: () async {
                          list[index]['item_price'] <= globalData.money
                              ? {
                                  setState(() {
                                    globalData.updateMoney((globalData.money -
                                            list[index]['item_price'])
                                        .toInt());
                                    money = globalData.money;
                                    is_buy = true;
                                    if (list[index]['item_id'] == 1) {
                                      globalData.updateCurSecurity(2);
                                    }
                                  }),
                                  await supabase
                                      .from('Characters')
                                      .update({'money': globalData.money})
                                      .eq('user_id', globalData.user_id)
                                      .count(CountOption.exact),
                                  await supabase
                                      .from("Purchases")
                                      .update({'is_buy': true})
                                      .eq('user_id', user_id)
                                      .eq('item_id', list[index]['item_id']),
                                  if (list[index]['item_id'] == 1)
                                    {
                                      await supabase
                                          .from("Characters")
                                          .update({'security': 2}).eq(
                                              'user_id', user_id)
                                    },
                                }
                              : context.showsnackbar(
                                  title: 'Недостаточно средств для покупки!',
                                  color: Colors.grey);
                        },
                      ),
                    ],
                  ),
                ));
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Text(
            'Для получения большего числа предметов следует дальше проходить сюжет',
            textAlign: TextAlign.center,
            style: CustomTextStyles.regular16Primary,
          ),
        ),
      ],
    ));
  }
}

class NestedTabBar extends StatefulWidget {
  const NestedTabBar(this.outerTab, {super.key});

  final String outerTab;

  @override
  State<NestedTabBar> createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  GlobalData globalData = GlobalData();
  late int curSecurity;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    curSecurity = globalData.curSecurity;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<dynamic> getArticleSelfList() async {
    List<dynamic> list = await supabase
        .from("librarylist")
        .select()
        .eq("type", "self-development")
        .lte('security', curSecurity);
    return list;
  }

  Future<dynamic> getArticleStoryList() async {
    List<dynamic> list = await supabase
        .from("librarylist")
        .select()
        .eq("type", "story")
        .lte('security', curSecurity);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar.secondary(
          controller: _tabController,
          labelPadding: EdgeInsets.zero,
          indicatorPadding: EdgeInsets.symmetric(horizontal: 8.h),
          labelStyle: CustomTextStyles.regular16White,
          unselectedLabelStyle: CustomTextStyles.regular16Text,
          indicator: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(
              50.h,
            ),
          ),
          tabs: const <Widget>[
            Tab(text: 'саморазвитие'),
            Tab(text: 'сюжет'),
          ],
        ),
        SizedBox(height: 15.v),
        Divider(height: 1, color: appTheme.gray),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              FutureBuilder(
                  future: getArticleSelfList(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                            color: theme.colorScheme.primary),
                      );
                    }
                    final list = snapshot.data!;
                    return buildList(list,
                        'Для получения большего числа сведений необходимо иметь Карту доступа ур. ${curSecurity + 1} и выше');
                  }),
              FutureBuilder(
                  future: getArticleStoryList(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                            color: theme.colorScheme.primary),
                      );
                    }
                    final list = snapshot.data!;
                    return buildList(list,
                        'Для получения большего числа сведений следует дальше проходить сюжет');
                  }),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildList(List<dynamic> list, String footerText) {
    return SingleChildScrollView(
        child: Column(
      children: [
        GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 706.h,
            childAspectRatio: 3.92,
            mainAxisSpacing: 15.h,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(16.h),
          itemCount: list.length,
          itemBuilder: (BuildContext ctx, index) {
            return GestureDetector(
              child: Container(
                decoration: AppDecoration.outlineGray
                    .copyWith(borderRadius: BorderRadiusStyle.circleBorder5),
                width: 353.h,
                height: 90.v,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 16.v),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        SizedBox(
                            width: 320.h,
                            child: Text(
                              list[index]["title"],
                              maxLines: 2,
                              style: CustomTextStyles.semiBold18Text,
                            )),
                        const Spacer(),
                        Text(
                          'На прочтение: ${list[index]["time_read"]} минут',
                          style: CustomTextStyles.regular16Text,
                        ),
                        const Spacer(),
                      ],
                    ),
                    const Spacer(),
                    CustomImageView(
                      svgPath: ImageConstant.imgArrowright,
                      height: 15.v,
                      width: 9.h,
                      margin: EdgeInsets.only(top: 2.v, bottom: 5.v),
                    ),
                    SizedBox(width: 16.v),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Article(
                        title:
                            list[index]["title"] ?? list[index]["store_name"],
                        num: list[index]["title"] != null ? 1 : 2),
                  ),
                );
              },
            );
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Text(
            footerText,
            textAlign: TextAlign.center,
            style: CustomTextStyles.regular16Primary,
          ),
        ),
        SizedBox(height: 16.v),
      ],
    ));
  }
}
