import 'package:ave_memoria/blocs/Auth/bloc/authentication_bloc.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> with TickerProviderStateMixin {
  late final TabController _tabController;
  GlobalData globalData = GlobalData();
  String emailAnon = '';
  late int money;
  late int mon;
  late int tue;
  late int wen;
  late int thu;
  late int fri;
  late int sat;
  late int sun;
  late String nameGame1;
  late String nameGame2;
  late String nameGame3;
  late int quantityGame1;
  late int quantityGame2;
  late int quantityGame3;
  late int best1;
  late int best2;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    emailAnon = globalData.emailAnon;
    money = globalData.money;
    nameGame1 = globalData.nameGame1_;
    nameGame2 = globalData.nameGame2;
    nameGame3 = globalData.nameGame3;
    quantityGame1 =globalData.countGame1;
    quantityGame2 =globalData.countGame2;
    quantityGame3 =globalData.countGame3;
    best1 = globalData.best1;
    best2 = globalData.best2;
    getMoney();
    getQuantity();
    mon = globalData.mon;
    tue = globalData.tue;
    wen = globalData.wen;
    thu = globalData.thu;
    fri = globalData.fri;
    sat = globalData.sat;
    sun = globalData.sun;
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

  void getDayScore() async {
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
      quantityGame1 = data1[0]['quantity'];
      quantityGame2 = data2[0]['quantity'];
      quantityGame3 = data3[0]['quantity'];
    });
  }

  void getBest() async {
    String? email = getEmail();
    email = email.toString();
    final res =
    supabase.from('usergamedata').select('best_score').eq('email', email);
    final data01 = await res.eq('game', 'cards').count(CountOption.exact);
    final data1 = data01.data;
    final data02 = await res.eq('game', 'sequence').count(CountOption.exact);
    final data2 = data02.data;
    setState(() {
      best1 = data1[0]['best_score'];
      best2 = data2[0]['best_score'];
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    //   return SafeArea(
    //       child: Scaffold(
    //     extendBody: true,
    //     extendBodyBehindAppBar: true,
    //     resizeToAvoidBottomInset: false,
    //     body: OfflineBuilder(
    //       connectivityBuilder: (
    //         BuildContext context,
    //         ConnectivityResult connectivity,
    //         Widget child,
    //       ) {
    //         final bool connected = connectivity != ConnectivityResult.none;
    //         return connected ? _StatisticsPage(context) : const BuildNoInternet();
    //       },
    //       child: Center(
    //         child: CircularProgressIndicator(
    //           color: theme.colorScheme.primary,
    //         ),
    //       ),
    //     ),
    //   ));
    // }
    //
    // BlocListener _StatisticsPage(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is UnAuthenticatedState) {
          GoRouter.of(context).pushReplacement(AppRoutes.authreg);
        } else if (state is AuthErrorState) {
          context.showsnackbar(title: 'Что-то пошло не так!');
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
                      child: Text("Статистика",
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
              child: supabase.auth.currentUser?.email == "anounymous@gmail.com"
                  ? Column(children: [
                      SizedBox(height: 75.v),
                      Divider(height: 1, color: appTheme.gray),
                      Expanded(child: lock())
                    ])
                  : Column(
                      children: [
                        SizedBox(height: 75.v),
                        Divider(height: 1, color: appTheme.gray),
                        Expanded(
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.h),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 14.v),
                                    Text("Очки за неделю:",
                                        style:
                                            CustomTextStyles.extraBold20Text),
                                    SizedBox(height: 14.v),
                                    Row(children: [
                                      day_score("пн", mon, false),
                                      SizedBox(width: 8.h),
                                      day_score("вт", tue, false),
                                      SizedBox(width: 8.h),
                                      day_score("ср", wen, false),
                                      SizedBox(width: 8.h),
                                      day_score("чт", thu, false),
                                      SizedBox(width: 8.h),
                                      day_score("пт", fri, true),
                                      SizedBox(width: 8.h),
                                      day_score("сб", sat, false),
                                      SizedBox(width: 8.h),
                                      day_score("вс", sun, false)
                                    ]),
                                    SizedBox(height: 14.v),
                                    Text(
                                        "Вы занимаетесь уже 1 день(-ей) подряд!",
                                        style: theme.textTheme.bodyMedium),
                                    SizedBox(height: 20.v),
                                    Container(
                                        decoration: AppDecoration.outlineGray,
                                        child: Column(children: [
                                          SizedBox(height: 20.v),
                                          Text("Общее число очков за...",
                                              style: CustomTextStyles
                                                  .extraBold20Text),
                                          SizedBox(height: 9.v),
                                          TabBar(
                                              controller: _tabController,
                                              labelPadding: EdgeInsets.zero,
                                              indicatorPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: -15.h),
                                              labelStyle: CustomTextStyles
                                                  .regular16White,
                                              unselectedLabelStyle:
                                                  CustomTextStyles
                                                      .regular16Text,
                                              indicator: BoxDecoration(
                                                color:
                                                    theme.colorScheme.primary,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  50.h,
                                                ),
                                              ),
                                              tabs: const [
                                                Tab(
                                                  child: Text(
                                                    "неделя",
                                                  ),
                                                ),
                                                Tab(
                                                  child: Text(
                                                    "месяц",
                                                  ),
                                                ),
                                                Tab(
                                                  child: Text(
                                                    "год",
                                                  ),
                                                )
                                              ]),
                                          //  Divider(height: 1, color: appTheme.gray),
                                          SizedBox(
                                              height: 75.v,
                                              width: 361.h,
                                              child: TabBarView(
                                                  controller: _tabController,
                                                  children: <Widget>[
                                                    Center(
                                                        child: Text(
                                                            '${mon + tue + wen + thu + fri + sat + sun}'
                                                            ' оч.',
                                                            style: CustomTextStyles
                                                                .extraBold20Text)),
                                                    Center(
                                                        child: Text(
                                                            '${mon + tue + wen + thu + fri + sat + sun} оч.',
                                                            style: CustomTextStyles
                                                                .extraBold20Text)),
                                                    Center(
                                                        child: Text(
                                                            '${mon + tue + wen + thu + fri + sat + sun} оч.',
                                                            style: CustomTextStyles
                                                                .extraBold20Text)),
                                                  ])),
                                        ])),
                                    SizedBox(height: 20.v),
                                    Text("Рекорды за все время:",
                                        style:
                                            CustomTextStyles.extraBold20Text),
                                    SizedBox(height: 9.v),
                                    Row(
                                      children: [
                                        Text(nameGame1,
                                            style: CustomTextStyles
                                                .extraBold16Text),
                                        Spacer(),
                                        Text("$best1 очков",
                                            style: CustomTextStyles
                                                .extraBold16Text),
                                      ],
                                    ),
                                    SizedBox(height: 9.v),
                                    Row(children: [
                                      Text(nameGame2,
                                          style:
                                              CustomTextStyles.extraBold16Text),
                                      Spacer(),
                                      Text("$best2 раунд",
                                          style:
                                              CustomTextStyles.extraBold16Text),
                                    ]),
                                    SizedBox(height: 20.v),
                                    Text(
                                        "Количество сыгранных мини-игр за все время:",
                                        style:
                                            CustomTextStyles.extraBold20Text),
                                    SizedBox(height: 9.v),
                                    Row(
                                      children: [
                                        Text(nameGame1,
                                            style: CustomTextStyles
                                                .extraBold16Text),
                                        Spacer(),
                                        Text("$quantityGame1 раз",
                                            style: CustomTextStyles
                                                .extraBold16Text),
                                      ],
                                    ),
                                    SizedBox(height: 9.v),
                                    Row(children: [
                                      Text(nameGame2,
                                          style:
                                              CustomTextStyles.extraBold16Text),
                                      Spacer(),
                                      Text("$quantityGame2 раз",
                                          style:
                                              CustomTextStyles.extraBold16Text),
                                    ]),
                                    SizedBox(height: 9.v),
                                    Row(children: [
                                      Text(nameGame3,
                                          style:
                                              CustomTextStyles.extraBold16Text),
                                      Spacer(),
                                      Text("$quantityGame3 раз",
                                          style:
                                              CustomTextStyles.extraBold16Text),
                                    ]),
                                    SizedBox(height: 14.v),
                                  ])),
                        )
                      ],
                    ),
            ),
          ),
        ),
      ),
      //  )
    );
  }
}
