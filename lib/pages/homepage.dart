import 'dart:core';
import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  late String image1Game1;
  late String image2Game1;
  late String image3Game1;
  late String image1Game2;
  late String image2Game2;
  late String image3Game2;
  late String image1Game3;
  late String image2Game3;
  late String game2Rule1;
  late String game2Rule2;
  late String game2Rule3;
  late String game3Rule1;
  late String game3Rule2;
  late String moneyRule;
  late int user_id;

  late bool gameRulesFirst1;
  late bool gameRulesFirst2;
  late bool gameRulesFirst3;

  Map<String, int> scores = {
    'пн': 0,
    'вт': 0,
    'ср': 0,
    'чт': 0,
    'пт': 0,
    'сб': 0,
    'вс': 0,
  };

  @override
  void initState() {
    gameRulesFirst1 = true;
    gameRulesFirst2 = true;
    gameRulesFirst3 = true;
    emailAnon = globalData.emailAnon;
    money = globalData.money;
    getMoney();
    getFirstRule();
    getBest();
    getQuantity();
    getId();
    checkAndAddDailyEntry();
    fetchWeeklyScores();
    fetchStreakCount();
    getNews();
    getNotification();
    getNotificationTime();
    getSecurity();
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
    image1Game1 = globalData.image1Game1;
    image2Game1 = globalData.image2Game1;
    image3Game1 = globalData.image3Game1;
    image1Game2 = globalData.image1Game2;
    image2Game2 = globalData.image2Game2;
    image3Game2 = globalData.image3Game2;
    image1Game3 = globalData.image1Game3;
    image2Game3 = globalData.image2Game3;
    moneyRule = globalData.moneyRule;
    super.initState();
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

  void getId() async {
    String? email = getEmail();
    email = email.toString();
    final res = await supabase
        .from('profileusergame')
        .select('user_id')
        .eq('email', email)
        .single()
        .count(CountOption.exact);
    final data = res.data;
    setState(() {
      globalData.updateId(data['user_id']);
      user_id = data['user_id'];
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
        globalData.updateDay(DateTime.monday, scores['пн']!);
        globalData.updateDay(DateTime.tuesday, scores['вт']!);
        globalData.updateDay(DateTime.wednesday, scores['ср']!);
        globalData.updateDay(DateTime.thursday, scores['чт']!);
        globalData.updateDay(DateTime.friday, scores['пт']!);
        globalData.updateDay(DateTime.saturday, scores['сб']!);
        globalData.updateDay(DateTime.sunday, scores['вс']!);
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
      globalData.streakCount = calculateStreak(playDates);
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

  Future<void> checkAndAddDailyEntry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String today = DateTime.now().toIso8601String().split('T')[0];

    String? lastCheckIn = prefs.getString('last_check_in');
    if (lastCheckIn == null || lastCheckIn != today) {
      final response = await supabase
          .from('Statistics')
          .select()
          .eq('user_id', globalData.user_id)
          .eq('date_game', today)
          .count();
      if (response.count == 0) {
        await supabase.from('Statistics').insert({
          'user_id': globalData.user_id,
          'date_game': today,
          'score': 0
        }).count();
        await prefs.setString('last_check_in', today);
      }
    }
  }

  void getBest() async {
    String? email = getEmail();
    email = email.toString();
    final res =
        supabase.from('usergamedata').select('best_score').eq('email', email);
    final data01 =
        await res.eq('game', 'cards').single().count(CountOption.exact);
    final data1 = data01.data;
    final data02 =
        await res.eq('game', 'sequence').single().count(CountOption.exact);
    final data2 = data02.data;
    setState(() {
      globalData.updateBest(1, data1['best_score']);
      globalData.updateBest(2, data2['best_score']);
    });
  }

  void getQuantity() async {
    String? email = getEmail();
    email = email.toString();
    final res =
        supabase.from('usergamedata').select('quantity').eq('email', email);
    final data01 =
        await res.eq('game', 'cards').single().count(CountOption.exact);
    final data1 = data01.data;
    final data02 =
        await res.eq('game', 'sequence').single().count(CountOption.exact);
    final data2 = data02.data;
    final data03 =
        await res.eq('game', 'image').single().count(CountOption.exact);
    final data3 = data03.data;
    setState(() {
      globalData.updateCount(1, data1['quantity']);
      globalData.updateCount(2, data2['quantity']);
      globalData.updateCount(3, data3['quantity']);
    });
  }

  void getNews() async {
    final res = await supabase
        .from('Notifications')
        .select('news')
        .eq('user_id', globalData.user_id)
        .single()
        .count(CountOption.exact);
    setState(() {
      globalData.news = res.data['news'];
    });
  }

  void getNotification() async {
    final res = await supabase
        .from('Notifications')
        .select('notification')
        .eq('user_id', globalData.user_id)
        .single()
        .count(CountOption.exact);
    setState(() {
      globalData.notification = res.data['notification'];
    });
  }

  void getNotificationTime() async {
    final res = await supabase
        .from('Notifications')
        .select('notification_time')
        .eq('user_id', globalData.user_id)
        .single()
        .count(CountOption.exact);
    final data = res.data;
    if (data[0]['notification_time'] != null) {
      final timeString = data['notification_time'] as String;
      final timeParts = timeString.split(':');
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);
      globalData.notification_time = TimeOfDay(hour: hour, minute: minute);
    }
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
              styleType: Style.bgFill,
            ),
            body: SizedBox(
                width: mediaQueryData.size.width,
                height: mediaQueryData.size.height,
                child: SizedBox(
                    width: double.maxFinite,
                    child: Column(children: [
                      SizedBox(height: 75.v),
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
                                                      fit: BoxFit.fill))),
                                          Positioned(
                                              top: 10.h,
                                              left: 25.h,
                                              child: Text(nameGame1,
                                                  style: CustomTextStyles
                                                      .bold16Text))
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
                                                                image1:
                                                                    image1Game1,
                                                                image2:
                                                                    image2Game1,
                                                                image3:
                                                                    image3Game1,
                                                              ),
                                                          opaque: false,
                                                          fullscreenDialog:
                                                              true))
                                                }
                                              : GoRouter.of(context)
                                                  .push(AppRoutes.game_cards);
                                          globalData.updateImage(image1Game1,
                                              image2Game1, image3Game1);
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
                                              ))),
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
                                          globalData.updateImage(image1Game2,
                                              image2Game2, image3Game2);
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
                                                      fit: BoxFit.fill))),
                                          Positioned(
                                              top: 10.h,
                                              left: 25.h,
                                              child: Text(nameGame3,
                                                  style: CustomTextStyles
                                                      .bold16Text))
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
                                          globalData.updateImage(
                                              image1Game3, image2Game3, '');
                                        }),
                                    SizedBox(height: 16.v)
                                  ]))))
                    ])))));
  }
}

class MoneyPage extends StatelessWidget {
  String text;

  MoneyPage({
    super.key,
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
                      const Spacer(),
                      Text("Мемы", style: CustomTextStyles.extraBold32Text),
                      const Spacer(),
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
