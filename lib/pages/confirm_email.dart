import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

class ConfirmEmail extends StatefulWidget {
  const ConfirmEmail({super.key});

  @override
  State<ConfirmEmail> createState() => _ConfirmEmailState();
}

class _ConfirmEmailState extends State<ConfirmEmail> {
  @override
  Widget build(BuildContext context) {
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
                    height: 45.v,
                    leadingWidth: double.maxFinite,
                    leading: AppbarIconbutton1(
                        svgPath: ImageConstant.imgArrowleft,
                        margin: EdgeInsets.only(left: 20.h, right: 333.h),
                        onTap: () {
                          GoRouter.of(context).push(AppRoutes.authreg);
                        })),
                body: Container(
                  child: Center(
                      child: Text(
                    "На ваш Email было отправлено письмо. Перейдите по ссылке для подтверждения...",
                    style: CustomTextStyles.extraBold32Text,
                    maxLines: 3,
                  )),
                ))));
  }
}
