import 'package:app/ui/core/shared/progress_bar.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class CardProgressBar extends StatelessWidget {
  final String title;
  final int id;
  final double progress;
  final String progressText;
  final String countryCode;
  final VoidCallback? onTap;

  const CardProgressBar({
    super.key,
    required this.title,
    required this.id,
    required this.progress,
    required this.progressText,
    required this.countryCode,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.primary500,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CountryFlag.fromLanguageCode(
                countryCode,
                height: 35,
                width: 50,
                shape: RoundedRectangle(8),
              ),
              const SizedBox(height: 6),
              Hero(
                tag: '$id-language',
                child: Material(
                  type: MaterialType.transparency,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              Hero(
                tag: '$id-progress',
                child: ProgressBar(
                  value: progress,
                  height: 8,
                  fullFillBackground: AppColors.green,
                ),
              ),

              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'educacao.progress'.i18n(),
                    style: TextStyle(fontSize: 12, color: AppColors.lightGrey),
                  ),
                  Expanded(child: const SizedBox.shrink()),
                  Hero(
                    tag: '$id-progress-text',
                    child: Text(
                      progressText,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.lightGrey,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
