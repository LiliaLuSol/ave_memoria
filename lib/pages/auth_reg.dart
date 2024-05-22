import 'package:ave_memoria/theme/theme_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';
import 'package:ave_memoria/widgets/custom_elevated_button.dart';

import '../blocs/Auth/bloc/authentication_bloc.dart';

class AuthReg extends StatefulWidget {
  const AuthReg({super.key});

  @override
  State<AuthReg> createState() => _AuthRegState();
}

class _AuthRegState extends State<AuthReg> {
  GlobalData globalData = GlobalData();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    AuthenticationBloc blocProvider =
        BlocProvider.of<AuthenticationBloc>(context);
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Container(
          width: mediaQueryData.size.width,
          height: mediaQueryData.size.height,
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 180.v),
                Container(
                  width: 346.h,
                  margin: EdgeInsets.only(
                    left: 3.h,
                    top: 23.v,
                    right: 2.h,
                  ),
                  child: Text(
                    "Рекомендуем перед продолжением войти или создать новый аккаунт",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.semiBold18Text,
                  ),
                ),
                Spacer(),
                Text(
                  "AveMemoria",
                  style: CustomTextStyles.semiBold32Primary,
                  textAlign: TextAlign.left,
                ),
                Spacer(),
                CustomElevatedButton(
                  text: "Войти",
                  buttonTextStyle: CustomTextStyles.semiBold18TextWhite,
                  buttonStyle: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onTap: () {
                    globalData.updateAnonStatus(false);
                    GoRouter.of(context).push(AppRoutes.authorization);
                  },
                ),
                SizedBox(height: 36.v),
                CustomElevatedButton(
                  text: "Регистрация",
                  buttonTextStyle: CustomTextStyles.semiBold18TextWhite,
                  buttonStyle: ElevatedButton.styleFrom(
                      backgroundColor: appTheme.gray,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onTap: () {
                    globalData.updateAnonStatus(false);
                    GoRouter.of(context).push(AppRoutes.registration);
                  },
                ),
                SizedBox(height: 36.v),
                BlocListener<AuthenticationBloc, AuthenticationState>(
                    listener: (context, state) {
                  if (state is AuthSuccessState) {
                    GoRouter.of(context).push(AppRoutes.homepage);
                  } else if (state is AuthErrorState) {
                    GoRouter.of(context).push(AppRoutes.homepage);
                  }
                }, child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, state) {
                  if (state is AuthLoadingState) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: theme.colorScheme.primary,
                    ));
                  } else {
                    return CustomElevatedButton(
                      text: "Продолжить без регистрации",
                      buttonTextStyle: CustomTextStyles.semiBold18Text,
                      buttonStyle: ElevatedButton.styleFrom(
                          backgroundColor: appTheme.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          side: BorderSide(width: 1, color: appTheme.gray)),
                      onTap: () {
                        globalData.updateAnonStatus(true);
                        blocProvider.add(const AnounymousAuthEvent());
                        // GoRouter.of(context).push(AppRoutes.homepage);
                      },
                    );
                  }
                })),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
