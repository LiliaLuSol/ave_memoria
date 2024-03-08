import 'package:ave_memoria/blocs/Auth/bloc/authentication_bloc.dart';
import 'package:ave_memoria/main.dart';

import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
  final _emailcontroller = TextEditingController();
  final emailFocusNode = FocusNode();

  String? getEmail() {
    final currentUser = supabase.auth.currentUser;
    if (currentUser != null) {
      final email = currentUser.email!;
      return email;
    } else {
      return "Ваш email скоро здесь появится...";
    }
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
                      child: Text("Профиль",
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
              )),
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
                          padding: EdgeInsets.only(left: 16.h, right: 16.h),
                          child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                      left: 22.h,
                                      top: 22.v,
                                      right: 18.h,
                                    ),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Email",
                                            style: theme.textTheme.bodyMedium,
                                          ),
                                          SizedBox(height: 5.v),
                                          CustomTextFormField(
                                            controller: _emailcontroller,
                                            focusNode: emailFocusNode,
                                            autofocus: false,
                                            textStyle: const TextStyle(
                                                color: Colors.black),
                                            hintText: getEmail(),
                                            textInputType:
                                                TextInputType.emailAddress,
                                            enableInteractiveSelection: false,
                                            enabled: false,
                                          ),
                                          SizedBox(height: 16.v),
                                          GestureDetector(
                                              onTap: () {
                                                // GoRouter.of(context)
                                                //     .push(AppRoutes.support);
                                              },
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 13.h,
                                                      vertical: 15.v),
                                                  // decoration: AppDecoration
                                                  //     .fillOnPrimary
                                                  //     .copyWith(
                                                  //         borderRadius:
                                                  //             BorderRadiusStyle
                                                  //                 .roundedBorder15),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("Обратная связь",
                                                            style: CustomTextStyles
                                                                .regular16Text),
                                                        CustomImageView(
                                                            svgPath: ImageConstant
                                                                .imgArrowright,
                                                            height: 15.v,
                                                            width: 9.h,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 2.v,
                                                                    bottom:
                                                                        5.v))
                                                      ]))),
                                          SizedBox(height: 16.v),
                                          Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 13.h,
                                                  vertical: 15.v),
                                              // decoration: AppDecoration
                                              //     .fillOnPrimary
                                              //     .copyWith(
                                              //         borderRadius:
                                              //             BorderRadiusStyle
                                              //                 .roundedBorder15),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("Уведомления",
                                                        style: CustomTextStyles
                                                            .regular16Text),
                                                    BlocSelector<
                                                            AuthenticationBloc,
                                                            AuthenticationState,
                                                            bool?>(
                                                        selector: (state) => state
                                                            .isSelectedSwitch,
                                                        builder: (context,
                                                            isSelectedSwitch) {
                                                          return CustomSwitch(
                                                              height: 15.v,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 2.v),
                                                              value:
                                                                  isSelectedSwitch,
                                                              onChange:
                                                                  (value) {
                                                                context
                                                                    .read<
                                                                        AuthenticationBloc>()
                                                                    .add(ChangeSwitchEvent(
                                                                        value:
                                                                            value));
                                                              });
                                                        })
                                                  ])),
                                          SizedBox(height: 290.v),
                                          CustomElevatedButton(
                                            text: "Выход из аккаунта",
                                            // buttonStyle:
                                            //     CustomButtonStyles.fillGray,
                                            onTap: () {
                                              context
                                                  .read<AuthenticationBloc>()
                                                  .add(const SignOutEvent());
                                            },
                                          ),
                                          SizedBox(height: 16.v),
                                        ]))
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
