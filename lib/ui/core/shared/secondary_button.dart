import 'package:app/ui/core/shared/base_button.dart';
import 'package:app/ui/core/themes/app_colors.dart';

class SecondaryButton extends BaseButton {
  SecondaryButton({
    super.key,
    super.onPressed,
    super.text,
    super.onLongPress,
    super.padding,
    super.width,
    super.height,
    super.leftIcon,
    super.loading = false,
    super.disabled = false,
    super.rounded = false,
    super.elevation,
    super.fontSize = 16,
  }) : super(
         backgroundColor: AppColors.white,
         textColor: AppColors.primary400,
         disabledBackgroundColor: AppColors.white.withAlpha(160),
         disabledTextColor: AppColors.primary400.withAlpha(160),
         hasBorder: true,
       );
}
