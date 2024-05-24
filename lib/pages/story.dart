import 'package:ave_memoria/main.dart';
import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Story extends StatefulWidget {
  const Story({super.key});

  @override
  State<Story> createState() => _StoryState();
}

class _StoryState extends State<Story> with TickerProviderStateMixin {
  late Stream<ConnectivityResult> connectivityStream;
  bool isConnected = true;
  GlobalData globalData = GlobalData();
  String emailAnon = '';
  int money = 0;
  int filledStars = 0;

  @override
  void initState() {
    checkInitialConnection();
    emailAnon = globalData.emailAnon;
    money = globalData.money;
    filledStars = 3;
    getMoney();
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
                                if (supabase.auth.currentUser?.email !=
                                    "anounymous@gmail.com")
                                  TextSpan(
                                      text: ". Глава I",
                                      style: CustomTextStyles.extraBold32Text)
                              ]))),
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
            child: supabase.auth.currentUser?.email == "anounymous@gmail.com"
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
                                SizedBox(height: 28.v),
                                story_card(context,
                                    levelText: "Уровень 1",
                                    subText: "Пролог",
                                    svgPath: ImageConstant.imgStoryR,
                                    filledStars: 3),
                                SizedBox(height: 28.v),
                                story_card(context,
                                    levelText: "Уровень 2",
                                    subText: "Первая проблема",
                                    svgPath: ImageConstant.imgStoryL,
                                    filledStars: 2),
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
}
