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
  late List<dynamic> moneyList;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    moneyList = [];
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
        .eq('email',
        email)
        .count(CountOption.exact);
    final data = res.data;
    setState(() {
      moneyList.add(data[0]['money']);
    });
  }

  @override
  void dispose() {
    moneyList.clear();
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
                        child: Text("Свод",
                            style: CustomTextStyles.extraBold32Text)),
                    Spacer(),
                    if (supabase.auth.currentUser?.email != "anounymous@gmail.com")
                    Padding(
                      padding: EdgeInsets.only(
                        top: 14.v,
                        bottom: 9.v,
                      ),
                      child: Text(
                          moneyList.isNotEmpty
                              ? moneyList.first.toString()
                              : '0',
                          style: CustomTextStyles.semiBold18Text)
                    ),
                    if (supabase.auth.currentUser?.email != "anounymous@gmail.com")
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
                                    "находки",
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
                                Column(children: [
                                  Container(
                                    color: appTheme.lightGray,
                                    width: 353.h,
                                    height: 90.v,
                                  ),
                                  SizedBox(height: 15.v),
                                  Container(
                                    color: appTheme.lightGray,
                                    width: 353.h,
                                    height: 90.v,
                                  ),
                                ]),
                                Container(
                                  color: appTheme.green,
                                  width: 353.h,
                                  height: 90.v,
                                ),
                                Container(
                                  color: appTheme.yellow,
                                  width: 353.h,
                                  height: 90.v,
                                ),
                                Container(
                                  color: appTheme.orange,
                                  width: 353.h,
                                  height: 90.v,
                                ),
                              ])),
                ]),
              ),
            ),
          ),
        ));
  }
}
