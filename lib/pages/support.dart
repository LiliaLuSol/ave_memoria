import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  late TextEditingController messageplaceholController;
  final msgFocusNode = FocusNode();

  @override
  void initState() {
    messageplaceholController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    messageplaceholController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                          text: "Обратная связь",
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
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.h, right: 20.h, top: 16.h),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Ваше сообщение",
                                            style: theme.textTheme.bodyMedium),
                                        SizedBox(height: 4.v),
                                        SingleChildScrollView(
                                            child: CustomTextFormField(
                                                controller:
                                                    messageplaceholController,
                                                focusNode: msgFocusNode,
                                                maxLines: 19,
                                                autofocus: false,
                                                hintText: "Сообщение...",
                                                textInputAction:
                                                    TextInputAction.done)),
                                        SizedBox(height: 100.v),
                                        CustomElevatedButton(
                                          text: "Отправить",
                                          buttonTextStyle: CustomTextStyles
                                              .semiBold18TextWhite,
                                          buttonStyle: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  theme.colorScheme.primary,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5))),
                                          onTap: () {
                                            context.showsnackbar(
                                                title: 'Сообщение отправлено!',
                                                color: Colors.grey);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ]))
                            ]))))));
  }
}
