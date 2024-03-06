import 'dart:async';
import 'package:ave_memoria/theme/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';
import 'package:ave_memoria/main.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
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
              Padding(
                padding: EdgeInsets.only(
                  top: 14.v,
                  bottom: 9.v,
                ),
                child:
                Text(
                  "0",
                  style: CustomTextStyles.semiBold18Text,
                ),
              ),
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.coins,
                  size: 25.h,color: appTheme.yellow,
                ),
                onPressed: () {},
              )
            ],
          ),
          // Padding(
          //     padding: EdgeInsets.only(left: 16.h, right: 16.h),
          //     child: Text("AveMemoria",
          //         style: CustomTextStyles.extraBold32Primary)),
          styleType: Style.bgFill,
        ),
        body: Container(
          width: mediaQueryData.size.width,
          height: mediaQueryData.size.height,
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                SizedBox(
                  height: 75.v,
                ),
                Divider(height: 1, color: appTheme.gray),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.h, 16.v, 16.h, 16.v),
                  child: SizedBox(
                    height: 27.v,
                    width: 359.h,
                    child: TabBar(
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
                        tabs: const [
                          Tab(
                            child: Text(
                              "все",
                            ),
                          ),
                          Tab(
                            child: Text(
                              "память",
                            ),
                          ),
                          Tab(
                            child: Text(
                              "внимание",
                            ),
                          ),
                          Tab(
                            child: Text(
                              "мышление",
                            ),
                          ),
                        ]),
                  ),
                ),
                Divider(height: 1, color: appTheme.gray),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.h, right: 16.h),
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[],
                    ),
                  ),
                ),
                SizedBox(height: 81.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
