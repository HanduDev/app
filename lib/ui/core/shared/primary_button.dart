import 'package:app/ui/core/shared/base_button.dart';
import 'package:app/ui/core/themes/app_colors.dart';

class PrimaryButton extends BaseButton {
  PrimaryButton({
    super.key,
    super.onPressed,
    super.text,
    super.fontSize = 14,
    super.padding,
    super.onLongPress,
    super.width,
    super.leftIcon,
    super.height,
    super.loading = false,
    super.disabled = false,
    super.rounded = false,
    super.danger,
    super.elevation,
  }) : super(
         backgroundColor: danger ? AppColors.error : AppColors.primary400,
         textColor: AppColors.white,
         disabledBackgroundColor: AppColors.primary400.withAlpha(160),
         disabledTextColor: AppColors.white.withAlpha(160),
       );
}
