import 'dart:async';
import 'dart:io';

import 'package:ave_memoria/blocs/Auth/bloc/authentication_bloc.dart';
import 'package:ave_memoria/main.dart';

import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
  GlobalData globalData = GlobalData();
  final _emailcontroller = TextEditingController();
  final emailFocusNode = FocusNode();
  final nameFocusNode = FocusNode();

  bool _isConnection = false;
  bool isSelectedSwitch = false;
  bool isSelectedSwitch1 = false;
  String emailAnon = '';
  int money = 0;

  TimeOfDay selectedTime = TimeOfDay.now();

  late bool news;
  late bool notification;
  late TextEditingController messageplaceholController;
  final msgFocusNode = FocusNode();

  @override
  void initState() {
    getMoney();
    messageplaceholController = TextEditingController();
    emailAnon = globalData.emailAnon;
    money = globalData.money;
    news = globalData.news;
    notification = globalData.notification;
    _tryConnection();
    getNews();
    getNotification();
    getNotificationTime();
    super.initState();
  }

  @override
  void dispose() {
    messageplaceholController.dispose();
    super.dispose();
  }

  void getNews() async {
    final res = await supabase
        .from('Notifications')
        .select('news')
        .eq('user_id', globalData.user_id)
        .count(CountOption.exact);
    isSelectedSwitch1 = res.data[0]['news'];
  }

  void updateNews(bool status) async {
    await supabase
        .from('Notifications')
        .update({'news': status})
        .eq('user_id', globalData.user_id)
        .count(CountOption.exact);
  }

  void getNotification() async {
    final res = await supabase
        .from('Notifications')
        .select('notification')
        .eq('user_id', globalData.user_id)
        .count(CountOption.exact);
    isSelectedSwitch = res.data[0]['notification'];
  }

  void updateNotification(bool status) async {
    await supabase
        .from('Notifications')
        .update({'notification': status})
        .eq('user_id', globalData.user_id)
        .count(CountOption.exact);
  }

  void getNotificationTime() async {
    final res = await supabase
        .from('Notifications')
        .select('notification_time')
        .eq('user_id', globalData.user_id)
        .count(CountOption.exact);
    final data = res.data;
    if (data[0]['notification_time'] != null) {
      final timeString = data[0]['notification_time'] as String;
      final timeParts = timeString.split(':');
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);
      selectedTime = TimeOfDay(hour: hour, minute: minute);
    }
  }

  void updateNotificationTime(TimeOfDay status) async {
    await supabase
        .from('Notifications')
        .update({
          'notification_time':
              '${status.hour.toString().padLeft(2, '0')}:${status.minute.toString().padLeft(2, '0')}:00'
        })
        .eq('user_id', globalData.user_id)
        .count(CountOption.exact);
  }

  Future<void> _tryConnection() async {
    try {
      final response = await InternetAddress.lookup('www.google.com');
      setState(() {
        _isConnection = response.isNotEmpty;
      });
    } on SocketException catch (e) {
      setState(() {
        _isConnection = false;
      });
    }
  }

  // Future<ConnectivityResult> has_internet() async {
  //   return await Connectivity().checkConnectivity();
  // }

  String? getEmail() {
    final currentUser = supabase.auth.currentUser;
    if (currentUser != null) {
      final email = currentUser.email!;
      return email;
    } else if (_isConnection) {
      return emailAnon;
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

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: theme.colorScheme.primary,
                onSurface: theme.colorScheme.primary,
              ),
            ),
            child: child!);
      },
      initialTime: selectedTime,
      cancelText: 'Отмена',
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
      updateNotificationTime(selectedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    double rating = 3;
    return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is UnAuthenticatedState) {
            GoRouter.of(context).pushReplacement(AppRoutes.authreg);
          } else if (state is AuthErrorState) {
            if (_isConnection) {
              context.showsnackbar(title: 'Что-то пошло не так!');
            }
          }
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
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
                      const Spacer(),
                      if (getEmail() != 'anounymous@gmail.com')
                        Padding(
                            padding: EdgeInsets.only(
                              top: 14.v,
                              bottom: 9.v,
                            ),
                            child: Text(money.toString(),
                                style: CustomTextStyles.semiBold18Text)),
                      if (getEmail() != 'anounymous@gmail.com')
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
              body: SizedBox(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                style:
                                                    theme.textTheme.bodyMedium,
                                              ),
                                              SizedBox(height: 4.v),
                                              CustomTextFormField(
                                                controller: _emailcontroller,
                                                focusNode: emailFocusNode,
                                                autofocus: false,
                                                hintText: getEmail(),
                                                textInputType:
                                                    TextInputType.emailAddress,
                                                enableInteractiveSelection:
                                                    false,
                                                enabled: false,
                                              ),
                                              SizedBox(height: 16.v),
                                              GestureDetector(
                                                  onTap: () {
                                                    GoRouter.of(context).push(
                                                        AppRoutes.support);
                                                  },
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
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
                                                            Text(
                                                                "Обратная связь",
                                                                style: CustomTextStyles
                                                                    .regular16Text),
                                                            CustomImageView(
                                                                svgPath:
                                                                    ImageConstant
                                                                        .imgArrowright,
                                                                height: 15.v,
                                                                width: 9.h,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            2.v,
                                                                        bottom:
                                                                            5.v))
                                                          ]))),
                                              SizedBox(height: 16.v),
                                              GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            backgroundColor: theme
                                                                .colorScheme
                                                                .onPrimaryContainer,
                                                            title: const Text(
                                                                'Оценка',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center),
                                                            titleTextStyle:
                                                                CustomTextStyles
                                                                    .semiBold32Text,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadiusStyle
                                                                        .circleBorder15),
                                                            content: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  StatefulBuilder(
                                                                    builder: (BuildContext
                                                                            context,
                                                                        StateSetter
                                                                            setState) {
                                                                      return RatingBar
                                                                          .builder(
                                                                        initialRating:
                                                                            rating,
                                                                        minRating:
                                                                            1,
                                                                        direction:
                                                                            Axis.horizontal,
                                                                        allowHalfRating:
                                                                            true,
                                                                        itemCount:
                                                                            5,
                                                                        itemPadding:
                                                                            EdgeInsets.symmetric(horizontal: 4.h),
                                                                        itemBuilder: (context, _) => Icon(
                                                                            Icons
                                                                                .star,
                                                                            color:
                                                                                theme.colorScheme.primary),
                                                                        onRatingUpdate:
                                                                            (newRating) {
                                                                          setState(
                                                                              () {
                                                                            rating =
                                                                                newRating;
                                                                          });
                                                                        },
                                                                      );
                                                                    },
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          4.v),
                                                                  Divider(
                                                                      height: 1,
                                                                      color: appTheme
                                                                          .gray),
                                                                  SizedBox(
                                                                      height:
                                                                          4.v),
                                                                  SingleChildScrollView(
                                                                      child: CustomTextFormField(
                                                                          controller:
                                                                              messageplaceholController,
                                                                          focusNode:
                                                                              msgFocusNode,
                                                                          maxLines:
                                                                              5,
                                                                          autofocus:
                                                                              false,
                                                                          hintText:
                                                                              "Отзыв...",
                                                                          borderDecoration: InputBorder
                                                                              .none,
                                                                          textInputAction: TextInputAction
                                                                              .done,
                                                                          fillColor:
                                                                              Colors.transparent)),
                                                                  SizedBox(
                                                                      height:
                                                                          8.v),
                                                                  CustomElevatedButton(
                                                                    text:
                                                                        "Оценить",
                                                                    buttonTextStyle:
                                                                        CustomTextStyles
                                                                            .semiBold18TextWhite,
                                                                    buttonStyle: ElevatedButton.styleFrom(
                                                                        backgroundColor: theme
                                                                            .colorScheme
                                                                            .primary,
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5))),
                                                                    onTap: () {
                                                                      if (_isConnection) {
                                                                        context.showsnackbar(
                                                                            title:
                                                                                'Спасибо за оценку!',
                                                                            color:
                                                                                Colors.grey);
                                                                      } else {
                                                                        context.showsnackbar(
                                                                            title:
                                                                                'Что-то пошло не так!');
                                                                      }
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                ]),
                                                          );
                                                        });
                                                  },
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
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
                                                            Text("Оценить",
                                                                style: CustomTextStyles
                                                                    .regular16Text),
                                                            CustomImageView(
                                                                svgPath:
                                                                    ImageConstant
                                                                        .imgArrowright,
                                                                height: 15.v,
                                                                width: 9.h,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            2.v,
                                                                        bottom:
                                                                            5.v))
                                                          ]))),
                                              SizedBox(height: 16.v),
                                              if (getEmail() !=
                                                  'anounymous@gmail.com')
                                                Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
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
                                                          Text(
                                                              "Получение рассылок",
                                                              style: CustomTextStyles
                                                                  .regular16Text),
                                                          SizedBox(width: 22.h),
                                                          CustomSwitch(
                                                              height: 15.v,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 2.v),
                                                              value:
                                                                  isSelectedSwitch1,
                                                              onChange:
                                                                  (bool value) {
                                                                setState(() {
                                                                  isSelectedSwitch1 =
                                                                      value;
                                                                });
                                                                updateNews(
                                                                    value);
                                                              })
                                                        ])),
                                              SizedBox(height: 16.v),
                                              if (getEmail() !=
                                                  'anounymous@gmail.com')
                                                Row(children: [
                                                  Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
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
                                                            SizedBox(
                                                                width: 22.h),
                                                            CustomSwitch(
                                                                height: 15.v,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top: 2
                                                                            .v),
                                                                value:
                                                                    isSelectedSwitch,
                                                                onChange: (bool
                                                                    value) {
                                                                  setState(() {
                                                                    isSelectedSwitch =
                                                                        value;
                                                                  });
                                                                  updateNotification(
                                                                      value);
                                                                })
                                                          ])),
                                                  const Spacer(),
                                                  Container(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              13.h,
                                                              1.v,
                                                              0.h,
                                                              1.v),
                                                      decoration: isSelectedSwitch
                                                          ? AppDecoration
                                                              .outlineGray
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
                                                                FontAwesomeIcons
                                                                    .gear,
                                                                size: 15.v,
                                                                color: isSelectedSwitch
                                                                    ? appTheme
                                                                        .gray
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
                                              if (getEmail() ==
                                                  'anounymous@gmail.com')
                                                SizedBox(height: 120.v),
                                              // if (has_internet() == ConnectivityResult.none)
                                              //   SizedBox(height: 120.v),
                                              SizedBox(height: 240.v),
                                              CustomElevatedButton(
                                                text: "Выход из аккаунта",
                                                buttonTextStyle:
                                                    CustomTextStyles
                                                        .semiBold18TextWhite,
                                                buttonStyle: ElevatedButton.styleFrom(
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
                                                      .read<
                                                          AuthenticationBloc>()
                                                      .add(
                                                          const SignOutEvent());
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
        ));
  }
}
