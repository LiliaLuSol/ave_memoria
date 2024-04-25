import 'package:ave_memoria/blocs/Auth/bloc/authentication_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';
import 'package:page_view_indicators/page_view_indicators.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  final PageController pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  final List<Widget> pages = [
    OnboardPage(
        title1: "Добро пожаловать в ",
        title2: "AveMemoria",
        title3: "",
        title4: "",
        message:
            "Здесь вы начнете увлекательное путешествие по улучшению своей памяти. Давайте вместе тренировать ваш разум!",
        size: 25.v),
    OnboardPage(
        title1: "Мини-",
        title2: "игры",
        title3: "",
        title4: "",
        message:
            " Играйте в разнообразные игры, созданные для улучшения вашей памяти и концентрации. Разнообразные задачи ждут вас в свободном доступе!",
        size: 70.v),
    OnboardPage(
        title1: "",
        title2: "Сюжетная ",
        title3: "линия",
        title4: "",
        message:
            "Погрузитесь в уникальный сюжет, где улучшение памяти становится захватывающим приключением. Никогда еще не было так интересно развивать свой разум!",
        size: 45.v),
    OnboardPage(
        title1: "Интересные ",
        title2: "советы ",
        title3: "и ",
        title4: "факты",
        message:
            "Каждый день мы предоставляем вам интересные факты и полезные советы, чтобы не только улучшить вашу память, но и обогатить ваш разум.",
        size: 25.v),
    OnboardPage(
        title1: "Успехи с ",
        title2: "авторизацией",
        title3: "",
        title4: "",
        message:
            "Авторизованные пользователи могут отслеживать свой прогресс, анализировать статистику и следить за улучшениями в своей памяти.",
        size: 70.v),
  ];

  int currentPageIndex = 0;
  final String namebuttonC = "Продолжить";
  final String namebuttonF = "Завершить";

  ValueNotifier<String> buttonTextNotifier =
      ValueNotifier<String>("Продолжить");

  String getLabel(int page) {
    if (page == 4) {
      buttonTextNotifier.value = namebuttonF;
    } else {
      buttonTextNotifier.value = namebuttonC;
    }
    return buttonTextNotifier.value;
  }

  Future<dynamic> has_internet() async {
    return await Connectivity().checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthSuccessState) {
            GoRouter.of(context).go(AppRoutes.homepage);
          } else if (state is UnAuthenticatedState) {
            GoRouter.of(context).go(AppRoutes.onboard);
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
            appBar: CustomAppBar(
                height: 45.v,
                leadingWidth: double.maxFinite,
                leading: Row(children: [
                  SizedBox(width: 20.h),
                  TextButton(
                      onPressed: () => AwesomeDialog(
                            context: context,
                            dialogType: DialogType.info,
                            animType: AnimType.topSlide,
                            title: "Пропустить",
                            titleTextStyle: CustomTextStyles.semiBold32Text,
                            desc:
                                "Вы уверены, что хотите пропустить данный раздел?",
                            descTextStyle: CustomTextStyles.regular16Text,
                            btnCancelText: "Нет",
                            btnCancelOnPress: () {},
                            btnOkText: "Да",
                            btnOkOnPress: () =>
                                GoRouter.of(context).push(AppRoutes.authreg),
                            buttonsTextStyle: CustomTextStyles.regular16White,
                          ).show(),
                      child: Text(
                        "Пропустить",
                        style: CustomTextStyles.semiBold18TextGray,
                      )),
                ])),
            body: Container(
              width: mediaQueryData.size.width,
              height: mediaQueryData.size.height,
              child: Container(
                width: double.maxFinite,
                child: Column(
                  children: [
                    Spacer(flex: 1),
                    Expanded(
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: pages.length,
                        itemBuilder: (context, index) {
                          return pages[index];
                        },
                        onPageChanged: (int page) {
                          _currentPageNotifier.value = page;
                          currentPageIndex = page;
                          getLabel(page);
                        },
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      right: 0.0,
                      bottom: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CirclePageIndicator(
                          itemCount: pages.length,
                          currentPageNotifier: _currentPageNotifier,
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.h,
                        ),
                        child: ValueListenableBuilder<String>(
                            valueListenable: buttonTextNotifier,
                            builder: (context, label, child) {
                              return CustomElevatedButton(
                                  text: label,
                                  buttonTextStyle:
                                      CustomTextStyles.semiBold18TextWhite,
                                  margin: EdgeInsets.fromLTRB(
                                      5.h, 131.v, 5.h, 131.v),
                                  buttonStyle: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          theme.colorScheme.primary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                  onTap: () {
                                    if (getLabel(currentPageIndex) ==
                                        namebuttonC) {
                                      if (currentPageIndex < pages.length - 1) {
                                        pageController.animateToPage(
                                            currentPageIndex + 1,
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.ease);
                                      }
                                    } else {
                                      GoRouter.of(context)
                                          .push(AppRoutes.authreg);
                                    }
                                  });
                            })),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class OnboardPage extends StatelessWidget {
  final String title1;
  final String title2;
  final String title3;
  final String title4;
  final String message;
  final double size;

  OnboardPage(
      {required this.title1,
      required this.title2,
      required this.title3,
      required this.title4,
      required this.message,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 336.h,
          margin: EdgeInsets.only(
            left: 10.h,
            right: 10.h,
          ),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: title1,
                  style: CustomTextStyles.semiBold32Text,
                ),
                TextSpan(
                  text: title2,
                  style: CustomTextStyles.semiBold32Primary,
                ),
                TextSpan(
                  text: title3,
                  style: CustomTextStyles.semiBold32Text,
                ),
                TextSpan(
                  text: title4,
                  style: CustomTextStyles.semiBold32Primary,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: 353.h,
          margin: EdgeInsets.only(
            left: 5.h,
            top: size,
            right: 5.h,
          ),
          child: Text(
            message,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: CustomTextStyles.semiBold18Text,
          ),
        ),
      ],
    );
  }
}
