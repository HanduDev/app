import 'package:app/ui/core/shared/base_button.dart';
import 'package:app/ui/core/themes/colors.dart';

class PrimaryButton extends BaseButton {
  PrimaryButton({
    super.key,
    super.onPressed,
    super.text,
    super.onLongPress,
    super.width,
    super.height,
    super.loading = false,
    super.disabled = false,
    super.rounded = false,
  }) : super(
          backgroundColor: AppColors.primary400,
          textColor: AppColors.white,
          disabledBackgroundColor: AppColors.primary400.withAlpha(160),
          disabledTextColor: AppColors.white.withAlpha(160),
        );
}
