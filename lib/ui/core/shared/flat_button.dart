import 'package:app/ui/core/shared/base_button.dart';
import 'package:app/ui/core/themes/app_colors.dart';

class FlatButton extends BaseButton {
  FlatButton({
    super.key,
    super.onPressed,
    super.text,
    super.onLongPress,
    super.width,
    super.height,
    super.loading = false,
    super.disabled = false,
    super.rightIcon,
    super.leftIcon,
  }) : super(
         rounded: false,
         backgroundColor: AppColors.transparent,
         textColor: AppColors.grey,
         disabledBackgroundColor: AppColors.transparent,
         elevation: 0,
         disabledTextColor: AppColors.grey.withAlpha(160),
       );
}
