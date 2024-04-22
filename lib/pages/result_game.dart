import 'package:ave_memoria/other/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultGame extends StatefulWidget {
  final String nameGame;
  final String goRoute;
  final int? tries;
  final int? score;
  final int? time;
  final int? maxScore;

  const ResultGame(
      {super.key,
      required this.nameGame,
      required this.goRoute,
      this.tries,
      this.score,
      this.time,
      this.maxScore});

  @override
  State<ResultGame> createState() => _ResultGameState();
}

class _ResultGameState extends State<ResultGame> {
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    double percentage = widget.score != null && widget.maxScore != null
        ? widget.score! / widget.maxScore!
        : 0;
    int filledStars = 0;

    if (percentage >= 0.8) {
      filledStars = 3;
    } else if (percentage >= 0.6) {
      filledStars = 2;
    } else if (percentage >= 0.4) {
      filledStars = 1;
    }

    List<Widget> stars = List.generate(3, (index) {
      if (index < filledStars) {
        return Padding(
            padding: EdgeInsets.only(right: 12.h),
            child: Icon(FontAwesomeIcons.solidStar,
                color: theme.colorScheme.primary, size: 50.h));
      } else {
        return Padding(
            padding: EdgeInsets.only(right: 12.h),
            child: Icon(FontAwesomeIcons.star,
                color: theme.colorScheme.primary, size: 50.h));
      }
    });

    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xFFC0C0C0),
            body: Center(
                child: Container(
                    width: 353.h,
                    height: 563.v,
                    decoration: AppDecoration.outlineGray.copyWith(
                        borderRadius: BorderRadiusStyle.circleBorder15),
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.h),
                        child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 35.v),
                              Text(widget.nameGame,
                                  style: CustomTextStyles.regular24Text),
                              SizedBox(height: 60.v),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Spacer(),
                                    SizedBox(width: 12.h),
                                    ...stars,
                                    Spacer()
                                  ]),
                              SizedBox(height: 60.v),
                              Row(children: [
                                Spacer(),
                                info_card("Попытки", "${widget.tries}"),
                                Spacer(),
                                info_card("Очки", "${widget.score}"),
                                Spacer(),
                                info_card("Время", "${widget.time}"),
                                Spacer(),
                              ]),
                              SizedBox(height: 60.v),
                              CustomElevatedButton(
                                text: "Переиграть",
                                buttonTextStyle:
                                    CustomTextStyles.semiBold18TextWhite,
                                buttonStyle: ElevatedButton.styleFrom(
                                    backgroundColor: theme.colorScheme.primary,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                                onTap: () {
                                  GoRouter.of(context).push(widget.goRoute);
                                },
                              ),
                              SizedBox(height: 24.v),
                              CustomElevatedButton(
                                  text: "Выход",
                                  buttonTextStyle:
                                      CustomTextStyles.semiBold18TextWhite,
                                  buttonStyle: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          theme.colorScheme.primary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                  onTap: () {
                                    GoRouter.of(context)
                                        .push(AppRoutes.homepage);
                                  })
                            ]))))));
  }
}
