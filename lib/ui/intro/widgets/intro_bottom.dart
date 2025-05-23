import 'package:app/helpers/errors.dart';
import 'package:app/helpers/toast.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/core/shared/flat_button.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:app/ui/core/shared/secondary_button.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:app/ui/intro/view_model/intro_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroBottom extends StatelessWidget {
  const IntroBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final introViewModel = context.watch<IntroViewModel>();
    bool isGoogleLoading = context.watch<AuthProvider>().isGoogleLoading;

    void onLoginWithGoogle() async {
      try {
        await context.read<AuthProvider>().signInWithGoogle();

        if (context.mounted) {
          context.pushReplacement(Routes.home);
        }
      } catch (e) {
        if (!context.mounted) return;
        Toast.error(context, getErrorMessage(e));
      }
    }

    return Column(
      children: [
        AnimatedSmoothIndicator(
          activeIndex: introViewModel.currentIndex,
          count: 3,
          effect: ExpandingDotsEffect(
            spacing: 8.0,
            radius: 40,
            dotWidth: 8,
            dotHeight: 8,
            dotColor: AppColors.grey,
            activeDotColor: AppColors.primary400,
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            Text(
              introViewModel.title,
              style: Font.primary(fontSize: 15, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'intro.description'.i18n(),
              style: Font.primary(fontSize: 13, fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            Hero(
              tag: 'primary-button',
              child: PrimaryButton(
                rounded: true,
                disabled: isGoogleLoading,
                onPressed: () {
                  context.push(Routes.cadastro);
                },
                text: 'intro.create_account'.i18n(),
              ),
            ),
            const SizedBox(height: 16),
            Hero(
              tag: 'login-button',
              child: SecondaryButton(
                rounded: true,
                disabled: isGoogleLoading,
                onPressed: () {
                  context.push(Routes.login);
                },
                text: 'common.login'.i18n(),
              ),
            ),
            const SizedBox(height: 32),
            FlatButton(
              loading: isGoogleLoading,
              onPressed: onLoginWithGoogle,
              text: 'intro.login_with_google'.i18n(),
              leftIcon: SvgPicture.asset('assets/images/icons/google.svg'),
            ),
          ],
        ),
      ],
    );
  }
}
