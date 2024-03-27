import 'package:ave_memoria/blocs/Auth/bloc/authentication_bloc.dart';

import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> with TickerProviderStateMixin {
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
                      child: Text("Статистика",
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
              child: Column(
                children: [
                  SizedBox(height: 75.v),
                  Divider(height: 1, color: appTheme.gray),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.h),
                          child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                SizedBox(height: 14.v),
                                Text("Очки за неделю:",
                                    style: CustomTextStyles.regular16Text),
                                SizedBox(height: 14.v),
                                Row(children: [
                                  day_score("пн", 0),
                                  SizedBox(width: 8.h),
                                  day_score("пн", 0),
                                  SizedBox(width: 8.h),
                                  day_score("вт", 0),
                                  SizedBox(width: 8.h),
                                  day_score("ср", 134),
                                  SizedBox(width: 8.h),
                                  day_score("чт", 1886),
                                  SizedBox(width: 8.h),
                                  day_score("пт", 0),
                                  SizedBox(width: 8.h),
                                  day_score("сб", 0),
                                  SizedBox(width: 8.h),
                                  day_score("вс", 0)
                                ]),
                                SizedBox(height: 14.v),
                                Text("Вы занимаетесь уже 5 день(-ей)!",
                                    style: theme.textTheme.bodyMedium),
                              ])))),
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
