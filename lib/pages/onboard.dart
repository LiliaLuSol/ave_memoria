import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ave_memoria/other/app_export.dart';
import 'package:ave_memoria/widgets/app_bar/custom_app_bar.dart';
import 'package:page_view_indicators/page_view_indicators.dart';

class Onboard extends StatefulWidget {
  const Onboard({Key? key})
      : super(
          key: key,
        );

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
        message:
            "Здесь вы начнете увлекательное путешествие по улучшению своей памяти. Давайте вместе тренировать ваш разум!",
        size: 38.v),
    OnboardPage(
        title1: "Мини-",
        title2: "игры",
        message:
            " Играйте в разнообразные игры, созданные для улучшения вашей памяти и концентрации. Разнообразные задачи ждут вас в свободном доступе!",
        size: 82.v),
    OnboardPage(
        title1: "Сюжетная ",
        title2: "линия",
        message:
            "Погрузитесь в уникальный сюжет, где улучшение памяти становится захватывающим приключением. Здесь никогда еще не было так интересно развивать свой разум!",
        size: 38.v),
    OnboardPage(
        title1: "Интересные ",
        title2: "советы и факты",
        message:
            "Погрузитесь в мир увлекательных знаний! Каждый день мы предоставляем вам интересные факты и полезные советы, чтобы не только улучшить вашу память, но и обогатить ваш разум.",
        size: 38.v),
    OnboardPage(
        title1: "Успехи с ",
        title2: "авторизацией",
        message:
            "Авторизованные пользователи могут отслеживать свой прогресс, анализировать статистику и следить за улучшениями в своей памяти.",
        size: 82.v),
  ];

  int currentPageIndex = 0;
  final String namebuttonC = "Продолжить";
  final String namebuttonF = "Завершить";

  ValueNotifier<String> buttonTextNotifier =
  ValueNotifier<String>("Продолжить");

  String getLabel(int page) {
    if (page == 2) {
      buttonTextNotifier.value = namebuttonF;
    } else {
      buttonTextNotifier.value = namebuttonC;
    }
    return buttonTextNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<OnboardoneBloc, OnboardoneState>(
    //   builder: (context, state) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 22.h,
            top: 189.v,
            right: 22.h,
          ),
          child: Column(
            children: [
              SizedBox(
                width: 346.h,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Добро пожаловать в ",
                        style: CustomTextStyles.semiBold32Text,
                      ),
                      TextSpan(
                        text: "AveMemoria",
                        style: CustomTextStyles.semiBold32Primary,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 53.v),
              Container(
                width: 327.h,
                margin: EdgeInsets.only(
                  left: 11.h,
                  right: 9.h,
                ),
                child: Text(
                  "Здесь вы начнете увлекательное путешествие по улучшению своей памяти. Давайте вместе тренировать ваш разум!",
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.semiBold18Text,
                ),
              ),
              SizedBox(height: 35.v),
              SizedBox(
                height: 4.v,
                child: AnimatedSmoothIndicator(
                  activeIndex: 0,
                  count: 3,
                  effect: ScrollingDotsEffect(
                    spacing: 3.91,
                    activeDotColor: theme.colorScheme.onPrimary,
                    dotColor: appTheme.gray,
                    dotHeight: 4.v,
                    dotWidth: 3.h,
                  ),
                ),
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
    //   },
    // );
  }
}

class OnboardPage extends StatelessWidget {
  final String title1;
  final String title2;
  final String message;
  final double size;

  OnboardPage(
      {required this.title1,
      required this.title2,
      required this.message,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 336.h,
          margin: EdgeInsets.only(
            left: 12.h,
            right: 11.h,
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
            right: 3.h,
          ),
          child: Text(
            message,
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: CustomTextStyles.semiBold18Text,
          ),
        ),
      ],
    );
  }
}
