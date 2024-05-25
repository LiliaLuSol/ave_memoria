import 'package:ave_memoria/other/app_export.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class GameRules extends StatefulWidget {
  final bool firstTimes;
  final String goRoute;
  final int countRule;
  final String text1;
  final String? text2;
  final String? text3;
  final String? image1;
  final String? image2;
  final String? image3;

  const GameRules(
      {super.key,
      required this.goRoute,
      required this.firstTimes,
      required this.countRule,
      required this.text1,
      this.text2,
      this.text3,
      this.image1,
      this.image2,
      this.image3});

  @override
  State<GameRules> createState() => _GameRulesState();
}

class _GameRulesState extends State<GameRules> {
  GlobalData globalData = GlobalData();
  final PageController pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      RulePage(text: widget.text1, image: globalData.image1),
    ];
    if (widget.text2 != null) {
      pages.add(RulePage(text: widget.text2!, image: globalData.image2));
    }
    if (widget.text3 != null) {
      pages.add(RulePage(text: widget.text3!, image: globalData.image3));
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    _currentPageNotifier.dispose();
    super.dispose();
  }

  int currentPageIndex = 0;
  final String namebuttonC = "Продолжить";
  final String namebuttonF = "Завершить";

  ValueNotifier<String> buttonTextNotifier =
      ValueNotifier<String>("Продолжить");

  String getLabel(int page) {
    if (page == pages.length - 1) {
      buttonTextNotifier.value = namebuttonF;
    } else {
      buttonTextNotifier.value = namebuttonC;
    }
    return buttonTextNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    print(
        '${globalData.image1} image1: ${widget.image1}\ntext1: ${widget.text1}');
    return SafeArea(
        child: Scaffold(
            backgroundColor: widget.firstTimes
                ? const Color(0xFFC0C0C0)
                : Colors.transparent,
            body: Center(
                child: Container(
                    width: 353.h,
                    height: 654.v,
                    decoration: AppDecoration.outlineGray.copyWith(
                        borderRadius: BorderRadiusStyle.circleBorder15),
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.h),
                        child: Column(children: [
                          SizedBox(height: 10.v),
                          Row(children: [
                            SizedBox(width: 25.h),
                            const Spacer(),
                            Text("Правила",
                                style: CustomTextStyles.extraBold32Text),
                            const Spacer(),
                            IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.circleXmark,
                                size: 25.h,
                                color: theme.colorScheme.primary,
                              ),
                              onPressed: () {
                                widget.firstTimes
                                    ? GoRouter.of(context).push(widget.goRoute)
                                    : Navigator.pop(context);
                              },
                            ),
                          ]),
                          SizedBox(height: 40.v),
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
                          SizedBox(height: 4.v),
                          Positioned(
                            left: 0.0,
                            right: 0.0,
                            bottom: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CirclePageIndicator(
                                itemCount: widget.countRule,
                                currentPageNotifier: _currentPageNotifier,
                              ),
                            ),
                          ),
                          SizedBox(height: 40.v),
                          ValueListenableBuilder<String>(
                              valueListenable: buttonTextNotifier,
                              builder: (context, label, child) {
                                return CustomElevatedButton(
                                    text: label,
                                    buttonTextStyle:
                                        CustomTextStyles.semiBold18TextWhite,
                                    buttonStyle: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            theme.colorScheme.primary,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                    onTap: () {
                                      if (getLabel(currentPageIndex) ==
                                          namebuttonC) {
                                        if (currentPageIndex <
                                            pages.length - 1) {
                                          pageController.animateToPage(
                                              currentPageIndex + 1,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.ease);
                                        }
                                      } else {
                                        widget.firstTimes
                                            ? GoRouter.of(context)
                                                .push(widget.goRoute)
                                            : Navigator.pop(context);
                                      }
                                    });
                              }),
                          SizedBox(height: 25.v)
                        ]))))));
  }
}

class RulePage extends StatelessWidget {
  final String image;
  final String text;

  const RulePage({
    super.key,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (image.isNotEmpty)
          Container(
            height: 205.v,
            width: 260.h,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            )),
          ),
        SizedBox(height: 40.v),
        Text(text,
            style: CustomTextStyles.semiBold18Text,
            maxLines: 6,
            textAlign: TextAlign.center),
      ],
    );
  }
}
