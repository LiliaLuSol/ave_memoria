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
  final _namecontroller = TextEditingController();
  final nameFocusNode = FocusNode();

  bool isNameValid = false;
  bool isSelectedSwitch = false;

  TimeOfDay selectedTime = TimeOfDay.now();

  String? getEmail() {
    final currentUser = supabase.auth.currentUser;
    if (currentUser != null) {
      final email = currentUser.email!;
      return email;
    } else {
      return "Ваш email скоро здесь появится...";
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
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
                                            "Имя воплощения",
                                            style: theme.textTheme.bodyMedium,
                                          ),
                                          SizedBox(height: 4.v),
                                          CustomTextFormField(
                                            controller: _namecontroller,
                                            focusNode: nameFocusNode,
                                            autofocus: false,
                                            hintText: "Игрок",
                                            textInputType: TextInputType.text,
                                            validator: (value) {
                                              return value!.length < 1 &&
                                                      value!.length > 16
                                                  ? "Длина имени от 1 до 16 символов"
                                                  : null;
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                isNameValid =
                                                    value.length >= 1 &&
                                                        value.length <= 16;
                                              });
                                            },
                                          ),
                                          SizedBox(height: 16.v),
                                          Text(
                                            "Email",
                                            style: theme.textTheme.bodyMedium,
                                          ),
                                          SizedBox(height: 4.v),
                                          CustomTextFormField(
                                            controller: _emailcontroller,
                                            focusNode: emailFocusNode,
                                            autofocus: false,
                                            hintText: getEmail(),
                                            textInputType:
                                                TextInputType.emailAddress,
                                            enableInteractiveSelection: false,
                                            enabled: false,
                                          ),
                                          SizedBox(height: 16.v),
                                          GestureDetector(
                                              onTap: () {
                                                GoRouter.of(context)
                                                    .push(AppRoutes.support);
                                              },
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 13.h,
                                                      vertical: 15.v),
                                                  decoration: AppDecoration
                                                      .outlineGray
                                                      .copyWith(
                                                          borderRadius:
                                                              BorderRadiusStyle
                                                                  .circleBorder15),
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
                                          GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 13.h,
                                                      vertical: 15.v),
                                                  decoration: AppDecoration
                                                      .outlineGray
                                                      .copyWith(
                                                          borderRadius:
                                                              BorderRadiusStyle
                                                                  .circleBorder15),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("Написать отзыв",
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
                                          Row(children: [
                                            Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 13.h,
                                                    vertical: 15.v),
                                                decoration: AppDecoration
                                                    .outlineGray
                                                    .copyWith(
                                                        borderRadius:
                                                            BorderRadiusStyle
                                                                .circleBorder15),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("Уведомления",
                                                          style: CustomTextStyles
                                                              .regular16Text),
                                                      SizedBox(width: 22.h),
                                                      CustomSwitch(
                                                          height: 15.v,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 2.v),
                                                          value:
                                                              isSelectedSwitch,
                                                          onChange:
                                                              (bool value) {
                                                            setState(() {
                                                              isSelectedSwitch =
                                                                  value;
                                                            });
                                                          })
                                                    ])),
                                            Spacer(),
                                            Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    13.h, 1.v, 0.h, 1.v),
                                                decoration: isSelectedSwitch
                                                    ? AppDecoration.outlineGray
                                                        .copyWith(
                                                            borderRadius:
                                                                BorderRadiusStyle
                                                                    .circleBorder15)
                                                    : AppDecoration
                                                        .outlineLightGray
                                                        .copyWith(
                                                            borderRadius:
                                                                BorderRadiusStyle
                                                                    .circleBorder15),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          "${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}",
                                                          style: isSelectedSwitch
                                                              ? CustomTextStyles
                                                                  .regular16Text
                                                              : CustomTextStyles
                                                                  .regular16LightGray),
                                                      IconButton(
                                                        icon: FaIcon(
                                                          FontAwesomeIcons.gear,
                                                          size: 15.v,
                                                          color: isSelectedSwitch
                                                              ? appTheme.gray
                                                              : appTheme
                                                                  .lightGray,
                                                        ),
                                                        onPressed: () {
                                                          isSelectedSwitch
                                                              ? _selectTime(
                                                                  context)
                                                              : null;
                                                        },
                                                      )
                                                    ])),
                                          ]),
                                          SizedBox(height: 200.v),
                                          CustomElevatedButton(
                                            text: "Выход из аккаунта",
                                            buttonTextStyle: CustomTextStyles
                                                .semiBold18TextWhite,
                                            buttonStyle:
                                                ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        appTheme.gray,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5))),
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
