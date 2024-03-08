import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

class CustomAlertDialog extends StatelessWidget {
  final String? title;
  final String? content;
  final  List<Widget>? actions;

  const CustomAlertDialog({
    Key? key,
    this.title,
    this.content,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: appTheme.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.h),
        side: BorderSide(color: appTheme.gray, width: 1),
      ),
      title: Text(
        title ?? "",
        style: CustomTextStyles.semiBold32Text,
        textAlign: TextAlign.center,
        ),
      content: Text(
        content ?? "",
        style: CustomTextStyles.regular16Text,
      ),
      actions: actions ?? [TextButton(onPressed: () {}, child: Text("Отмена", style: CustomTextStyles.regular16Primary))],
    );
  }
}