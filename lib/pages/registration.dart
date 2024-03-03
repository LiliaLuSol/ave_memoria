import 'package:ave_memoria/blocs/Auth/bloc/authentication_bloc.dart';
import 'package:ave_memoria/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration>
    with SingleTickerProviderStateMixin {
  final emailFocusNode = FocusNode();
  final inputfieldoneFocusNode = FocusNode();
  final inputfieldFocusNode = FocusNode();

  late TextEditingController _emailcontroller;
  late TextEditingController _passcontroller;
  late TextEditingController _confirmpasscontroller;
  final _formkey = GlobalKey<FormState>();
  late AnimationController _controller;

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isConfirmPasswordValid = false;

  @override
  void initState() {
    _emailcontroller = TextEditingController();
    _passcontroller = TextEditingController();
    _confirmpasscontroller = TextEditingController();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000))
      ..forward();

    super.initState();
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passcontroller = TextEditingController();
    _confirmpasscontroller = TextEditingController();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc blocProvider =
        BlocProvider.of<AuthenticationBloc>(context);
    mediaQueryData = MediaQuery.of(context);
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
                          // GoRouter.of(context).push(AppRoutes.authReg);
                        })),
                body: Container(
                    width: mediaQueryData.size.width,
                    height: mediaQueryData.size.height,
                    child: Form(
                        key: _formkey,
                        child: Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(
                                horizontal: 18.h, vertical: 30.v),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 34.v),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(left: 4.h, top: 13.v),
                                      child: Text("Регистрация",
                                          style:
                                              theme.textTheme.headlineLarge)),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(left: 4.h, top: 32.v),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Введите ваш email",
                                                style:
                                                    theme.textTheme.bodyMedium),
                                            SizedBox(height: 4.v),
                                            CustomTextFormField(
                                              controller: _emailcontroller,
                                              focusNode: emailFocusNode,
                                              autofocus: false,
                                              textStyle: const TextStyle(
                                                  color: Colors.black),
                                              hintText: "example@gmail.com",
                                              textInputType:
                                                  TextInputType.emailAddress,
                                              validator: (value) {
                                                return !Validators.isValidEmail(
                                                        value!)
                                                    ? "Введите действительный Email"
                                                    : null;
                                              },
                                              onChanged: (value) {
                                                setState(() {
                                                  isEmailValid =
                                                      Validators.isValidEmail(
                                                          value);
                                                });
                                              },
                                            )
                                          ])),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(left: 4.h, top: 22.v),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Придумайте пароль",
                                                style:
                                                    theme.textTheme.bodyMedium),
                                            SizedBox(height: 3.v),
                                            BlocBuilder<AuthenticationBloc,
                                                    AuthenticationState>(
                                                builder: (context, state) {
                                              return CustomTextFormField(
                                                controller: _passcontroller,
                                                focusNode:
                                                    inputfieldoneFocusNode,
                                                autofocus: false,
                                                textStyle: const TextStyle(
                                                    color: Colors.black),
                                                textInputAction:
                                                    TextInputAction.done,
                                                hintText: "Password",
                                                onChanged: (value) {
                                                  setState(() {
                                                    isPasswordValid =
                                                        value.length >= 6;
                                                  });
                                                },
                                                suffix: InkWell(
                                                    onTap: () {
                                                      context
                                                          .read<
                                                              AuthenticationBloc>()
                                                          .add(ChangePasswordVisibilityEvent(
                                                              value: !state
                                                                  .isShowPassword));
                                                    },
                                                    child: Container(
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                30.h,
                                                                21.v,
                                                                18.h,
                                                                22.v),
                                                        child: CustomImageView(
                                                          svgPath: state
                                                                  .isShowPassword
                                                              ? ImageConstant
                                                                  .imgEye
                                                              : ImageConstant
                                                                  .imgEye,
                                                        ))),
                                                suffixConstraints:
                                                    BoxConstraints(
                                                        maxHeight: 56.v),
                                                obscureText:
                                                    state.isShowPassword,
                                                validator: (value) {
                                                  return value!.length < 6
                                                      ? "Придумайте пароль не менее 6 символов"
                                                      : null;
                                                },
                                              );
                                            })
                                          ])),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(left: 4.h, top: 22.v),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Повторите пароль",
                                                style:
                                                    theme.textTheme.bodyMedium),
                                            SizedBox(height: 3.v),
                                            BlocBuilder<AuthenticationBloc,
                                                    AuthenticationState>(
                                                builder: (context, state) {
                                              return CustomTextFormField(
                                                controller:
                                                    _confirmpasscontroller,
                                                focusNode: inputfieldFocusNode,
                                                autofocus: false,
                                                textStyle: const TextStyle(
                                                    color: Colors.black),
                                                textInputAction:
                                                    TextInputAction.done,
                                                hintText: "Password",
                                                onChanged: (value) {
                                                  setState(() {
                                                    isConfirmPasswordValid =
                                                        value.length >= 6 &&
                                                            value ==
                                                                _passcontroller
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
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                30.h,
                                                                21.v,
                                                                18.h,
                                                                22.v),
                                                        child: CustomImageView(
                                                          svgPath: state
                                                                  .isShowPassword1
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
                                                              _passcontroller
                                                                  .text
                                                          ? "Пароли не совпадают"
                                                          : null;
                                                },
                                              );
                                            })
                                          ])),
                                  BlocSelector<AuthenticationBloc,
                                          AuthenticationState, bool?>(
                                      selector: (state) => state.wantNewsInfo,
                                      builder: (context, wantNewsInfo) {
                                        return CustomCheckboxButton(
                                            text:
                                                "Хочу получать информацию о новостях и акциях",
                                            isExpandedText: true,
                                            value: wantNewsInfo,
                                            checkColor:
                                                theme.colorScheme.primary,
                                            margin: EdgeInsets.only(
                                                left: 4.h,
                                                top: 33.v,
                                                right: 28.h),
                                            onChange: (value) {
                                              context
                                                  .read<AuthenticationBloc>()
                                                  .add(ChangeCheckBoxEvent(
                                                      value: value));
                                            });
                                      }),
                                  Spacer(),
                                  BlocBuilder<AuthenticationBloc,
                                          AuthenticationState>(
                                      builder: (context, state) {
                                    return CustomElevatedButton(
                                      text: "Создать аккаунт",
                                      margin:
                                          EdgeInsets.only(left: 3.h, top: 27.v),
                                      // buttonStyle: isEmailValid &&
                                      //         isPasswordValid &&
                                      //         isConfirmPasswordValid
                                      //     ? ElevatedButton.styleFrom(
                                      //         backgroundColor:
                                      //             theme.colorScheme.primary,
                                      //       )
                                      //     : CustomButtonStyles.fillGray,
                                      onTap: isEmailValid &&
                                              isPasswordValid &&
                                              isConfirmPasswordValid
                                          ? () {
                                              BlocProvider.of<
                                                          AuthenticationBloc>(
                                                      context)
                                                  .add(
                                                EmailSignUpAuthEvent(
                                                    _emailcontroller.text,
                                                    _passcontroller.text),
                                              );
                                              // GoRouter.of(context)
                                              //     .push(AppRoutes.homepage);
                                            }
                                          : null,
                                    );
                                  }),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 3.h, top: 19.4.v),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Padding(
                                            //     padding: EdgeInsets.only(
                                            //         bottom: 10.v),
                                            //     child: SizedBox(
                                            //         width: 80.h,
                                            //         child: Divider(
                                            //             thickness: 0.7,
                                            //             color: appTheme
                                            //                 .whiteP70))),
                                            // Text("Или войдите с помощью",
                                            //     style: CustomTextStyles
                                            //         .bodyMediumWhite),
                                            // Padding(
                                            //     padding: EdgeInsets.only(
                                            //         bottom: 10.v),
                                            //     child: SizedBox(
                                            //         width: 80.h,
                                            //         child: Divider(
                                            //             thickness: 0.7,
                                            //             color:
                                            //                 appTheme.whiteP70)))
                                          ])),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 4.h, top: 20.v, right: 5.h),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomIconButton(
                                              height: 56.v,
                                              width: 108.h,
                                              padding: EdgeInsets.only(
                                                  top: 12.h,
                                                  bottom: 12.h,
                                                  left: 42.h,
                                                  right: 42.h),
                                              decoration: IconButtonStyleHelper
                                                  .fillWhiteA,
                                              onTap: () {
                                                context.showsnackbar(
                                                    title: 'Скоро будет!',
                                                    color: Colors.grey);
                                              },
                                              child: CustomImageView(
                                                svgPath: ImageConstant
                                                    .imgBrandicoyandexrect,
                                              ),
                                            ),
                                            CustomIconButton(
                                              height: 56.v,
                                              width: 108.h,
                                              padding: EdgeInsets.only(
                                                  top: 12.h,
                                                  bottom: 12.h,
                                                  left: 42.h,
                                                  right: 42.h),
                                              decoration: IconButtonStyleHelper
                                                  .fillWhiteA,
                                              onTap: () {
                                                blocProvider.add(
                                                    const GoogleAuthEvent());
                                                context.showsnackbar(
                                                    title:
                                                        'Что-то пошло не так!');
                                              },
                                              child: CustomImageView(
                                                svgPath: ImageConstant
                                                    .imgCevicongoogle,
                                              ),
                                            ),
                                            CustomIconButton(
                                                height: 56.v,
                                                width: 108.h,
                                                padding: EdgeInsets.only(
                                                    top: 9.h,
                                                    bottom: 9.h,
                                                    left: 42.h,
                                                    right: 42.h),
                                                decoration:
                                                    IconButtonStyleHelper
                                                        .fillWhiteA,
                                                onTap: () {
                                                  context.showsnackbar(
                                                      title: 'Скоро будет!',
                                                      color: Colors.grey);
                                                },
                                                child: CustomImageView(
                                                  svgPath:
                                                      ImageConstant.imgUilvk,
                                                ))
                                          ])),
                                  SizedBox(height: 33.v),
                                  Align(
                                      alignment: Alignment.center,
                                      child: GestureDetector(
                                          onTap: () {
                                            // GoRouter.of(context)
                                            //     .push(AppRoutes.authorization);
                                          },
                                          child: RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text: "Уже есть аккаунт?",
                                                    style: theme
                                                        .textTheme.bodyMedium),
                                                const TextSpan(text: "  "),
                                                // TextSpan(
                                                //     text: "Войти",
                                                //     style: CustomTextStyles
                                                //         .bodyMediumPrimary)
                                              ]),
                                              textAlign: TextAlign.left)))
                                ])))))));
  }
}
