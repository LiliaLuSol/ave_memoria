import 'package:ave_memoria/blocs/Auth/bloc/authentication_bloc.dart';
import 'package:ave_memoria/main.dart';
import 'package:ave_memoria/pages/article.dart';
import 'package:ave_memoria/theme/theme_helper.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';
import 'package:flutter/rendering.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> with TickerProviderStateMixin {
  late final TabController _tabController;
  GlobalData globalData = GlobalData();
  String emailAnon = '';
  int money = 0;
  int countGame1 = 0;
  int countGame2 = 0;
  int countGame3 = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    emailAnon = globalData.emailAnon;
    money = globalData.money;
    getMoney();
    countGame1 = globalData.countGame1;
    countGame2 = globalData.countGame2;
    countGame3 = globalData.countGame3;
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
    _tabController.dispose();
    super.dispose();
  }

  Future<dynamic> has_internet() async {
    return await Connectivity().checkConnectivity();
  }

  Future<dynamic> getArticleSelfList() async {
    String? email = getEmail();
    email = email.toString();
    List<dynamic> list = await supabase
        .from("userachievements")
        .select()
        .eq('email', email)
        .eq('availble', true);

    return list;
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is UnAuthenticatedState) {
            GoRouter.of(context).pushReplacement(AppRoutes.authreg);
          } else if (state is AuthErrorState) {
            Future<dynamic> has_internet() async {
              return await Connectivity().checkConnectivity();
            }
          }
        },
        child: SafeArea(
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
                        onPressed: () {},
                      )
                  ],
                ),
                styleType: Style.bgFill),
            body: Container(
              width: mediaQueryData.size.width,
              height: mediaQueryData.size.height,
              child: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
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
                                  child: Text(
                                    "библиотека",
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    "рынок",
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    "склад",
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    "достижения",
                                  ),
                                ),
                              ]))),
                  Divider(height: 1, color: appTheme.gray),
                  SizedBox(height: 15.v),
                  Expanded(
                      child: TabBarView(
                          controller: _tabController,
                          children: <Widget>[
                        NestedTabBar('библиотека'),
                        Column(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  decoration: AppDecoration.outlineGray
                                      .copyWith(
                                          borderRadius:
                                              BorderRadiusStyle.circleBorder5),
                                  width: 170.h,
                                  height: 104.v,
                                ),
                                Container(
                                  decoration: AppDecoration.outlineGray
                                      .copyWith(
                                          borderRadius:
                                              BorderRadiusStyle.circleBorder5),
                                  width: 170.h,
                                  height: 104.v,
                                ),
                              ]),
                          SizedBox(height: 20.v),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  decoration: AppDecoration.outlineGray
                                      .copyWith(
                                          borderRadius:
                                              BorderRadiusStyle.circleBorder5),
                                  width: 170.h,
                                  height: 104.v,
                                ),
                                Container(
                                  decoration: AppDecoration.outlineGray
                                      .copyWith(
                                          borderRadius:
                                              BorderRadiusStyle.circleBorder5),
                                  width: 170.h,
                                  height: 104.v,
                                ),
                              ]),
                        ]),
                        Column(children: [
                          Container(
                            decoration: AppDecoration.outlineGray.copyWith(
                                borderRadius: BorderRadiusStyle.circleBorder5),
                            width: 353.h,
                            height: 90.v,
                          ),
                          SizedBox(height: 15.v),
                          Container(
                            decoration: AppDecoration.outlineGray.copyWith(
                                borderRadius: BorderRadiusStyle.circleBorder5),
                            width: 353.h,
                            height: 90.v,
                          ),
                        ]),
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
                              return buildListAch(list);
                            }),
                      ])),
                ]),
              ),
            ),
          ),
        ));
  }

  Widget buildListAch(List<dynamic> list) {
    final List<int> countGame = [countGame1, countGame2, countGame3];
    return Column(
      children: [
        GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 170.h,
              childAspectRatio: 1,
              mainAxisSpacing: 15.h,
              crossAxisSpacing: 15.h),
          shrinkWrap: true,
          padding: EdgeInsets.all(16.h),
          itemCount: list.length,
          itemBuilder: (BuildContext ctx, index) {
            final bool isCountValid =
                countGame[index] == 1 || countGame[index] == 5;
            return Container(
                decoration: AppDecoration.outlineGray
                    .copyWith(borderRadius: BorderRadiusStyle.circleBorder5),
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
                      ),
                      SizedBox(height: 4.v),
                      Divider(height: 1, color: appTheme.gray),
                      SizedBox(height: 4.v),
                      Spacer(),
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
                      Spacer(),
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
                      ),
                    ],
                  ),
                ));
          },
        ),
      ],
    );
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<dynamic> getArticleSelfList() async {
    List<dynamic> list = await supabase
        .from("library")
        .select()
        .eq("type", "self-development")
        .eq('security', 1);

    return list;
  }

  Future<dynamic> getArticleStoryList() async {
    List<dynamic> list = await supabase
        .from("library")
        .select()
        .eq("type", "story")
        .eq('security', 1);

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
                        'Для получения большего числа сведений необходимо иметь Карту доступа ур. 2 и выше');
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
    return Column(
      children: [
        GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 706.h,
            childAspectRatio: 3.92,
            mainAxisSpacing: 15.h,
          ),
          shrinkWrap: true,
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
                        Spacer(),
                        Text(
                          list[index]["title"],
                          style: CustomTextStyles.semiBold18Text,
                        ),
                        Spacer(),
                        Text(
                          'На прочтение: ${list[index]["time_read"]} минут',
                          style: CustomTextStyles.regular16Text,
                        ),
                        Spacer(),
                      ],
                    ),
                    Spacer(),
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
                    builder: (context) => Article(title: list[index]["title"]),
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
      ],
    );
  }
}
