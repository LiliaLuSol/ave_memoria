import 'package:ave_memoria/other/app_export.dart';
import 'package:flutter/material.dart';

class Article extends StatefulWidget {
  final String title;

  const Article({super.key, required this.title});

  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  late String image;
  late String text;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: false,
            appBar: CustomAppBar(
              height: 75.v,
              leadingWidth: double.maxFinite,
              leading: Padding(
                  padding: EdgeInsets.only(left: 20.h),
                  child: Row(children: [
                    AppbarIconbutton(
                        svgPath: ImageConstant.imgArrowleft,
                        margin: EdgeInsets.only(bottom: 4.v),
                        onTap: () {
                          Navigator.pop(context, true);
                        }),
                    AppbarSubtitle(
                      text: 'Библиотека',
                      margin: EdgeInsets.only(left: 16.h),
                    )
                  ])),
              styleType: Style.bgFill,
            ),
            body: Container(
                width: mediaQueryData.size.width,
                height: mediaQueryData.size.height,
                child: SizedBox(
                    width: double.maxFinite,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 75.v,
                          ),
                          Divider(height: 1, color: appTheme.gray),
                          SingleChildScrollView(
                            padding: EdgeInsets.all(16.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.title,
                                  style: CustomTextStyles.regular24Text,
                                ),
                                SizedBox(height: 16.h),
                                // if (imageUrl != null)
                                //   Image.network(
                                //     imageUrl!,
                                //     fit: BoxFit.cover,
                                //   ),
                                // SizedBox(height: 16),
                                // Text(
                                //   text,
                                //   style: TextStyle(fontSize: 16),
                                // ),
                              ],
                            ),
                          ),
                        ])))));
  }
}
