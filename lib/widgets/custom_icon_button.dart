import 'package:flutter/material.dart';
import 'package:ave_memoria/other/app_export.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    Key? key,
    this.alignment,
    this.margin,
    this.height,
    this.width,
    this.padding,
    this.decoration,
    this.child,
    this.onTap,
  }) : super(
          key: key,
        );

  final Alignment? alignment;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final BoxDecoration? decoration;
  final Widget? child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: iconButtonWidget,
          )
        : iconButtonWidget;
  }

  Widget get iconButtonWidget => Padding(
        padding: margin ?? EdgeInsets.zero,
        child: SizedBox(
          height: height ?? 0,
          width: width ?? 0,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Container(
              padding: padding ?? EdgeInsets.zero,
              decoration: decoration ??
                  BoxDecoration(
                    borderRadius: BorderRadius.circular(10.h),
                    border: Border.all(
                      color: appTheme.gray,
                      width: 1.h,
                    ),
                  ),
              child: child,
            ),
            onPressed: onTap,
          ),
        ),
      );
}

extension IconButtonStyleHelper on CustomIconButton {
  static BoxDecoration get outlinePrimary => BoxDecoration(
        color: appTheme.gray,
        borderRadius: BorderRadius.circular(13.h),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.75),
          width: 2.h,
        ),
      );

  static BoxDecoration get outlineGray => BoxDecoration(
        borderRadius: BorderRadius.circular(10.h),
        border: Border.all(
          color: appTheme.gray,
          width: 1.h,
        ),
      );

  static BoxDecoration get outlineWhite => BoxDecoration(
        borderRadius: BorderRadius.circular(10.h),
        border: Border.all(
          color: appTheme.white,
          width: 1.h,
        ),
      );

  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: appTheme.white,
        borderRadius: BorderRadius.circular(10.h),
        border: Border.all(
          color: appTheme.gray,
          width: 1.h,
        ),
      );
}
