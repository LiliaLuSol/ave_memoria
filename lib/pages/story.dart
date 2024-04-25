import 'package:ave_memoria/blocs/Auth/bloc/authentication_bloc.dart';
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
  late List<dynamic> moneyList;

  @override
  void initState() {
    moneyList = [];
    getMoney();
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
          if (has_internet() != ConnectivityResult.none) {
            context.showsnackbar(title: 'Что-то пошло не так!');
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
                      child: Text("Сюжет",
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
                    SizedBox(
                      height: 75.v,
                    ),
                    Divider(height: 1, color: appTheme.gray),
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(left: 16.h, right: 16.h),
                            child: SingleChildScrollView(
                                child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      
                                    ]))))
                  ])))
        ),
      ),
      //  )
    );
  }
}
