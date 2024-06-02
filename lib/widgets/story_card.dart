import 'package:ave_memoria/other/app_export.dart';
import 'package:flutter/cupertino.dart';

Widget story_card(BuildContext context,
    {required String svgPath, required dynamic gameData}) {
  List<Widget> stars = List.generate(3, (index) {
    if (index < gameData['stars']) {
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
      if (svgPath == ImageConstant.imgStoryL) const Spacer(),
      if (svgPath == ImageConstant.imgStoryL) CustomImageView(svgPath: svgPath),
      if (svgPath == ImageConstant.imgStoryL) const Spacer(),
      Container(
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
              Stack(children: [
                Column(children: [
                  Text(gameData['level_num'],
                      style: CustomTextStyles.extraBold16Text),
                  Text(gameData['level_name'],
                      style: CustomTextStyles.regular16Text),
                  SizedBox(height: 8.v),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      SizedBox(width: 12.h),
                      ...stars,
                      const Spacer(),
                    ],
                  ),
                ]),
                if (!gameData['is_available'])
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(
                      CupertinoIcons.lock_fill,
                      color: appTheme.gray,
                      size: 100.v,
                    )
                  ]),
                if (gameData['is_available'] && gameData['cond_start'] > 0 && !gameData['try'])
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(
                      CupertinoIcons.lock_open_fill,
                      color: appTheme.gray,
                      size: 100.v,
                    )
                  ]),
              ])
            ],
          ),
        ),
      ),
      if (svgPath == ImageConstant.imgStoryR) const Spacer(),
      if (svgPath == ImageConstant.imgStoryR) CustomImageView(svgPath: svgPath),
      if (svgPath == ImageConstant.imgStoryR) const Spacer(),
    ],
  );
}
