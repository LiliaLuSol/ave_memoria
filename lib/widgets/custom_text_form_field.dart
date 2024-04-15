import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key? key,
    this.alignment,
    this.width,
    this.height,
    this.margin,
    required this.controller,
    this.focusNode,
    this.autofocus = true,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    required this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.validator,
    this.onChanged,
    this.onSubmit,
    this.enableInteractiveSelection,
    this.enabled,
  }) : super(
          key: key,
        );

  final void Function(String)? onChanged;
  final void Function(String)? onSubmit;
  final Alignment? alignment;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? autofocus;
  final TextStyle? textStyle;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLines;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final EdgeInsets? contentPadding;
  final InputBorder? borderDecoration;
  final Color? fillColor;
  final bool? filled;
  final bool? enableInteractiveSelection;
  final bool? enabled;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget,
          )
        : textFormFieldWidget;
  }

  Widget get textFormFieldWidget => Container(
        width: width ?? double.maxFinite,
        margin: margin,
        height: height,
        child: TextFormField(
          controller: controller,
          onChanged: onChanged,
          onFieldSubmitted: onSubmit,
          focusNode: focusNode ?? FocusNode(),
          autofocus: autofocus!,
          style: textStyle ?? CustomTextStyles.regular16Text,
          obscureText: obscureText!,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          maxLines: maxLines ?? 1,
          decoration: decoration,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          textCapitalization: TextCapitalization.sentences,
          enableInteractiveSelection: enableInteractiveSelection,
          enabled: enabled,
          cursorColor: theme.colorScheme.primary
        ),
      );

  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        hintStyle: hintStyle ?? CustomTextStyles.regular16TextHint,
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        alignLabelWithHint: true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 16.v,
            ),
        fillColor: fillColor ?? appTheme.white,
        filled: filled,
        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.h),
              borderSide: BorderSide(
                color: appTheme.gray,
                width: 1,
              ),
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.h),
              borderSide: BorderSide(
                color: appTheme.gray,
                width: 1,
              ),
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.h),
              borderSide: BorderSide(
                color: appTheme.gray,
                width: 1,
              ),
            ),
      );
}
