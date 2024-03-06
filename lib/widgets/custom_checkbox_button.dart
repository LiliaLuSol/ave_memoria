import 'package:ave_memoria/theme/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

class CustomCheckboxButton extends StatelessWidget {
  CustomCheckboxButton({
    Key? key,
    required this.onChange,
    this.decoration,
    this.alignment,
    this.isRightCheck,
    this.iconSize,
    this.value,
    this.text,
    this.width,
    this.margin,
    this.padding,
    required this.checkColor,
    this.fillColor,
    this.borderColor,
    this.textStyle,
    this.textAlignment,
    this.isExpandedText = false,
  }) : super(
          key: key,
        );

  final BoxDecoration? decoration;

  final Alignment? alignment;

  final bool? isRightCheck;

  final double? iconSize;

  bool? value;

  final Function(bool) onChange;

  final String? text;

  final double? width;

  final EdgeInsetsGeometry? margin;

  final EdgeInsetsGeometry? padding;

  final TextStyle? textStyle;

  final TextAlign? textAlignment;

  final bool isExpandedText;

  final Color checkColor;

  final Color? fillColor;

  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildCheckBoxWidget,
          )
        : buildCheckBoxWidget;
  }

  Widget get buildCheckBoxWidget => InkWell(
        onTap: () {
          value = !(value!);
          onChange(value!);
        },
        child: Container(
          decoration: decoration,
          width: width,
          margin: margin ?? EdgeInsets.zero,
          child: (isRightCheck ?? false) ? rightSideCheckbox : leftSideCheckbox,
        ),
      );

  Widget get leftSideCheckbox => Row(
        children: [
          Padding(
            child: checkboxWidget,
            padding: EdgeInsets.only(right: 8),
          ),
          isExpandedText ? Expanded(child: textWidget) : textWidget,
        ],
      );

  Widget get rightSideCheckbox => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isExpandedText ? Expanded(child: textWidget) : textWidget,
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: checkboxWidget,
          ),
        ],
      );

  Widget get textWidget => Text(
        text ?? "",
        textAlign: textAlignment ?? TextAlign.start,
        style: textStyle ?? theme.textTheme.bodyMedium,
      );

  Widget get checkboxWidget => SizedBox(
        height: iconSize ?? 28.h,
        width: iconSize ?? 28.h,
        child: Checkbox(
          // visualDensity: VisualDensity(
          //   vertical: -4,
          //   horizontal: -4,
          // ),
          visualDensity: VisualDensity.comfortable,
          value: value ?? false,
          onChanged: (value) {
            onChange(value!);
          },
          checkColor: checkColor,
          fillColor: MaterialStateProperty.resolveWith((states) => fillColor ?? appTheme.white),
          activeColor: appTheme.white,
          side: MaterialStateBorderSide.resolveWith(
                (states) => BorderSide(width: 1, color: appTheme.gray),
          ),
        ),
      );
}
