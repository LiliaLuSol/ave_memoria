import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

import '../blocs/Auth/bloc/authentication_bloc.dart';
import '../utils/validator.dart';
import 'new_password_screen.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  late TextEditingController _emailcontroller;
  final _formKey = GlobalKey<FormState>();

  final emailFocusNode = FocusNode();
  bool isEmailValid = false;

  @override
  void initState() {
    _emailcontroller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
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
                                    Text("Введите ваш email",
                                        style: theme.textTheme.bodyMedium),
                                    SizedBox(height: 4.v),
                                    CustomTextFormField(
                                      controller: _emailcontroller,
                                      focusNode: emailFocusNode,
                                      autofocus: false,
                                      hintText: "example@gmail.com",
                                      textInputType: TextInputType.emailAddress,
                                      validator: (value) {
                                        return !Validators.isValidEmail(value!)
                                            ? "Введите действительный Email"
                                            : null;
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          isEmailValid =
                                              Validators.isValidEmail(value);
                                        });
                                      },
                                    ),
                                    SizedBox(height: 305.v),
                                  BlocListener<AuthenticationBloc, AuthenticationState>(
                                    listener: (context, state) async {
                                      if (state is AuthSuccessState) {
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.info,
                                          animType: AnimType.topSlide,
                                          title: 'Восстановление пароля',
                                          titleTextStyle: CustomTextStyles.semiBold32Text,
                                          desc: 'На Ваш email отправили письмо для продолжения процедуры',
                                          descTextStyle: CustomTextStyles.regular16Text,
                                        ).show();
                                        Future.delayed(Duration(seconds: 8));
                                        GoRouter.of(context).push(AppRoutes.new_password);
                                      } else if (state is AuthErrorState) {
                                        context.showsnackbar(
                                            title: 'Что-то пошло не так! Повторите попытку позже'
                                        );
                                      }
                                    },
                                    child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                                        builder: (context, state) {
                                          if (state is AuthLoadingState) {
                                            return CircularProgressIndicator(
                                              color: theme.colorScheme.primary,
                                            );
                                          } else {
                                            return CustomElevatedButton(
                                              text: "Восстановить",
                                              buttonTextStyle: CustomTextStyles.semiBold18TextWhite,
                                              margin: EdgeInsets.only(left: 2.h),
                                              buttonStyle: isEmailValid
                                                  ? ElevatedButton.styleFrom(
                                                backgroundColor: theme.colorScheme.primary,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                              )
                                                  : ElevatedButton.styleFrom(
                                                backgroundColor: appTheme.gray,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                              ),
                                              onTap: () async {
                                                if (_formKey.currentState!.validate()) {
                                                  try {
                                                    BlocProvider.of<
                                                        AuthenticationBloc>(
                                                        context)
                                                        .add(
                                                      EmailResetPasswordEvent(
                                                          _emailcontroller.text),
                                                    );
                                                  } catch (e) {
                                                    print(e);
                                                  }
                                                }
                                              },
                                            );
                                          }
                                        }
                                    ),
                                  ),
                                    SizedBox(),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.h, top: 48.v),
                                        child: Text(
                                            "После ввода Вашего email, вы получите письмо с дальнейшими инструкциями для восстановления пароля",
                                            style: theme.textTheme.bodyMedium))
                                  ],
                                ),
                              )
                            ]))))),
      ),
    );
  }
}
