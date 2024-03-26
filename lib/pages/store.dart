import 'package:ave_memoria/blocs/Auth/bloc/authentication_bloc.dart';
import 'package:ave_memoria/main.dart';

import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

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
                        child: Text("Свод",
                            style: CustomTextStyles.extraBold32Text)),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 14.v,
                        bottom: 9.v,
                      ),
                      child: Text(
                        "0",
                        style: CustomTextStyles.semiBold18Text,
                      ),
                    ),
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
                                    "рынок",
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    "советы",
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
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(left: 16.h, right: 16.h),
                          child: TabBarView(
                              controller: _tabController,
                              children: <Widget>[
                                Container(
                                  color: appTheme.lightGray,
                                  width: 353.h,
                                  height: 90.v,
                                ),
                              ]))),
                ]),
              ),
            ),
          ),
        ));
  }
}
