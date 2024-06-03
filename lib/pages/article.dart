import 'package:ave_memoria/other/app_export.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../main.dart';

class Article extends StatefulWidget {
  final String title;
  final int num;

  const Article({super.key, required this.title, required this.num});

  @override
  ArticleState createState() => ArticleState();
}

class ArticleState extends State<Article> {
  late String image;
  late String text;

  void getArticleSelfList() async {
    switch (widget.num) {
      case 1:
        final res = await supabase
            .from("Library")
            .select()
            .eq('title', widget.title)
            .single()
            .count(CountOption.exact);
        final data = res.data;
        setState(() {
          image = data['image'].toString();
          text = data['text'];
        });
        break;
      case 2:
        final res = await supabase
            .from("Store")
            .select()
            .eq('store_name', widget.title)
            .single()
            .count(CountOption.exact);
        final data = res.data;
        setState(() {
          image = data['image'].toString();
          text = data['text'];
        });
        break;
    }
  }

  @override
  void initState() {
    image = '';
    text = '';
    getArticleSelfList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return connected ? _articlePage(context) : const BuildNoInternet();
        },
        child: Center(
          child: CircularProgressIndicator(
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    ));
  }

  SafeArea _articlePage(BuildContext context) {
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
            body: SizedBox(
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
                          Expanded(
                              child: SingleChildScrollView(
                            padding: EdgeInsets.all(16.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.title,
                                  style: CustomTextStyles.regular24Text,
                                ),
                                SizedBox(height: 16.v),
                                if (image != 'null')
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    height: 353.v,
                                    width: 353.h,
                                  ),
                                SizedBox(height: 16.v),
                                Text(
                                  text,
                                  style: CustomTextStyles.regular16Text,
                                ),
                              ],
                            ),
                          )),
                        ])))));
  }
}
