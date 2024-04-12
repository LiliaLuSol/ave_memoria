import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

import '../blocs/Auth/bloc/authentication_bloc.dart';
import '../utils/validator.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  late TextEditingController _passwordcontroller;
  late TextEditingController _confirmpasscontroller;
  final _formKey = GlobalKey<FormState>();

  final inputfieldoneFocusNode = FocusNode();
  final inputfieldFocusNode = FocusNode();

  bool isPasswordValid = false;
  bool isConfirmPasswordValid = false;

  @override
  void initState() {
    _passwordcontroller = TextEditingController();
    _confirmpasscontroller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _passwordcontroller.dispose();
    _confirmpasscontroller = TextEditingController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: false,
            appBar: CustomAppBar(
                height: 45.v,
                leadingWidth: double.maxFinite,
                leading: AppbarIconbutton1(
                    svgPath: ImageConstant.imgArrowleft,
                    margin: EdgeInsets.only(left: 20.h, right: 333.h),
                    onTap: () {
                      Navigator.pop(context);
                    })),
            body: Container(
                width: mediaQueryData.size.width,
                height: mediaQueryData.size.height,
                child: Form(
                    key: _formKey,
                    child: Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.h, vertical: 30.v),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 34.v),
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: 4.h, top: 13.v),
                                  child: Text("Восстановление пароля",
                                      style: CustomTextStyles.bold30Text)),
                              Padding(
                                padding: EdgeInsets.only(left: 4.h, top: 30.v),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Введите ваш новый пароль",
                                        style: theme.textTheme.bodyMedium),
                                    SizedBox(height: 4.v),
                                    BlocBuilder<AuthenticationBloc,
                                            AuthenticationState>(
                                        builder: (context, state) {
                                      return CustomTextFormField(
                                        controller: _passwordcontroller,
                                        focusNode: inputfieldoneFocusNode,
                                        autofocus: false,
                                        textInputAction: TextInputAction.done,
                                        hintText: "Password",
                                        onChanged: (value) {
                                          setState(() {
                                            isPasswordValid = value.length >= 6;
                                          });
                                        },
                                        suffix: InkWell(
                                            onTap: () {
                                              context
                                                  .read<AuthenticationBloc>()
                                                  .add(
                                                      ChangePasswordVisibilityEvent(
                                                          value: !state
                                                              .isShowPassword));
                                            },
                                            child: Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    30.h, 21.v, 18.h, 22.v),
                                                child: CustomImageView(
                                                  svgPath: state.isShowPassword
                                                      ? ImageConstant.imgEye
                                                      : ImageConstant.imgEye,
                                                ))),
                                        suffixConstraints:
                                            BoxConstraints(maxHeight: 56.v),
                                        obscureText: state.isShowPassword,
                                        validator: (value) {
                                          return value!.length < 6
                                              ? "Введите действительный пароль"
                                              : null;
                                        },
                                      );
                                    }),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.h, top: 22.v),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Повторите новый пароль",
                                                  style: theme
                                                      .textTheme.bodyMedium),
                                              SizedBox(height: 3.v),
                                              BlocBuilder<AuthenticationBloc,
                                                      AuthenticationState>(
                                                  builder: (context, state) {
                                                return CustomTextFormField(
                                                  controller:
                                                      _confirmpasscontroller,
                                                  focusNode:
                                                      inputfieldFocusNode,
                                                  autofocus: false,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  hintText: "Password",
                                                  onChanged: (value) {
                                                    setState(() {
                                                      isConfirmPasswordValid =
                                                          value.length >= 6 &&
                                                              value ==
                                                                  _passwordcontroller
                                                                      .text;
                                                    });
                                                  },
                                                  suffix: InkWell(
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                AuthenticationBloc>()
                                                            .add(ChangePassword1VisibilityEvent(
                                                                value: !state
                                                                    .isShowPassword1));
                                                      },
                                                      child: Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  30.h,
                                                                  21.v,
                                                                  18.h,
                                                                  22.v),
                                                          child:
                                                              CustomImageView(
                                                            svgPath: state.isShowPassword1
                                                                ? ImageConstant
                                                                    .imgEye
                                                                : ImageConstant
                                                                    .imgEye,
                                                          ))),
                                                  suffixConstraints:
                                                      BoxConstraints(
                                                          maxHeight: 56.v),
                                                  obscureText:
                                                      state.isShowPassword1,
                                                  validator: (value) {
                                                    return value!.length < 6
                                                        ? "Введите действительный пароль"
                                                        : value !=
                                                                _passwordcontroller
                                                                    .text
                                                            ? "Пароли не совпадают"
                                                            : null;
                                                  },
                                                );
                                              })
                                            ])),
                                    SizedBox(height: 305.v),
                                    BlocListener<AuthenticationBloc,
                                            AuthenticationState>(
                                        listener: (context, state) async {
                                      if (state is AuthSuccessState) {
                                        print(2);
                                        await AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.success,
                                          animType: AnimType.topSlide,
                                          title: 'Успех!',
                                          titleTextStyle:
                                              CustomTextStyles.semiBold32Text,
                                          desc: 'Пароль успешно восстановлен',
                                          descTextStyle:
                                              CustomTextStyles.regular16Text,
                                        ).show().then((value) {
                                          GoRouter.of(context).push(AppRoutes.authorization);
                                        });
                                      } else if (state is AuthErrorState) {
                                        context.showsnackbar(
                                            title:
                                                'Что-то пошло не так! Повторите попытку позже');
                                      }
                                    }, child: BlocBuilder<AuthenticationBloc,
                                                AuthenticationState>(
                                            builder: (context, state) {
                                      if (state is AuthLoadingState) {
                                        return Center(
                                            child: CircularProgressIndicator(
                                          color: theme.colorScheme.primary,
                                        ));
                                      } else {
                                        return CustomElevatedButton(
                                            text: "Восстановить",
                                            buttonTextStyle: CustomTextStyles
                                                .semiBold18TextWhite,
                                            margin: EdgeInsets.only(left: 2.h),
                                            buttonStyle: isPasswordValid &&
                                                isConfirmPasswordValid
                                                ? ElevatedButton.styleFrom(
                                                    backgroundColor: theme
                                                        .colorScheme.primary,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)))
                                                : ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        appTheme.gray,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5))),
                                            onTap: () {
                                              isPasswordValid &&
                                                  isConfirmPasswordValid
                                                  ? () {
                                                print("1.1");
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        try {
                                                          BlocProvider.of<AuthenticationBloc>(context).add(
                                                            UpdateUserPasswordEvent(
                                                                _passwordcontroller
                                                                    .text),
                                                          );
                                                          print("1");
                                                        } catch (e) {
                                                          print(e);
                                                        }
                                                      }
                                                      ;
                                                    }
                                                  : null;
                                            });
                                      }
                                    })),
                                  ],
                                ),
                              )
                            ]))))),
      ),
    );
  }
}
