import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';
import 'package:flutter/cupertino.dart';

Widget story_card(
    BuildContext context,
    {required String levelText,
    required String subText,
    required String svgPath,
    required int filledStars}) {
  List<Widget> stars = List.generate(3, (index) {
    if (index < filledStars) {
      return Padding(
          padding: EdgeInsets.only(right: 12.h),
          child: Icon(FontAwesomeIcons.solidStar,
              color: theme.colorScheme.primary, size: 16.h));
    } else {
      return Padding(
          padding: EdgeInsets.only(right: 12.h),
          child: Icon(FontAwesomeIcons.star,
              color: theme.colorScheme.primary, size: 16.h));
    }
  });

  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      if (svgPath == ImageConstant.imgStoryL) Spacer(),
      if (svgPath == ImageConstant.imgStoryL) CustomImageView(svgPath: svgPath),
      if (svgPath == ImageConstant.imgStoryL) Spacer(),
      GestureDetector(
        onTap: () {
          GoRouter.of(context)
              .push(AppRoutes.dialog);
        },
        child: Container(
          decoration: AppDecoration.outlineGray.copyWith(
            borderRadius: BorderRadiusStyle.circleBorder15,
          ),
          width: 170.h,
          height: 107.v,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(levelText, style: CustomTextStyles.extraBold16Text),
                Text(subText, style: CustomTextStyles.regular16Text),
                SizedBox(height: 8.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    SizedBox(width: 12.h),
                    ...stars,
                    Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      if (svgPath == ImageConstant.imgStoryR) Spacer(),
      if (svgPath == ImageConstant.imgStoryR) CustomImageView(svgPath: svgPath),
      if (svgPath == ImageConstant.imgStoryR) Spacer(),
    ],
  );
}
