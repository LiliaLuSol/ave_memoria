import 'package:ave_memoria/blocs/Auth/bloc/authentication_bloc.dart';

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
  int streakCount = 0;
  int monthlyScore = 0;
  int yearlyScore = 0;
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

  Map<String, int> scores = {
    'пн': 0,
    'вт': 0,
    'ср': 0,
    'чт': 0,
    'пт': 0,
    'сб': 0,
    'вс': 0,
  };
  String currentDay = '';

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    emailAnon = globalData.emailAnon;
    money = globalData.money;
    nameGame1 = globalData.nameGame1_;
    nameGame2 = globalData.nameGame2;
    nameGame3 = globalData.nameGame3;
    quantityGame1 = globalData.countGame1;
    quantityGame2 = globalData.countGame2;
    quantityGame3 = globalData.countGame3;
    best1 = globalData.best1;
    best2 = globalData.best2;
    streakCount = globalData.streakCount;
    getMoney();
    getQuantity();
    mon = globalData.mon;
    tue = globalData.tue;
    wen = globalData.wen;
    thu = globalData.thu;
    fri = globalData.fri;
    sat = globalData.sat;
    sun = globalData.sun;
    fetchMonthlyScore();
    fetchYearlyScore();
    fetchWeeklyScores();
    currentDay = getCurrentDay();
    fetchStreakCount();
    super.initState();
  }

  String getCurrentDay() {
    final now = DateTime.now();
    switch (now.weekday) {
      case DateTime.monday:
        return 'пн';
      case DateTime.tuesday:
        return 'вт';
      case DateTime.wednesday:
        return 'ср';
      case DateTime.thursday:
        return 'чт';
      case DateTime.friday:
        return 'пт';
      case DateTime.saturday:
        return 'сб';
      case DateTime.sunday:
        return 'вс';
      default:
        return '';
    }
  }

  Future<void> fetchWeeklyScores() async {
    final response = await supabase
        .from('Statistics')
        .select('score, date_game')
        .gte('date_game',
            DateTime.now().subtract(const Duration(days: 7)).toIso8601String())
        .lte('date_game', DateTime.now().toIso8601String())
        .eq('user_id', globalData.user_id)
        .count();
    if (response.count != 0) {
      final data = response.data as List;
      Map<String, int> tempScores = {
        'пн': 0,
        'вт': 0,
        'ср': 0,
        'чт': 0,
        'пт': 0,
        'сб': 0,
        'вс': 0,
      };

      for (var entry in data) {
        DateTime date = DateTime.parse(entry['date_game']);
        String day = getCurrentDayForDate(date);

        if (tempScores.containsKey(day)) {
          tempScores[day] = entry['score'];
        }
      }

      setState(() {
        scores = tempScores;
        mon = scores['пн']!;
        tue = scores['вт']!;
        wen = scores['ср']!;
        thu = scores['чт']!;
        fri = scores['пт']!;
        sat = scores['сб']!;
        sun = scores['вс']!;
      });
    }
  }

  String getCurrentDayForDate(DateTime date) {
    switch (date.weekday) {
      case DateTime.monday:
        return 'пн';
      case DateTime.tuesday:
        return 'вт';
      case DateTime.wednesday:
        return 'ср';
      case DateTime.thursday:
        return 'чт';
      case DateTime.friday:
        return 'пт';
      case DateTime.saturday:
        return 'сб';
      case DateTime.sunday:
        return 'вс';
      default:
        return '';
    }
  }

  Future<void> fetchStreakCount() async {
    final response = await supabase
        .from('Statistics')
        .select('date_game')
        .order('date_game', ascending: true)
        .count();

    final data = response.data as List;
    List<DateTime> playDates =
        data.map((entry) => DateTime.parse(entry['date_game'])).toList();

    setState(() {
      streakCount = calculateStreak(playDates);
    });
  }

  int calculateStreak(List<DateTime> dates) {
    if (dates.isEmpty) return 0;

    int streak = 1;
    for (int i = 1; i < dates.length; i++) {
      final difference = dates[i].difference(dates[i - 1]).inDays;
      if (difference == 1) {
        streak++;
      } else if (difference > 1) {
        streak = 1;
      }
    }
    return streak;
  }

  Future<void> fetchMonthlyScore() async {
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    DateTime firstDayOfNextMonth = DateTime(now.year, now.month + 1, 1);

    final response = await supabase
        .from('Statistics')
        .select('score')
        .eq('user_id', globalData.user_id)
        .gte('date_game', firstDayOfMonth.toIso8601String())
        .lt('date_game', firstDayOfNextMonth.toIso8601String())
        .count();

    final data = response.data as List;
    int totalScore = data.fold(0, (sum, entry) => sum + entry['score'] as int);

    setState(() {
      monthlyScore = totalScore;
    });
  }

  Future<void> fetchYearlyScore() async {
    DateTime now = DateTime.now();
    DateTime firstDayOfYear = DateTime(now.year, 1, 1);
    DateTime firstDayOfNextYear = DateTime(now.year + 1, 1, 1);

    final response = await supabase
        .from('Statistics')
        .select('score')
        .eq('user_id', globalData.user_id)
        .gte('date_game', firstDayOfYear.toIso8601String())
        .lt('date_game', firstDayOfNextYear.toIso8601String())
        .count();

    final data = response.data as List;
    int totalScore = data.fold(0, (sum, entry) => sum + entry['score'] as int);

    setState(() {
      yearlyScore = totalScore;
    });
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
                  const Spacer(),
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
          body: SizedBox(
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
                                      day_score("пн", mon, currentDay == 'пн'),
                                      const SizedBox(width: 8),
                                      day_score("вт", tue, currentDay == 'вт'),
                                      const SizedBox(width: 8),
                                      day_score("ср", wen, currentDay == 'ср'),
                                      const SizedBox(width: 8),
                                      day_score("чт", thu, currentDay == 'чт'),
                                      const SizedBox(width: 8),
                                      day_score("пт", fri, currentDay == 'пт'),
                                      const SizedBox(width: 8),
                                      day_score("сб", sat, currentDay == 'сб'),
                                      const SizedBox(width: 8),
                                      day_score("вс", sun, currentDay == 'вс')
                                    ]),
                                    SizedBox(height: 14.v),
                                    Text(
                                        "Вы занимаетесь уже $streakCount день(-ей) подряд!",
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
                                                            '$monthlyScore оч.',
                                                            style: CustomTextStyles
                                                                .extraBold20Text)),
                                                    Center(
                                                        child: Text(
                                                            '$yearlyScore оч.',
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
                                        const Spacer(),
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
                                      const Spacer(),
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
                                      const Spacer(),
                                      Text("$quantityGame2 раз",
                                          style:
                                              CustomTextStyles.extraBold16Text),
                                    ]),
                                    SizedBox(height: 9.v),
                                    Row(children: [
                                      Text(nameGame3,
                                          style:
                                              CustomTextStyles.extraBold16Text),
                                      const Spacer(),
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
