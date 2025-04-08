import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:flutter/material.dart';

abstract class BaseButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final VoidCallback? onLongPress;
  final bool rounded;
  final bool disabled;
  final double? width;
  final double? height;
  final double? elevation;
  final bool loading;
  final Color backgroundColor;
  final Color textColor;
  final Color disabledBackgroundColor;
  final Color disabledTextColor;
  final bool hasBorder;
  final Widget? rightIcon;
  final Widget? leftIcon;
  final double fontSize;
  final EdgeInsets? padding;

  const BaseButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.fontSize = 16,
      required this.onLongPress,
      required this.rounded,
      required this.disabled,
      required this.width,
      required this.height,
      required this.loading,
      required this.backgroundColor,
      required this.textColor,
      required this.disabledBackgroundColor,
      required this.disabledTextColor,
      this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      this.hasBorder = false,
      this.rightIcon,
      this.leftIcon,
      this.elevation = 2});
      


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled || loading ? null : onPressed,
      onLongPress: onLongPress,
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: backgroundColor,
        overlayColor: AppColors.overlayColor,
        shadowColor: elevation == 0 ? AppColors.transparent : AppColors.black,
        surfaceTintColor: AppColors.transparent,
        disabledBackgroundColor: disabledBackgroundColor,
        disabledForegroundColor: disabledTextColor,
        padding: padding,
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rounded ? 50 : 8),
          side: hasBorder
              ? BorderSide(
                  color: disabled || loading ? disabledTextColor : textColor,
                  width: 2,
                )
              : BorderSide.none,
        ),
        minimumSize: Size(width ?? double.infinity, height ?? 44),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leftIcon != null && !loading) leftIcon!,
          if (leftIcon != null && !loading) const SizedBox(width: 8),
          if (loading)
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                  strokeWidth: 3, color: disabledTextColor),
            ),
          if (loading) const SizedBox(width: 8),
          Text(
            text ?? '',
            style: Font.primary(fontSize: fontSize, fontWeight: FontWeight.bold),
          ),
          if (rightIcon != null) const SizedBox(width: 8),
          if (rightIcon != null) rightIcon!,
        ],
      ),
    );
  }
}
