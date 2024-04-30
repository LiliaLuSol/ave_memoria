import 'package:ave_memoria/blocs/Auth/bloc/authentication_bloc.dart';
import 'package:ave_memoria/main.dart';

import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    emailAnon = globalData.emailAnon;
    money = globalData.money;
    getMoney();
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
                      ])),
                ]),
              ),
            ),
          ),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar.secondary(
          controller: _tabController,
          labelPadding: EdgeInsets.zero,
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
              Column(children: [
                SizedBox(height: 15.v),
                Container(
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
                              Text('Как работает память',
                                  style: CustomTextStyles.semiBold18Text),
                              Spacer(),
                              Text('На прочтение: 5 минуты',
                                  style: CustomTextStyles.regular16Text),
                              Spacer(),
                            ]),
                        Spacer(),
                        CustomImageView(
                            svgPath: ImageConstant.imgArrowright,
                            height: 15.v,
                            width: 9.h,
                            margin: EdgeInsets.only(top: 2.v, bottom: 5.v)),
                        SizedBox(width: 16.v),
                      ]),
                ),
                SizedBox(height: 15.v),
                Container(
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
                              Text('Советы по развитию памяти',
                                  style: CustomTextStyles.semiBold18Text),
                              Spacer(),
                              Text('На прочтение: 10 минуты',
                                  style: CustomTextStyles.regular16Text),
                              Spacer(),
                            ]),
                        Spacer(),
                        CustomImageView(
                            svgPath: ImageConstant.imgArrowright,
                            height: 15.v,
                            width: 9.h,
                            margin: EdgeInsets.only(top: 2.v, bottom: 5.v)),
                        SizedBox(width: 16.v),
                      ]),
                ),
              ]),
            ],
          ),
        ),
      ],
    );
  }
}
